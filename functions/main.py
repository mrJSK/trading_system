from firebase_functions import https_fn, scheduler_fn
from firebase_admin import initialize_app, firestore, messaging
import requests
import re
import time
import random
from datetime import datetime, timedelta
from bs4 import BeautifulSoup
import json


# Initialize Firebase Admin SDK
initialize_app()


# Configuration - keep all your user agents
USER_AGENTS = [
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36',
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:126.0) Gecko/20100101 Firefox/126.0',
    'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36'
]


def get_db():
    """Get Firestore client"""
    return firestore.client()


# --- FCM NOTIFICATION FUNCTIONS ---
def send_job_notification(title, body, data=None):
    """Send FCM push notification to all subscribed devices"""
    try:
        message = messaging.Message(
            notification=messaging.Notification(title=title, body=body),
            topic='job_status',
            data=data or {},
            android=messaging.AndroidConfig(
                notification=messaging.AndroidNotification(
                    icon='ic_notification',
                    color='#4CAF50',
                    sound='default',
                    channel_id='job_notifications',
                ),
                priority='high',
            ),
        )
        response = messaging.send(message)
        return response
    except Exception:
        return None


def notify_job_complete(companies_processed, failed_count=0):
    """Send FCM notification when job completes"""
    if failed_count == 0:
        send_job_notification(
            title="🎉 Job Completed!",
            body=f"Successfully processed {companies_processed} companies with comprehensive data including historical trends and key insights",
            data={'type': 'job_completed', 'companies_processed': str(companies_processed)}
        )
    else:
        send_job_notification(
            title="⚠️ Job Completed with Issues",
            body=f"Processed {companies_processed} companies with enhanced data, {failed_count} failed",
            data={'type': 'job_completed_with_errors', 'companies_processed': str(companies_processed)}
        )


def notify_job_failed(error_message):
    """Send FCM notification when job fails"""
    send_job_notification(
        title="❌ Job Failed",
        body=f"Enhanced data job failed: {error_message}",
        data={'type': 'job_failed', 'error': str(error_message)}
    )


# --- NETWORKING FUNCTIONS (UNCHANGED) ---
def fetch_page(session, url, retries=3, backoff_factor=0.8, referer=None):
    """Fetches a URL using session with retry mechanism - NO LOGGING"""
    headers = {
        'User-Agent': random.choice(USER_AGENTS),
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
        'Accept-Language': 'en-US,en;q=0.9',
        'Connection': 'keep-alive',
        'Upgrade-Insecure-Requests': '1',
    }
    
    if referer:
        headers['Referer'] = referer
    
    for attempt in range(retries):
        try:
            response = session.get(url, headers=headers, timeout=30)
            response.raise_for_status()
            return response
        except Exception:
            if attempt < retries - 1:
                wait_time = backoff_factor * (2 ** attempt) + random.uniform(0, 1)
                time.sleep(wait_time)
    return None


# --- COMPLETE SYMBOL EXTRACTION (UNCHANGED) ---
def extract_symbol_from_page(soup, url):
    """Extract the actual stock symbol from the company page"""
    # Method 1: Try to get from NSE link
    nse_link = soup.select_one('a[href*="nseindia.com"]')
    if nse_link:
        nse_text = nse_link.get_text(strip=True)
        if 'NSE:' in nse_text:
            symbol = nse_text.replace('NSE:', '').strip()
            if symbol:
                return symbol
    
    # Method 2: Try to get from the URL structure
    url_parts = url.strip('/').split('/')
    if len(url_parts) >= 2:
        potential_symbol = url_parts[-2] if url_parts[-1] == 'consolidated' else url_parts[-1]
        if potential_symbol and potential_symbol != 'company':
            return potential_symbol
    
    # Method 3: Try to extract from page structure
    breadcrumb = soup.select_one('.breadcrumb')
    if breadcrumb:
        breadcrumb_text = breadcrumb.get_text(strip=True)
        symbol_match = re.search(r'\b([A-Z]{2,10})\b', breadcrumb_text)
        if symbol_match:
            return symbol_match.group(1)
    
    # Method 4: Extract from company nav or title
    company_nav = soup.select_one('.company-nav h1') or soup.select_one('h1.margin-0')
    if company_nav:
        nav_text = company_nav.get_text(strip=True)
        symbol_match = re.search(r'^([A-Z]{2,10})', nav_text)
        if symbol_match:
            return symbol_match.group(1)
    
    return None


# --- COMPLETE PARSING FUNCTIONS (RESTORED) ---
def clean_text(text, field_name=""):
    """Clean and format text data"""
    if not text:
        return None
    
    if field_name in ["bse_code", "nse_code"]:
        return text.strip().replace('BSE:', '').replace('NSE:', '').strip()
    
    return text.strip().replace('₹', '').replace(',', '').replace('%', '').replace('Cr.', '').strip()


def parse_number(text):
    """Parse numeric values from text"""
    cleaned = clean_text(text)
    if cleaned in [None, '']:
        return None
    
    match = re.search(r'[-+]?\d*\.\d+|\d+', cleaned)
    if match:
        try:
            return float(match.group(0))
        except (ValueError, TypeError):
            return None
    return None


def get_calendar_sort_key(header_string):
    """Sort calendar headers"""
    MONTH_MAP = {
        'Jan': 1, 'Feb': 2, 'Mar': 3, 'Apr': 4, 'May': 5, 'Jun': 6,
        'Jul': 7, 'Aug': 8, 'Sep': 9, 'Oct': 10, 'Nov': 11, 'Dec': 12
    }
    
    try:
        month_str, year_str = header_string.strip().split()
        return (int(year_str), MONTH_MAP.get(month_str, 0))
    except (ValueError, KeyError, IndexError):
        try:
            return (int(header_string), 0)
        except (ValueError, TypeError):
            return (0, 0)


