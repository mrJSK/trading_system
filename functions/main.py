from firebase_functions import https_fn, scheduler_fn
from firebase_admin import initialize_app, firestore, messaging
import requests
import re
import time
import random
from datetime import datetime
from bs4 import BeautifulSoup
import logging
import json

# Initialize Firebase Admin SDK
initialize_app()

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Configuration - Same as your Python code
USER_AGENTS = [
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36',
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:126.0) Gecko/20100101 Firefox/126.0',
    'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36'
]

def get_db():
    """Get Firestore client - called inside functions only"""
    return firestore.client()

# --- NETWORKING FUNCTIONS (From your Python code) ---

def fetch_page(session, url, retries=3, backoff_factor=0.8, referer=None):
    """Fetches a URL using session with retry mechanism - matches your Python code"""
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
        except Exception as e:
            logger.error(f"Attempt {attempt + 1} failed for {url}: {e}")
            if attempt < retries - 1:
                wait_time = backoff_factor * (2 ** attempt) + random.uniform(0, 1)
                time.sleep(wait_time)
            else:
                logger.error(f"Final attempt to fetch {url} failed.")
    return None

# --- PARSING FUNCTIONS (From your Python code) ---

def clean_text(text, field_name=""):
    """Clean and format text data - matches your Python implementation"""
    if not text:
        return None
    
    if field_name in ["bse_code", "nse_code"]:
        return text.strip().replace('BSE:', '').replace('NSE:', '').strip()
    
    return text.strip().replace('₹', '').replace(',', '').replace('%', '').replace('Cr.', '').strip()

def parse_number(text):
    """Parse numeric values from text - matches your Python implementation"""
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
    """Sort calendar headers - from your Python code"""
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
    """Parse company website - from your Python code"""
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
    """Parse financial tables - from your Python code"""
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
    """Parse shareholding tables - from your Python code"""
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
    """Parse growth tables - from your Python code"""
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
    """Process industry classification - simplified for Firestore"""
    peers_section = soup.select_one('section#peers')
    if not peers_section:
        return None
    
    path_paragraph = peers_section.select_one('p.sub:not(#benchmarks)')
    if not path_paragraph:
        return None
    
    path_links = path_paragraph.select('a')
    if not path_links:
        return None
    
    path_names = [link.get_text(strip=True).replace('&', 'and') for link in path_links]
    return path_names  # Return as array for Firestore

def parse_company_data(soup, symbol):
    """Complete company data parsing - matches your Python implementation"""
    try:
        # Basic company info
        company_name_elem = soup.select_one('h1.margin-0')
        company_name = company_name_elem.get_text(strip=True) if company_name_elem else symbol
        
        # Ratios data - same as your Python code
        ratios_data = {}
        for li in soup.select('#top-ratios li'):
            name_elem = li.select_one('.name')
            value_elem = li.select_one('.value')
            if name_elem and value_elem:
                ratios_data[name_elem.get_text(strip=True)] = value_elem.get_text(strip=True)
        
        # About section
        about_elem = soup.select_one('.company-profile .about p')
        about = about_elem.get_text(strip=True) if about_elem else None
        
        # Stock codes
        bse_link = soup.select_one('a[href*="bseindia.com"]')
        nse_link = soup.select_one('a[href*="nseindia.com"]')
        
        bse_code = clean_text(bse_link.get_text(strip=True) if bse_link else None, "bse_code")
        nse_code = clean_text(nse_link.get_text(strip=True) if nse_link else None, "nse_code")
        
        # Pros and cons
        pros = [li.get_text(strip=True) for li in soup.select('.pros ul li')]
        cons = [li.get_text(strip=True) for li in soup.select('.cons ul li')]
        
        # Complete financial data - same as your Python code
        return {
            'symbol': symbol,
            'name': company_name,
            'about': about,
            'website': parse_website_link(soup),
            'bse_code': bse_code,
            'nse_code': nse_code,
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
            
            # Financial statements - same as your Python code
            'quarterly_results': parse_financial_table(soup, 'quarters'),
            'profit_loss_statement': parse_financial_table(soup, 'profit-loss'),
            'balance_sheet': parse_financial_table(soup, 'balance-sheet'),
            'cash_flow_statement': parse_financial_table(soup, 'cash-flow'),
            'ratios': parse_financial_table(soup, 'ratios'),
            
            # Industry and shareholding
            'industry_classification': process_industry_path(soup),
            'shareholding_pattern': {
                'quarterly': parse_shareholding_table(soup, 'quarterly-shp')
            },
            
            # Growth tables
            **parse_growth_tables(soup),  # Merge growth data directly
            
            # Raw ratios data for reference
            'ratios_data': ratios_data
        }
        
    except Exception as e:
        logger.error(f"Error parsing company data for {symbol}: {e}")
        return None