def parse_website_link(soup):
    """Parse company website"""
    company_links_div = soup.select_one('div.company-links')
    if not company_links_div:
        return None
    
    all_links = company_links_div.find_all('a', href=True)
    for link in all_links:
        href = link['href']
        if 'bseindia.com' not in href and 'nseindia.com' not in href:
            return href
    return None


def parse_financial_table(soup, table_id):
    """Parse financial tables - COMPLETE VERSION"""
    section = soup.select_one(f'section#{table_id}')
    if not section:
        return {}
    
    table = section.select_one('table.data-table')
    if not table:
        return {}
    
    original_headers = [th.get_text(strip=True) for th in table.select('thead th')][1:]
    if not original_headers:
        return {}
    
    sorted_headers = sorted(original_headers, key=get_calendar_sort_key, reverse=True)
    
    body_data = []
    for row in table.select('tbody tr'):
        cols = row.select('td')
        if not cols or 'sub' in row.get('class', []):
            continue
        
        row_name = cols[0].get_text(strip=True).replace('+', '').strip()
        if not row_name:
            continue
        
        original_values = [col.get_text(strip=True) for col in cols[1:]]
        value_map = dict(zip(original_headers, original_values))
        sorted_values = [value_map.get(h, '') for h in sorted_headers]
        
        body_data.append({
            'Description': row_name,
            'values': sorted_values
        })
    
    return {
        'headers': sorted_headers,
        'body': body_data
    }


def parse_shareholding_table(soup, table_id):
    """Parse shareholding tables - COMPLETE VERSION"""
    table = soup.select_one(f'div#{table_id} table.data-table')
    if not table:
        return {}
    
    original_headers = [th.get_text(strip=True) for th in table.select('thead th')][1:]
    sorted_headers = sorted(original_headers, key=get_calendar_sort_key, reverse=True)
    
    data = {}
    for row in table.select('tbody tr'):
        cols = row.select('td')
        if not cols or 'sub' in row.get('class', []):
            continue
        
        row_name = cols[0].get_text(strip=True).replace('+', '').strip()
        if not row_name:
            continue
        
        original_values = [col.get_text(strip=True) for col in cols[1:]]
        value_map = dict(zip(original_headers, original_values))
        row_data = {h: value_map.get(h, '') for h in sorted_headers}
        data[row_name] = row_data
    
    return data


def parse_growth_tables(soup):
    """Parse growth tables - COMPLETE VERSION"""
    data = {}
    pl_section = soup.select_one('section#profit-loss')
    if not pl_section:
        return data
    
    tables = pl_section.select('table.ranges-table')
    for table in tables:
        title_elem = table.select_one('th')
        if title_elem:
            title = title_elem.get_text(strip=True).replace(':', '')
            table_data = {}
            
            for row in table.select('tr')[1:]:
                cols = row.select('td')
                if len(cols) == 2:
                    key = cols[0].get_text(strip=True).replace(':', '')
                    value = cols[1].get_text(strip=True)
                    table_data[key] = value
            
            data[title] = table_data
    
    return data


def process_industry_path(soup):
    """Process industry classification - COMPLETE VERSION"""
    peers_section = soup.select_one('section#peers')
    if not peers_section:
        return None
    
    path_paragraph = peers_section.select_one('p.sub:not(#benchmarks)')
    if not path_paragraph:
        return None
    
    path_links = path_paragraph.select('a')
    if not path_links:
        return None
    
    path_names = [link.get_text(strip=True).replace('&amp;', 'and') for link in path_links]
    return path_names


# --- NEW: ENHANCED HISTORY EXTRACTION ---
def build_annual_history_from_table(financial_table):
    """Build comprehensive annual history data from financial table"""
    try:
        if not financial_table or 'headers' not in financial_table:
            return []
        
        headers = financial_table['headers']
        body_data = financial_table['body']
        
        annual_history = []
        
        for i, header in enumerate(headers):
            year_match = re.search(r'(\d{4})', header)
            if not year_match:
                continue
                
            year = int(year_match.group(1))
            
            annual_data = {
                'year': year,
                'period': header,
                'index': i
            }
            
            # Extract key financial metrics
            for row in body_data:
                description = row['Description'].lower()
                values = row['values']
                
                if i < len(values):
                    value = values[i]
                    numeric_value = parse_number(value)
                    
                    # Sales/Revenue
                    if any(keyword in description for keyword in ['sales', 'revenue', 'income from operations']):
                        annual_data['sales'] = numeric_value
                        annual_data['sales_text'] = value
                    
                    # Net Profit
                    elif any(keyword in description for keyword in ['net profit', 'profit after tax', 'net income']):
                        annual_data['net_profit'] = numeric_value
                        annual_data['net_profit_text'] = value
                    
                    # EBITDA
                    elif 'ebitda' in description:
                        annual_data['ebitda'] = numeric_value
                        annual_data['ebitda_text'] = value
                    
                    # Operating Profit
                    elif any(keyword in description for keyword in ['operating profit', 'ebit']):
                        annual_data['operating_profit'] = numeric_value
                        annual_data['operating_profit_text'] = value
                    
                    # Total Assets
                    elif 'total assets' in description:
                        annual_data['total_assets'] = numeric_value
                        annual_data['total_assets_text'] = value
                    
                    # Total Liabilities
                    elif 'total liabilities' in description:
                        annual_data['total_liabilities'] = numeric_value
                        annual_data['total_liabilities_text'] = value
                    
                    # Shareholders Equity
                    elif any(keyword in description for keyword in ['shareholders equity', 'net worth', 'equity']):
                        annual_data['shareholders_equity'] = numeric_value
                        annual_data['shareholders_equity_text'] = value
                    
                    # EPS
                    elif 'eps' in description or 'earnings per share' in description:
                        annual_data['eps'] = numeric_value
                        annual_data['eps_text'] = value
            
            annual_history.append(annual_data)
        
        # Sort by year (most recent first)
        annual_history.sort(key=lambda x: x['year'], reverse=True)
        
        # Calculate year-over-year growth rates
        for i in range(len(annual_history) - 1):
            current = annual_history[i]
            previous = annual_history[i + 1]
            
            # Sales growth
            if current.get('sales') and previous.get('sales') and previous['sales'] != 0:
                growth = ((current['sales'] - previous['sales']) / previous['sales']) * 100
                current['sales_growth_yoy'] = round(growth, 2)
            
            # Profit growth
            if current.get('net_profit') and previous.get('net_profit') and previous['net_profit'] != 0:
                growth = ((current['net_profit'] - previous['net_profit']) / previous['net_profit']) * 100
                current['profit_growth_yoy'] = round(growth, 2)
            
            # EBITDA growth
            if current.get('ebitda') and previous.get('ebitda') and previous['ebitda'] != 0:
                growth = ((current['ebitda'] - previous['ebitda']) / previous['ebitda']) * 100
                current['ebitda_growth_yoy'] = round(growth, 2)
        
        return annual_history
        
    except Exception:
        return []


def build_quarterly_history_from_table(quarterly_table):
    """Build comprehensive quarterly history data from quarterly table"""
    try:
        if not quarterly_table or 'headers' not in quarterly_table:
            return []
        
        headers = quarterly_table['headers']
        body_data = quarterly_table['body']
        
        quarterly_history = []
        
        for i, header in enumerate(headers):
            quarter_data = {
                'quarter': header,
                'index': i
            }
            
            # Extract key quarterly metrics
            for row in body_data:
                description = row['Description'].lower()
                values = row['values']
                
                if i < len(values):
                    value = values[i]
                    numeric_value = parse_number(value)
                    
                    # Sales
                    if any(keyword in description for keyword in ['sales', 'revenue', 'income from operations']):
                        quarter_data['sales'] = numeric_value
                        quarter_data['sales_text'] = value
                    
                    # Net Profit
                    elif any(keyword in description for keyword in ['net profit', 'profit after tax']):
                        quarter_data['net_profit'] = numeric_value
                        quarter_data['net_profit_text'] = value
                    
                    # EBITDA
                    elif 'ebitda' in description:
                        quarter_data['ebitda'] = numeric_value
                        quarter_data['ebitda_text'] = value
                    
                    # EPS
                    elif 'eps' in description:
                        quarter_data['eps'] = numeric_value
                        quarter_data['eps_text'] = value
                    
                    # Operating Profit
                    elif any(keyword in description for keyword in ['operating profit', 'ebit']):
                        quarter_data['operating_profit'] = numeric_value
                        quarter_data['operating_profit_text'] = value
            
            quarterly_history.append(quarter_data)
        
        # Calculate quarter-over-quarter growth rates
        for i in range(len(quarterly_history) - 1):
            current = quarterly_history[i]
            previous = quarterly_history[i + 1]
            
            # Sales growth QoQ
            if current.get('sales') and previous.get('sales') and previous['sales'] != 0:
                growth = ((current['sales'] - previous['sales']) / previous['sales']) * 100
                current['sales_growth_qoq'] = round(growth, 2)
            
            # Profit growth QoQ
            if current.get('net_profit') and previous.get('net_profit') and previous['net_profit'] != 0:
                growth = ((current['net_profit'] - previous['net_profit']) / previous['net_profit']) * 100
                current['profit_growth_qoq'] = round(growth, 2)
        
        return quarterly_history
        
    except Exception:
        return []


# --- NEW: ENHANCED KEY POINTS EXTRACTION ---
def extract_company_key_points(soup):
    """Extract comprehensive key points and insights about the company"""
    try:
        key_points = {
            'business_highlights': [],
            'financial_strengths': [],
            'risk_factors': [],
            'competitive_advantages': [],
            'recent_developments': [],
            'management_insights': []
        }
        
        # Extract from pros section (strengths)
        pros_section = soup.select('.pros ul li')
        for pro in pros_section:
            text = pro.get_text(strip=True)
            if text:
                # Categorize pros into different types
                if any(keyword in text.lower() for keyword in ['market', 'leader', 'dominant', 'share']):
                    key_points['competitive_advantages'].append({
                        'type': 'market_position',
                        'description': text,
                        'impact': 'positive'
                    })
                elif any(keyword in text.lower() for keyword in ['profit', 'margin', 'revenue', 'growth']):
                    key_points['financial_strengths'].append({
                        'type': 'financial_performance',
                        'description': text,
                        'impact': 'positive'
                    })
                else:
                    key_points['business_highlights'].append({
                        'type': 'operational_strength',
                        'description': text,
                        'impact': 'positive'
                    })
        
        # Extract from cons section (risks)
        cons_section = soup.select('.cons ul li')
        for con in cons_section:
            text = con.get_text(strip=True)
            if text:
                key_points['risk_factors'].append({
                    'type': 'business_risk',
                    'description': text,
                    'impact': 'negative',
                    'severity': 'medium'
                })
        
        # Extract business description insights
        about_section = soup.select_one('.company-profile .about')
        if about_section:
            about_text = about_section.get_text(strip=True)
            
            # Extract key business insights from description
            business_keywords = ['leading', 'largest', 'pioneer', 'established', 'manufacturing', 'services']
            for keyword in business_keywords:
                if keyword in about_text.lower():
                    sentences = about_text.split('.')
                    for sentence in sentences:
                        if keyword in sentence.lower() and len(sentence.strip()) > 20:
                            key_points['business_highlights'].append({
                                'type': 'business_description',
                                'description': sentence.strip(),
                                'impact': 'informational'
                            })
                            break
        
        # Extract recent quarterly performance insights
        quarterly_section = soup.select_one('section#quarters')
        if quarterly_section:
            recent_performance = extract_recent_quarter_performance(quarterly_section)
            if recent_performance:
                key_points['recent_developments'].append({
                    'type': 'quarterly_performance',
                    'description': f"Latest quarter ({recent_performance.get('quarter', 'N/A')}) performance data available",
                    'data': recent_performance,
                    'impact': 'informational'
                })
        
        # Extract management and corporate governance insights
        if soup.select_one('.management-discussion') or soup.select_one('.corporate-governance'):
            key_points['management_insights'].append({
                'type': 'governance',
                'description': 'Management discussion and corporate governance information available',
                'impact': 'informational'
            })
        
        return key_points
        
    except Exception:
        return {
            'business_highlights': [],
            'financial_strengths': [],
            'risk_factors': [],
            'competitive_advantages': [],
            'recent_developments': [],
            'management_insights': []
        }