def perform_comprehensive_scraping():
    """Complete scraping logic matching your Python implementation"""
    logger.info("Starting comprehensive company fundamentals scraping...")
    
    db = get_db()
    company_urls_to_scrape = []
    
    try:
        # Phase 1: Collect all company URLs - same logic as your Python code
        with requests.Session() as session:
            for page in range(1, 100):  # Comprehensive page range
                list_url = f"https://www.screener.in/screens/515361/largecaptop-100midcap101-250smallcap251/?page={page}"
                logger.info(f"Fetching company list from page {page}")
                
                response = fetch_page(session, list_url)
                if not response:
                    logger.warning(f"Could not fetch list page {page}. Stopping URL collection.")
                    break
                
                list_soup = BeautifulSoup(response.content, 'lxml')
                rows = list_soup.select('table.data-table tr[data-row-company-id]')
                
                if not rows:
                    logger.info("No more companies found. Moving to scraping phase.")
                    break
                
                for row in rows:
                    link_tag = row.select_one('a')
                    if link_tag and link_tag.get('href'):
                        company_urls_to_scrape.append(f"https://www.screener.in{link_tag['href']}")
                
                time.sleep(random.uniform(2, 4))  # Same delay as your Python code
            
            logger.info(f"Found {len(company_urls_to_scrape)} companies to scrape")
            
            # Phase 2: Scrape each company - comprehensive processing
            total_processed = 0
            batch_size = 10
            
            for i in range(0, len(company_urls_to_scrape), batch_size):
                batch = company_urls_to_scrape[i:i + batch_size]
                
                for url in batch:
                    try:
                        symbol = url.strip('/').split('/')[-1]
                        logger.info(f"Processing {symbol} ({total_processed + 1}/{len(company_urls_to_scrape)})")
                        
                        response = fetch_page(
                            session, 
                            url, 
                            referer="https://www.screener.in/screens/"
                        )
                        
                        if not response:
                            logger.warning(f"Failed to fetch data for {symbol}")
                            continue
                        
                        soup = BeautifulSoup(response.content, 'lxml')
                        company_data = parse_company_data(soup, symbol)
                        
                        if company_data:
                            # Store in Firestore with complete data
                            doc_ref = db.collection('companies').document(symbol)
                            doc_ref.set(company_data)
                            
                            logger.info(f"Successfully processed {symbol} with complete financial data")
                            total_processed += 1
                            
                            # Send notification for significant changes
                            send_company_update_notification(company_data, db)
                        
                        time.sleep(random.uniform(1.5, 3.5))  # Same timing as your Python code
                        
                    except Exception as e:
                        logger.error(f"Error processing {url}: {e}")
                
                # Batch delay
                time.sleep(random.uniform(5, 10))
            
            logger.info(f"Comprehensive scraping completed. Processed {total_processed} companies")
            return {'companies_processed': total_processed, 'status': 'success'}
    
    except Exception as e:
        logger.error(f"Error in comprehensive scraping: {e}")
        raise e

def send_company_update_notification(company_data, db):
    """Send notification for company updates"""
    try:
        current_price = company_data.get('current_price')
        if not current_price:
            return
        
        doc_ref = db.collection('companies').document(company_data['symbol'])
        existing_doc = doc_ref.get()
        
        if existing_doc.exists:
            existing_data = existing_doc.to_dict()
            old_price = existing_data.get('current_price')
            
            if old_price and current_price:
                change_percent = abs((current_price - old_price) / old_price * 100)
                
                if change_percent < 2:
                    return
        
        notification = messaging.Notification(
            title=f"Stock Update: {company_data['name']}",
            body=f"Current Price: ₹{current_price} | P/E: {company_data.get('stock_pe', 'N/A')}"
        )
        
        message = messaging.Message(
            notification=notification,
            data={
                'symbol': company_data['symbol'],
                'name': company_data['name'],
                'current_price': str(current_price),
                'market_cap': str(company_data.get('market_cap', '')),
                'pe': str(company_data.get('stock_pe', '')),
                'type': 'company_update'
            },
            topic='company_updates'
        )
        
        response = messaging.send(message)
        logger.info(f"Notification sent for {company_data['symbol']}: {response}")
        
    except Exception as e:
        logger.error(f"Error sending notification: {e}")