def extract_recent_quarter_performance(quarterly_section):
    """Extract recent quarter performance data"""
    try:
        table = quarterly_section.select_one('table.data-table')
        if not table:
            return None
            
        headers = [th.get_text(strip=True) for th in table.select('thead th')][1:]
        if not headers:
            return None
            
        # Get latest quarter data (first column after description)
        latest_quarter = headers[0] if headers else None
        performance_data = {
            'quarter': latest_quarter,
            'metrics': {}
        }
        
        # Extract key metrics for latest quarter
        rows = table.select('tbody tr')
        for row in rows:
            cells = row.select('td')
            if len(cells) >= 2:
                metric = cells[0].get_text(strip=True).lower()
                value = cells[1].get_text(strip=True)
                
                if any(keyword in metric for keyword in ['sales', 'revenue']):
                    performance_data['metrics']['sales'] = value
                elif 'net profit' in metric:
                    performance_data['metrics']['net_profit'] = value
                elif 'eps' in metric:
                    performance_data['metrics']['eps'] = value
                elif 'ebitda' in metric:
                    performance_data['metrics']['ebitda'] = value
        
        return performance_data
        
    except Exception:
        return None


# --- NEW: INVESTMENT HIGHLIGHTS EXTRACTION ---
def extract_investment_highlights(soup):
    """Extract investment highlights and key factors"""
    try:
        highlights = []
        
        # Extract from financial ratios for investment appeal
        ratios_section = soup.select('#top-ratios li')
        for ratio in ratios_section:
            name_elem = ratio.select_one('.name')
            value_elem = ratio.select_one('.value')
            
            if name_elem and value_elem:
                name = name_elem.get_text(strip=True).lower()
                value = value_elem.get_text(strip=True)
                numeric_value = parse_number(value)
                
                # Identify attractive investment metrics
                if 'roe' in name and numeric_value and numeric_value > 15:
                    highlights.append({
                        'category': 'profitability',
                        'title': 'Strong Return on Equity',
                        'description': f"ROE of {value} indicates efficient use of shareholders' equity",
                        'metric': {'name': 'ROE', 'value': value},
                        'impact': 'positive'
                    })
                elif 'roce' in name and numeric_value and numeric_value > 12:
                    highlights.append({
                        'category': 'profitability',
                        'title': 'Good Return on Capital Employed',
                        'description': f"ROCE of {value} shows effective capital utilization",
                        'metric': {'name': 'ROCE', 'value': value},
                        'impact': 'positive'
                    })
                elif 'dividend yield' in name and numeric_value and numeric_value > 2:
                    highlights.append({
                        'category': 'income',
                        'title': 'Attractive Dividend Yield',
                        'description': f"Dividend yield of {value} provides regular income",
                        'metric': {'name': 'Dividend Yield', 'value': value},
                        'impact': 'positive'
                    })
                elif 'p/e' in name and numeric_value and numeric_value < 15:
                    highlights.append({
                        'category': 'valuation',
                        'title': 'Reasonable Valuation',
                        'description': f"P/E ratio of {value} suggests reasonable valuation",
                        'metric': {'name': 'P/E Ratio', 'value': value},
                        'impact': 'positive'
                    })
        
        # Extract sector leadership and market position
        industry_path = process_industry_path(soup)
        if industry_path:
            highlights.append({
                'category': 'market_position',
                'title': 'Industry Classification',
                'description': f"Operates in {' → '.join(industry_path)} sector",
                'impact': 'informational',
                'data': industry_path
            })
        
        # Extract from pros as investment positives
        pros_count = len(soup.select('.pros ul li'))
        cons_count = len(soup.select('.cons ul li'))
        
        if pros_count > cons_count:
            highlights.append({
                'category': 'overall_assessment',
                'title': 'More Positives than Negatives',
                'description': f"{pros_count} positive factors vs {cons_count} concerns identified",
                'impact': 'positive'
            })
        
        # Market cap category highlight
        market_cap = None
        for li in soup.select('#top-ratios li'):
            name_elem = li.select_one('.name')
            value_elem = li.select_one('.value')
            if name_elem and 'market cap' in name_elem.get_text(strip=True).lower():
                market_cap = parse_number(value_elem.get_text(strip=True)) if value_elem else None
                break
        
        if market_cap:
            if market_cap >= 20000:
                highlights.append({
                    'category': 'market_cap',
                    'title': 'Large Cap Stock',
                    'description': f"Large cap company with stable market presence",
                    'impact': 'informational'
                })
            elif market_cap >= 5000:
                highlights.append({
                    'category': 'market_cap',
                    'title': 'Mid Cap Stock',
                    'description': f"Mid cap company with growth potential",
                    'impact': 'informational'
                })
            else:
                highlights.append({
                    'category': 'market_cap',
                    'title': 'Small Cap Stock',
                    'description': f"Small cap company with high growth potential",
                    'impact': 'informational'
                })
        
        return highlights[:8]  # Return top 8 highlights
        
    except Exception:
        return []


def parse_company_data(soup, symbol):
    """COMPLETE company data parsing with ENHANCED HISTORY AND KEY POINTS"""
    try:
        # Basic company info
        company_name_elem = soup.select_one('h1.margin-0') or soup.select_one('.company-nav h1')
        company_name = company_name_elem.get_text(strip=True) if company_name_elem else f"Company {symbol}"
        
        # Clean up company name for display
        display_name = re.sub(r'\s+(Ltd|Limited|Corporation|Corp|Inc)\.?$', '', company_name, flags=re.IGNORECASE).strip()
        
        # Ratios data
        ratios_data = {}
        for li in soup.select('#top-ratios li'):
            name_elem = li.select_one('.name')
            value_elem = li.select_one('.value')
            if name_elem and value_elem:
                ratios_data[name_elem.get_text(strip=True)] = value_elem.get_text(strip=True)
        
        # About section
        about_elem = soup.select_one('.company-profile .about p')
        about = about_elem.get_text(strip=True) if about_elem else None
        
        # Stock codes - improved extraction
        bse_link = soup.select_one('a[href*="bseindia.com"]')
        nse_link = soup.select_one('a[href*="nseindia.com"]')
        
        # Extract BSE code
        bse_code = None
        if bse_link:
            bse_text = bse_link.get_text(strip=True)
            bse_match = re.search(r'BSE:\s*(\d+)', bse_text)
            if bse_match:
                bse_code = bse_match.group(1)
        
        # Extract NSE code
        nse_code = None
        if nse_link:
            nse_text = nse_link.get_text(strip=True)
            nse_match = re.search(r'NSE:\s*([A-Z0-9]+)', nse_text)
            if nse_match:
                nse_code = nse_match.group(1)
        
        # Use NSE code as symbol if available
        final_symbol = nse_code if nse_code else symbol
        
        # Pros and cons
        pros = [li.get_text(strip=True) for li in soup.select('.pros ul li')]
        cons = [li.get_text(strip=True) for li in soup.select('.cons ul li')]
        
        # Parse ALL financial tables
        quarterly_results = parse_financial_table(soup, 'quarters')
        profit_loss_statement = parse_financial_table(soup, 'profit-loss')
        balance_sheet = parse_financial_table(soup, 'balance-sheet')
        cash_flow_statement = parse_financial_table(soup, 'cash-flow')
        ratios = parse_financial_table(soup, 'ratios')
        
        # BUILD ENHANCED HISTORICAL DATA
        annual_history = build_annual_history_from_table(profit_loss_statement)
        quarterly_history = build_quarterly_history_from_table(quarterly_results)
        
        # EXTRACT ENHANCED KEY POINTS
        key_points = extract_company_key_points(soup)
        
        # EXTRACT INVESTMENT HIGHLIGHTS
        investment_highlights = extract_investment_highlights(soup)
        
        # Return COMPLETE data with ALL tables, ratios, and ENHANCED FEATURES
        return {
            'symbol': final_symbol,
            'name': company_name,
            'display_name': display_name,
            'about': about,
            'website': parse_website_link(soup),
            'bse_code': bse_code,
            'nse_code': final_symbol,
            'market_cap': parse_number(ratios_data.get('Market Cap')),
            'current_price': parse_number(ratios_data.get('Current Price')),
            'high_low': clean_text(ratios_data.get('High / Low')),
            'stock_pe': parse_number(ratios_data.get('Stock P/E')),
            'book_value': parse_number(ratios_data.get('Book Value')),
            'dividend_yield': parse_number(ratios_data.get('Dividend Yield')),
            'roce': parse_number(ratios_data.get('ROCE')),
            'roe': parse_number(ratios_data.get('ROE')),
            'face_value': parse_number(ratios_data.get('Face Value')),
            'pros': pros,
            'cons': cons,
            'last_updated': datetime.now().isoformat(),
            'change_percent': 0.0,
            'change_amount': 0.0,
            'previous_close': parse_number(ratios_data.get('Current Price', '0.0')) or 0.0,
            
            # ALL FINANCIAL STATEMENTS - COMPLETE DATA
            'quarterly_results': quarterly_results,
            'profit_loss_statement': profit_loss_statement,
            'balance_sheet': balance_sheet,
            'cash_flow_statement': cash_flow_statement,
            'ratios': ratios,
            
            # ENHANCED HISTORICAL DATA
            'annual_data_history': annual_history,
            'quarterly_data_history': quarterly_history,
            
            # ENHANCED KEY POINTS AND INSIGHTS
            'company_key_points': key_points,
            'investment_highlights': investment_highlights,
            
            # INDUSTRY AND SHAREHOLDING - COMPLETE DATA
            'industry_classification': process_industry_path(soup),
            'shareholding_pattern': {
                'quarterly': parse_shareholding_table(soup, 'quarterly-shp')
            },
            
            # GROWTH TABLES - COMPLETE DATA
            **parse_growth_tables(soup),
            
            # RAW RATIOS DATA - COMPLETE DATA
            'ratios_data': ratios_data,
            
            # METADATA
            'data_version': 'enhanced_v2.0_with_history_and_keypoints',
            'extraction_timestamp': datetime.now().isoformat()
        }
        
    except Exception:
        return None


# --- QUEUE STATUS FUNCTIONS (RESTORED) ---
def get_queue_status(db):
    """Get current queue status"""
    try:
        pending_count = len(list(db.collection('scraping_queue').where('status', '==', 'pending').limit(1000).stream()))
        processing_count = len(list(db.collection('scraping_queue').where('status', '==', 'processing').limit(1000).stream()))
        completed_count = len(list(db.collection('scraping_queue').where('status', '==', 'completed').limit(1000).stream()))
        failed_count = len(list(db.collection('scraping_queue').where('status', '==', 'failed').limit(1000).stream()))
        
        return {
            'pending': pending_count,
            'processing': processing_count,
            'completed': completed_count,
            'failed': failed_count,
            'total': pending_count + processing_count + completed_count + failed_count,
            'is_active': processing_count > 0 or pending_count > 0,
            'is_completed': pending_count == 0 and processing_count == 0 and completed_count > 0,
            'progress_percentage': ((completed_count + failed_count) / max(1, pending_count + processing_count + completed_count + failed_count)) * 100,
            'status_text': 'Enhanced Processing Active' if processing_count > 0 or pending_count > 0 else ('Enhanced Data Complete' if completed_count > 0 else 'Ready for Enhanced Scraping'),
            'timestamp': datetime.now().isoformat()
        }
    except Exception as e:
        return {'error': str(e)}