@scheduler_fn.on_schedule(
    schedule="0 */6 * * *",  # Every 6 hours
    timezone=scheduler_fn.Timezone("Asia/Kolkata")
)
def scrape_company_fundamentals(event: scheduler_fn.ScheduledEvent) -> None:
    """Scheduled function for comprehensive scraping"""
    try:
        result = perform_comprehensive_scraping()
        logger.info(f"Scheduled comprehensive scraping completed: {result}")
    except Exception as e:
        logger.error(f"Scheduled scraping failed: {e}")

@https_fn.on_request()
def manual_scrape_trigger(req: https_fn.Request) -> https_fn.Response:
    """HTTP function to manually trigger comprehensive scraping"""
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
        
        logger.info("Manual comprehensive scraping triggered via HTTP")
        
        try:
            request_json = req.get_json() or {}
        except Exception:
            request_json = {}
        
        if request_json.get('test', False):
            logger.info("Test request received")
            response_data = {
                'status': 'success',
                'message': 'Comprehensive scraping function is ready',
                'timestamp': datetime.now().isoformat(),
                'test_mode': True
            }
            return https_fn.Response(
                json.dumps(response_data),
                status=200,
                headers=headers
            )
        
        # Trigger comprehensive scraping
        result = perform_comprehensive_scraping()
        
        response_data = {
            'status': 'success',
            'message': 'Comprehensive fundamentals scraping completed successfully',
            'timestamp': datetime.now().isoformat(),
            'result': result
        }
        
        return https_fn.Response(
            json.dumps(response_data),
            status=200,
            headers=headers
        )
        
    except Exception as e:
        logger.error(f"Error in manual trigger: {e}")
        error_response = {
            'status': 'error',
            'message': str(e),
            'timestamp': datetime.now().isoformat()
        }
        return https_fn.Response(
            json.dumps(error_response),
            status=500,
            headers={'Access-Control-Allow-Origin': '*', 'Content-Type': 'application/json'}
        )

@https_fn.on_request()
def get_companies_data(req: https_fn.Request) -> https_fn.Response:
    """HTTP function to retrieve complete companies data"""
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
        
        limit = int(req.args.get('limit', '50'))
        symbol = req.args.get('symbol', None)
        
        companies_ref = db.collection('companies')
        
        if symbol:
            doc = companies_ref.document(symbol).get()
            if doc.exists:
                data = doc.to_dict()
                response = {
                    'status': 'success',
                    'data': data,
                    'timestamp': datetime.now().isoformat()
                }
                return https_fn.Response(
                    json.dumps(response, default=str),  # Handle datetime serialization
                    status=200,
                    headers=headers
                )
            else:
                error_response = {
                    'status': 'error',
                    'message': 'Company not found',
                    'timestamp': datetime.now().isoformat()
                }
                return https_fn.Response(
                    json.dumps(error_response),
                    status=404,
                    headers=headers
                )
        else:
            docs = companies_ref.limit(limit).stream()
            companies = []
            for doc in docs:
                data = doc.to_dict()
                data['id'] = doc.id
                companies.append(data)
            
            response = {
                'status': 'success',
                'data': companies,
                'count': len(companies),
                'timestamp': datetime.now().isoformat()
            }
            
            return https_fn.Response(
                json.dumps(response, default=str),  # Handle datetime serialization
                status=200,
                headers=headers
            )
        
    except Exception as e:
        logger.error(f"Error retrieving companies data: {e}")
        error_response = {
            'status': 'error',
            'message': str(e),
            'timestamp': datetime.now().isoformat()
        }
        return https_fn.Response(
            json.dumps(error_response),
            status=500,
            headers={'Access-Control-Allow-Origin': '*', 'Content-Type': 'application/json'}
        )