def cleanup_old_queue_items(db):
    """Clean up old completed and failed queue items - NO LOGGING"""
    try:
        cutoff_date = datetime.now() - timedelta(days=7)
        cutoff_iso = cutoff_date.isoformat()
        
        # Delete old completed items
        completed_docs = db.collection('scraping_queue')\
                          .where('status', '==', 'completed')\
                          .where('completed_at', '<', cutoff_iso)\
                          .limit(100)\
                          .stream()
        
        batch = db.batch()
        count = 0
        for doc in completed_docs:
            batch.delete(doc.reference)
            count += 1
        
        if count > 0:
            batch.commit()
        
        # Delete old failed items
        failed_docs = db.collection('scraping_queue')\
                     .where('status', '==', 'failed')\
                     .where('failed_at', '<', cutoff_iso)\
                     .limit(100)\
                     .stream()
        
        batch = db.batch()
        count = 0
        for doc in failed_docs:
            batch.delete(doc.reference)
            count += 1
        
        if count > 0:
            batch.commit()
            
    except Exception:
        pass


def reset_stale_processing_items(db):
    """Reset items that have been processing for too long - NO LOGGING"""
    try:
        cutoff_time = datetime.now() - timedelta(minutes=30)
        cutoff_iso = cutoff_time.isoformat()
        
        stale_docs = db.collection('scraping_queue')\
                      .where('status', '==', 'processing')\
                      .where('started_at', '<', cutoff_iso)\
                      .limit(50)\
                      .stream()
        
        batch = db.batch()
        count = 0
        for doc in stale_docs:
            batch.update(doc.reference, {
                'status': 'pending',
                'started_at': firestore.DELETE_FIELD,
                'reset_count': firestore.Increment(1),
                'reset_at': datetime.now().isoformat()
            })
            count += 1
        
        if count > 0:
            batch.commit()
            
    except Exception:
        pass


# --- HTTP FUNCTIONS (COMPLETE, NO LOGGING) ---
@https_fn.on_request()
def queue_scraping_jobs(req: https_fn.Request) -> https_fn.Response:
    """Queue individual scraping jobs for processing - NO LOGGING"""
    try:
        headers = {
            'Access-Control-Allow-Origin': '*',
            'Content-Type': 'application/json'
        }
        
        if req.method == 'OPTIONS':
            headers.update({
                'Access-Control-Allow-Methods': 'POST',
                'Access-Control-Allow-Headers': 'Content-Type',
                'Access-Control-Max-Age': '3600'
            })
            return https_fn.Response('', status=204, headers=headers)
        
        db = get_db()
        
        try:
            request_json = req.get_json() or {}
        except Exception:
            request_json = {}
        
        clear_queue = request_json.get('clear_existing', False)
        max_pages = request_json.get('max_pages', 200)
        
        if clear_queue:
            # Clear existing pending and failed items
            for status in ['pending', 'failed']:
                docs = db.collection('scraping_queue').where('status', '==', status).limit(500).stream()
                batch = db.batch()
                count = 0
                for doc in docs:
                    batch.delete(doc.reference)
                    count += 1
                    if count >= 500:
                        batch.commit()
                        batch = db.batch()
                        count = 0
                if count > 0:
                    batch.commit()
        
        # Collect URLs
        company_urls = []
        
        with requests.Session() as session:
            for page in range(1, max_pages + 1):
                list_url = f"https://www.screener.in/screens/515361/largecaptop-100midcap101-250smallcap251/?page={page}"
                response = fetch_page(session, list_url)
                
                if not response:
                    break
                
                list_soup = BeautifulSoup(response.content, 'lxml')
                rows = list_soup.select('table.data-table tr[data-row-company-id]')
                
                if not rows:
                    break
                
                for row in rows:
                    link_tag = row.select_one('a')
                    if link_tag and link_tag.get('href'):
                        company_url = f"https://www.screener.in{link_tag['href']}"
                        company_urls.append(company_url)
                
                time.sleep(random.uniform(1, 3))
        
        if not company_urls:
            notify_job_failed("No company URLs found")
            return https_fn.Response(
                json.dumps({'status': 'error', 'message': 'No company URLs found to queue'}),
                status=400, headers=headers
            )
        
        # Add URLs to Firestore queue in batches
        batch_size = 500
        total_queued = 0
        
        for i in range(0, len(company_urls), batch_size):
            batch = db.batch()
            batch_urls = company_urls[i:i + batch_size]
            
            for url in batch_urls:
                doc_ref = db.collection('scraping_queue').document()
                batch.set(doc_ref, {
                    'url': url,
                    'status': 'pending',
                    'created_at': datetime.now().isoformat(),
                    'priority': 'normal',
                    'retry_count': 0,
                    'max_retries': 3,
                    'scraper_version': 'enhanced_v2.0_with_history_and_keypoints'
                })
            
            batch.commit()
            total_queued += len(batch_urls)
        
        return https_fn.Response(
            json.dumps({
                'status': 'success',
                'message': f'Successfully queued {total_queued} companies for ENHANCED data scraping with comprehensive history and key points',
                'queued_count': total_queued,
                'pages_processed': max_pages,
                'enhanced_features': [
                    'Annual Historical Data with YoY Growth',
                    'Quarterly Historical Data with QoQ Growth',
                    'Comprehensive Key Points Categorization',
                    'Investment Highlights Analysis',
                    'Business Strengths and Risk Assessment',
                    'Recent Quarter Performance Tracking',
                    'Market Position and Competitive Advantages',
                    'Complete Financial Statements'
                ],
                'timestamp': datetime.now().isoformat()
            }),
            status=200, headers=headers
        )
        
    except Exception as e:
        notify_job_failed(str(e))
        return https_fn.Response(
            json.dumps({'status': 'error', 'message': str(e)}),
            status=500, headers=headers
        )


@scheduler_fn.on_schedule(
    schedule="*/3 * * * *",
    timezone=scheduler_fn.Timezone("Asia/Kolkata")
)
def process_scraping_queue(event: scheduler_fn.ScheduledEvent) -> None:
    """Process items from scraping queue with ENHANCED data parsing including history and key points - NO LOGGING"""
    try:
        db = get_db()
        
        cleanup_old_queue_items(db)
        reset_stale_processing_items(db)
        
        queue_items = db.collection('scraping_queue')\
                       .where('status', '==', 'pending')\
                       .order_by('created_at')\
                       .limit(5)\
                       .stream()
        
        items_to_process = list(queue_items)
        
        if not items_to_process:
            return
        
        processed_count = 0
        failed_count = 0
        
        with requests.Session() as session:
            for doc in items_to_process:
                try:
                    data = doc.to_dict()
                    url = data['url']
                    retry_count = data.get('retry_count', 0)
                    max_retries = data.get('max_retries', 3)
                    
                    # Update status to processing
                    doc.reference.update({
                        'status': 'processing',
                        'started_at': datetime.now().isoformat(),
                        'processor_id': 'enhanced_scheduler_v2_with_history'
                    })
                    
                    response = fetch_page(session, url, retries=2)
                    
                    if response:
                        soup = BeautifulSoup(response.content, 'lxml')
                        symbol = extract_symbol_from_page(soup, url)
                        
                        if symbol:
                            # Check if company should be updated
                            existing_doc = db.collection('companies').document(symbol).get()
                            should_update = True
                            
                            if existing_doc.exists:
                                existing_data = existing_doc.to_dict()
                                last_updated = existing_data.get('last_updated')
                                if last_updated:
                                    try:
                                        last_update_time = datetime.fromisoformat(last_updated.replace('Z', '+00:00'))
                                        if datetime.now() - last_update_time < timedelta(hours=6):
                                            should_update = False
                                    except:
                                        pass
                            
                            if should_update:
                                # Parse ENHANCED company data with ALL tables, history, and key points
                                company_data = parse_company_data(soup, symbol)
                                if company_data:
                                    db.collection('companies').document(symbol).set(company_data)
                                    doc.reference.update({
                                        'status': 'completed',
                                        'completed_at': datetime.now().isoformat(),
                                        'symbol': symbol,
                                        'company_name': company_data.get('name', 'Unknown'),
                                        'enhancement_version': 'v2.0_with_history_and_keypoints',
                                        'features_extracted': [
                                            'annual_history_with_growth',
                                            'quarterly_history_with_growth', 
                                            'comprehensive_key_points',
                                            'investment_highlights',
                                            'business_strengths_analysis',
                                            'risk_factors_assessment',
                                            'recent_performance_tracking'
                                        ]
                                    })
                                    processed_count += 1
                                else:
                                    # Parsing failed, retry if possible
                                    if retry_count < max_retries:
                                        doc.reference.update({
                                            'status': 'pending',
                                            'retry_count': retry_count + 1,
                                            'last_retry': datetime.now().isoformat()
                                        })
                                    else:
                                        doc.reference.update({
                                            'status': 'failed',
                                            'failed_at': datetime.now().isoformat(),
                                            'error': 'Failed to parse enhanced company data with history'
                                        })
                                        failed_count += 1
                            else:
                                # Mark as completed (skipped due to recent update)
                                doc.reference.update({
                                    'status': 'completed',
                                    'completed_at': datetime.now().isoformat(),
                                    'symbol': symbol,
                                    'skipped_reason': 'Recently updated with enhanced data'
                                })
                        else:
                            # Symbol extraction failed, retry if possible
                            if retry_count < max_retries:
                                doc.reference.update({
                                    'status': 'pending',
                                    'retry_count': retry_count + 1,
                                    'last_retry': datetime.now().isoformat()
                                })
                            else:
                                doc.reference.update({
                                    'status': 'failed',
                                    'failed_at': datetime.now().isoformat(),
                                    'error': 'Could not extract symbol'
                                })
                                failed_count += 1
                    else:
                        # Page fetch failed, retry if possible
                        if retry_count < max_retries:
                            doc.reference.update({
                                'status': 'pending',
                                'retry_count': retry_count + 1,
                                'last_retry': datetime.now().isoformat()
                            })
                        else:
                            doc.reference.update({
                                'status': 'failed',
                                'failed_at': datetime.now().isoformat(),
                                'error': 'Failed to fetch page'
                            })
                            failed_count += 1
                    
                    time.sleep(random.uniform(2, 5))
                    
                except Exception:
                    try:
                        doc.reference.update({
                            'status': 'failed',
                            'failed_at': datetime.now().isoformat(),
                            'error': 'Processing error during enhanced extraction'
                        })
                        failed_count += 1
                    except:
                        pass
        
        # Send FCM notification for batch completion
        if processed_count > 0 or failed_count > 0:
            notify_job_complete(processed_count, failed_count)
        
    except Exception as e:
        notify_job_failed(str(e))


# --- QUEUE STATUS API (RESTORED) ---
@https_fn.on_request()
def get_queue_status_api(req: https_fn.Request) -> https_fn.Response:
    """HTTP function to get queue status"""
    try:
        headers = {
            'Access-Control-Allow-Origin': '*',
            'Content-Type': 'application/json'
        }
        
        if req.method == 'OPTIONS':
            headers.update({
                'Access-Control-Allow-Methods': 'GET',
                'Access-Control-Allow-Headers': 'Content-Type',
                'Access-Control-Max-Age': '3600'
            })
            return https_fn.Response('', status=204, headers=headers)
        
        db = get_db()
        status = get_queue_status(db)
        
        # Get recent completed items
        recent_completed = []
        try:
            completed_docs = db.collection('scraping_queue')\
                             .where('status', '==', 'completed')\
                             .order_by('completed_at', direction=firestore.Query.DESCENDING)\
                             .limit(10)\
                             .stream()
            
            for doc in completed_docs:
                data = doc.to_dict()
                recent_completed.append({
                    'symbol': data.get('symbol', 'Unknown'),
                    'company_name': data.get('company_name', 'Unknown'),
                    'completed_at': data.get('completed_at', ''),
                    'enhancement_version': data.get('enhancement_version', 'v2.0'),
                    'features_extracted': data.get('features_extracted', [])
                })
        except Exception:
            pass
        
        response_data = {
            'status': 'success',
            'queue_status': status,
            'recent_completed': recent_completed,
            'enhanced_features': [
                'Annual Historical Data with YoY Growth Calculations',
                'Quarterly Historical Data with QoQ Growth Tracking',  
                'Comprehensive Key Points in Multiple Categories',
                'Investment Highlights with Impact Assessment',
                'Business Strengths and Competitive Advantages',
                'Risk Factors and Concern Analysis',
                'Recent Quarter Performance Insights',
                'Management and Governance Information'
            ],
            'timestamp': datetime.now().isoformat()
        }
        
        return https_fn.Response(
            json.dumps(response_data),
            status=200, headers=headers
        )
        
    except Exception as e:
        return https_fn.Response(
            json.dumps({'status': 'error', 'message': str(e)}),
            status=500, headers=headers
        )


# --- QUEUE MANAGEMENT (RESTORED) ---
@https_fn.on_request()
def manage_queue(req: https_fn.Request) -> https_fn.Response:
    """HTTP function to manage queue (clear, retry)"""
    try:
        headers = {
            'Access-Control-Allow-Origin': '*',
            'Content-Type': 'application/json'
        }
        
        if req.method == 'OPTIONS':
            headers.update({
                'Access-Control-Allow-Methods': 'POST',
                'Access-Control-Allow-Headers': 'Content-Type',
                'Access-Control-Max-Age': '3600'
            })
            return https_fn.Response('', status=204, headers=headers)
        
        try:
            request_json = req.get_json() or {}
        except Exception:
            request_json = {}
        
        action = request_json.get('action')
        if not action:
            return https_fn.Response(
                json.dumps({'status': 'error', 'message': 'Action is required'}),
                status=400, headers=headers
            )
        
        db = get_db()
        
        if action == 'clear_failed':
            docs = db.collection('scraping_queue').where('status', '==', 'failed').limit(1000).stream()
            batch = db.batch()
            count = 0
            for doc in docs:
                batch.delete(doc.reference)
                count += 1
                if count >= 500:
                    batch.commit()
                    batch = db.batch()
                    count = 0
            if count > 0:
                batch.commit()
                
            return https_fn.Response(
                json.dumps({'status': 'success', 'message': f'Cleared {count} failed enhanced processing items'}),
                status=200, headers=headers
            )
        
        elif action == 'retry_failed':
            docs = db.collection('scraping_queue').where('status', '==', 'failed').limit(100).stream()
            batch = db.batch()
            count = 0
            for doc in docs:
                batch.update(doc.reference, {
                    'status': 'pending',
                    'retry_count': 0,
                    'failed_at': firestore.DELETE_FIELD,
                    'error': firestore.DELETE_FIELD,
                    'retried_at': datetime.now().isoformat()
                })
                count += 1
            if count > 0:
                batch.commit()
                
            return https_fn.Response(
                json.dumps({'status': 'success', 'message': f'Reset {count} failed items to pending for enhanced reprocessing'}),
                status=200, headers=headers
            )
        
        else:
            return https_fn.Response(
                json.dumps({'status': 'error', 'message': 'Invalid action'}),
                status=400, headers=headers
            )
        
    except Exception as e:
        return https_fn.Response(
            json.dumps({'status': 'error', 'message': str(e)}),
            status=500, headers=headers
        )


# --- LEGACY COMPATIBILITY (RESTORED) ---
@https_fn.on_request()
def manual_scrape_trigger(req: https_fn.Request) -> https_fn.Response:
    """HTTP function for backward compatibility"""
    try:
        headers = {
            'Access-Control-Allow-Origin': '*',
            'Content-Type': 'application/json'
        }
        
        if req.method == 'OPTIONS':
            headers.update({
                'Access-Control-Allow-Methods': 'POST',
                'Access-Control-Allow-Headers': 'Content-Type',
                'Access-Control-Max-Age': '3600'
            })
            return https_fn.Response('', status=204, headers=headers)
        
        try:
            request_json = req.get_json() or {}
        except Exception:
            request_json = {}
        
        if request_json.get('test', False):
            response_data = {
                'status': 'success',
                'message': 'ENHANCED data scraping system ready with comprehensive historical analysis and key insights',
                'enhanced_features': [
                    'Annual Historical Data with YoY Growth Calculations',
                    'Quarterly Historical Data with QoQ Tracking',
                    'Comprehensive Key Points Categorization',
                    'Investment Highlights with Impact Analysis', 
                    'Business Strengths Assessment',
                    'Risk Factors Identification',
                    'Recent Performance Insights',
                    'Competitive Advantages Analysis'
                ],
                'timestamp': datetime.now().isoformat(),
                'test_mode': True,
                'version': 'enhanced_v2.0_with_history_and_keypoints'
            }
            return https_fn.Response(
                json.dumps(response_data),
                status=200, headers=headers
            )
        
        db = get_db()
        status = get_queue_status(db)
        
        response_data = {
            'status': 'success',
            'message': 'ENHANCED comprehensive data scraping with complete financial statements, historical trends, and key business insights. Push notification will be sent when complete.',
            'current_queue_status': status,
            'enhanced_details': {
                'annual_history': 'Multi-year financial trends with growth calculations',
                'quarterly_history': 'Recent quarter performance with QoQ analysis',
                'key_points': 'Categorized business insights and competitive factors',
                'investment_highlights': 'Key factors for investment decision making',
                'risk_assessment': 'Identified business risks and concerns'
            },
            'timestamp': datetime.now().isoformat()
        }
        
        return https_fn.Response(
            json.dumps(response_data),
            status=200, headers=headers
        )
        
    except Exception as e:
        return https_fn.Response(
            json.dumps({'status': 'error', 'message': str(e)}),
            status=500, headers=headers
        )
