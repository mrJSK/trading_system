from firebase_functions import https_fn, scheduler_fn
from firebase_admin import initialize_app, firestore, messaging
import requests
import re
import time
import random
from datetime import datetime, timedelta
from bs4 import BeautifulSoup
import json

# Initialize Firebase Admin SDK properly
try:
    initialize_app()
except ValueError:
    # Already initialized
    pass

# Configuration
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
        print(f"FCM notification sent: {response}")
        return response
    except Exception as e:
        print(f"FCM notification failed: {str(e)}")
        return None

def notify_job_complete(companies_processed, failed_count=0):
    """Send FCM notification when job completes"""
    if failed_count == 0:
        send_job_notification(
            title="🎉 Job Completed!",
            body=f"Successfully processed {companies_processed} companies with comprehensive data",
            data={'type': 'job_completed', 'companies_processed': str(companies_processed)}
        )
    else:
        send_job_notification(
            title="⚠ Job Completed with Issues",
            body=f"Processed {companies_processed} companies, {failed_count} failed",
            data={'type': 'job_completed_with_errors', 'companies_processed': str(companies_processed)}
        )

def notify_job_failed(error_message):
    """Send FCM notification when job fails"""
    send_job_notification(
        title="❌ Job Failed",
        body=f"Scraping job failed: {error_message}",
        data={'type': 'job_failed', 'error': str(error_message)}
    )

# --- NETWORKING FUNCTIONS ---
def fetch_page(session, url, retries=3, backoff_factor=0.8, referer=None):
    """Fetches a URL using session with retry mechanism"""
    headers = {
        'User-Agent': random.choice(USER_AGENTS),
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,/;q=0.8',
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
            print(f"Fetch attempt {attempt + 1} failed for {url}: {str(e)}")
            if attempt < retries - 1:
                wait_time = backoff_factor * (2 ** attempt) + random.uniform(0, 1)
                time.sleep(wait_time)
    return None

# --- UTILITY FUNCTIONS ---
def clean_text(text, field_name=""):
    """Clean and format text data"""
    if not text:
        return None
    
    if field_name in ["bse_code", "nse_code"]:
        return text.strip().replace('BSE:', '').replace('NSE:', '').strip()
    
    return text.strip().replace('₹', '').replace(',', '').replace('%', '').replace('Cr.', '').strip()

def parse_number(text):
    """Parse numeric values from text"""
    if not text:
        return None
        
    cleaned = clean_text(str(text))
    if cleaned in [None, '', 'N/A', '-']:
        return None
    
    # Handle negative numbers
    match = re.search(r'(-?\d*\.?\d+)', cleaned)
    if match:
        try:
            return float(match.group(1))
        except (ValueError, TypeError):
            return None
    return None

def get_calendar_sort_key(header_string):
    """Get sort key for calendar-based headers"""
    MONTH_MAP = {
        'Jan': 1, 'Feb': 2, 'Mar': 3, 'Apr': 4, 'May': 5, 'Jun': 6,
        'Jul': 7, 'Aug': 8, 'Sep': 9, 'Oct': 10, 'Nov': 11, 'Dec': 12
    }
    try:
        month_str, year_str = header_string.strip().split()
        return (int(year_str), MONTH_MAP.get(month_str, 0))
    except Exception:
        try:
            return (int(header_string), 0)
        except Exception:
            return (0, 0)

# --- ROBUST TABLE PARSING ---
def extract_html_table(soup, selector):
    """
    Extracts headers and records from a .data-table HTML element within a given section/div.
    Returns: {'headers': [...], 'body': [{'Description': ..., 'values': [...]}, ...]}
    """
    table = soup.select_one(selector)
    if not table:
        return None
    
    # Extract headers, skip the first column ("Description")
    headers = [th.get_text(strip=True) for th in table.select('thead th')]
    data_headers = headers[1:]  # Ignore first column
    
    body = []
    for tr in table.select('tbody tr'):
        tds = tr.select('td')
        if not tds or len(tds) < 2:
            continue
        row_name = tds[0].get_text(strip=True)
        if not row_name:
            continue
        values = [td.get_text(strip=True) for td in tds[1:]]
        
        # If columns mismatch, pad/truncate
        if len(values) < len(data_headers):
            values.extend([""] * (len(data_headers) - len(values)))
        elif len(values) > len(data_headers):
            values = values[:len(data_headers)]
        
        body.append({'Description': row_name, 'values': values})
    
    return {'headers': data_headers, 'body': body}

def build_quarterly_history_from_table(quarterly_table):
    """
    Returns a list of dicts, each for one quarter,
    with keys: 'quarter', 'sales', 'net_profit', 'eps', etc.
    """
    if not quarterly_table or 'headers' not in quarterly_table:
        return []
    
    headers = quarterly_table['headers']
    body_data = quarterly_table['body']
    quarterly_history = []
    
    # Build lookup for metrics (case insensitive)
    metric_map = {
        'sales': ['sales', 'total income', 'revenue'],
        'net_profit': ['net profit', 'profit after tax', 'net income'],
        'operating_profit': ['operating profit', 'op'],
        'eps': ['eps', 'earnings per share'],
        'ebitda': ['ebitda'],
        'opm': ['opm', 'operating profit margin'],
        'npm': ['npm', 'net profit margin'],
    }
    
    # Lowercased row description for lookup
    lookup = {}
    for row in body_data:
        desc = row['Description'].strip().lower()
        lookup[desc] = row['values']
    
    for col, quarter in enumerate(headers):
        entry = {'quarter': quarter.strip()}
        
        # For each metric type, match row
        for key, row_names in metric_map.items():
            for rn in row_names:
                for desc, values in lookup.items():
                    if rn in desc:
                        if col < len(values):
                            val = values[col]
                            entry[key] = parse_number(val) if val not in ('', '-') else None
                        break
        
        quarterly_history.append(entry)
    
    return quarterly_history

def build_annual_history_from_table(fin_table):
    """
    Returns a list of dicts, one per year, with keys for metrics.
    """
    if not fin_table or 'headers' not in fin_table:
        return []
    
    headers = fin_table['headers']
    body_data = fin_table['body']
    
    # Build dict: row name (lower): [col values]
    lookup = {row['Description'].strip().lower(): row['values'] for row in body_data}
    
    year_history = []
    for col, year in enumerate(headers):
        entry = {'period': year.strip()}
        
        for key, rowname in [
            ('sales', 'sales'), ('net_profit', 'net profit'),
            ('ebitda', 'ebitda'), ('eps', 'eps'),
            ('dividend_payout', 'dividend payout'), ('opm', 'opm'),
            ('npm', 'npm'), ('roe', 'roe'), ('roce', 'roce'),
            ('debt_to_equity', 'debt to equity'), ('current_ratio', 'current ratio'),
        ]:
            for desc, values in lookup.items():
                if rowname in desc:
                    if col < len(values):
                        val = values[col]
                        entry[key] = parse_number(val) if val not in ('', '-') else None
                    break
        
        year_history.append(entry)
    
    return year_history

def build_balance_sheet_history_from_table(balance_table):
    """Extract balance sheet metrics"""
    if not balance_table or 'headers' not in balance_table:
        return []
    
    headers = balance_table['headers']
    body_data = balance_table['body']
    lookup = {row['Description'].strip().lower(): row['values'] for row in body_data}
    
    balance_history = []
    for col, year in enumerate(headers):
        entry = {'period': year.strip()}
        
        for key, rowname in [
            ('share_capital', 'share capital'),
            ('reserves', 'reserves'),
            ('borrowings', 'borrowings'),
            ('other_liabilities', 'other liabilities'),
            ('total_liabilities', 'total liabilities'),
            ('fixed_assets', 'fixed assets'),
            ('investments', 'investments'),
            ('other_assets', 'other assets'),
            ('total_assets', 'total assets'),
        ]:
            for desc, values in lookup.items():
                if rowname in desc:
                    if col < len(values):
                        val = values[col]
                        entry[key] = parse_number(val) if val not in ('', '-') else None
                    break
        
        balance_history.append(entry)
    
    return balance_history

def build_cash_flow_history_from_table(cash_flow_table):
    """Extract cash flow metrics"""
    if not cash_flow_table or 'headers' not in cash_flow_table:
        return []
    
    headers = cash_flow_table['headers']
    body_data = cash_flow_table['body']
    lookup = {row['Description'].strip().lower(): row['values'] for row in body_data}
    
    cash_flow_history = []
    for col, year in enumerate(headers):
        entry = {'period': year.strip()}
        
        for key, rowname in [
            ('operating_cash_flow', 'operating cash flow'),
            ('investing_cash_flow', 'investing cash flow'),
            ('financing_cash_flow', 'financing cash flow'),
            ('net_cash_flow', 'net cash flow'),
        ]:
            for desc, values in lookup.items():
                if rowname in desc:
                    if col < len(values):
                        val = values[col]
                        entry[key] = parse_number(val) if val not in ('', '-') else None
                    break
        
        cash_flow_history.append(entry)
    
    return cash_flow_history

def build_ratios_history_from_table(ratios_table):
    """Extract financial ratios"""
    if not ratios_table or 'headers' not in ratios_table:
        return []
    
    headers = ratios_table['headers']
    body_data = ratios_table['body']
    lookup = {row['Description'].strip().lower(): row['values'] for row in body_data}
    
    ratios_history = []
    for col, year in enumerate(headers):
        entry = {'period': year.strip()}
        
        for key, rowname in [
            ('pe_ratio', 'pe ratio'),
            ('pb_ratio', 'pb ratio'),
            ('dividend_yield', 'dividend yield'),
            ('roe', 'roe'),
            ('roce', 'roce'),
            ('debt_to_equity', 'debt to equity'),
            ('current_ratio', 'current ratio'),
            ('interest_coverage', 'interest coverage'),
        ]:
            for desc, values in lookup.items():
                if rowname in desc:
                    if col < len(values):
                        val = values[col]
                        entry[key] = parse_number(val) if val not in ('', '-') else None
                    break
        
        ratios_history.append(entry)
    
    return ratios_history

def extract_symbol_from_page(soup, url):
    """Extract the actual stock symbol from the company page"""
    try:
        # Method 1: Try to get from NSE link
        nse_link = soup.select_one('a[href*="nseindia.com"]')
        if nse_link:
            nse_text = nse_link.get_text(strip=True)
            if 'NSE:' in nse_text:
                symbol = nse_text.replace('NSE:', '').strip()
                if symbol and len(symbol) > 0:
                    return symbol
        
        # Method 2: Try to get from the URL structure
        url_parts = url.strip('/').split('/')
        if len(url_parts) >= 2:
            potential_symbol = url_parts[-2] if url_parts[-1] == 'consolidated' else url_parts[-1]
            if potential_symbol and potential_symbol not in ['company', 'consolidated'] and len(potential_symbol) > 1:
                return potential_symbol.upper()
        
        # Method 3: Try from page title or breadcrumb
        title = soup.select_one('title')
        if title:
            title_text = title.get_text(strip=True)
            symbol_match = re.search(r'\b([A-Z]{2,10})\b', title_text)
            if symbol_match:
                return symbol_match.group(1)
        
        return None
    except Exception as e:
        print(f"Error extracting symbol: {str(e)}")
        return None

def parse_company_data(soup, symbol):
    """Parse comprehensive company data from the page"""
    try:
        # Basic company info
        company_name_elem = soup.select_one('h1.margin-0') or soup.select_one('.company-nav h1') or soup.select_one('h1')
        company_name = company_name_elem.get_text(strip=True) if company_name_elem else f"Company {symbol}"
        
        # Ratios data
        ratios_data = {}
        for li in soup.select('#top-ratios li'):
            name_elem = li.select_one('.name')
            value_elem = li.select_one('.value')
            if name_elem and value_elem:
                ratios_data[name_elem.get_text(strip=True)] = value_elem.get_text(strip=True)
        
        # About section
        about_elem = soup.select_one('.company-profile .about p') or soup.select_one('.about p')
        about = about_elem.get_text(strip=True) if about_elem else None
        
        # Stock codes
        bse_code = None
        nse_code = symbol
        
        bse_link = soup.select_one('a[href*="bseindia.com"]')
        if bse_link:
            bse_text = bse_link.get_text(strip=True)
            bse_match = re.search(r'BSE:\s*(\d+)', bse_text)
            if bse_match:
                bse_code = bse_match.group(1)
        
        nse_link = soup.select_one('a[href*="nseindia.com"]')
        if nse_link:
            nse_text = nse_link.get_text(strip=True)
            nse_match = re.search(r'NSE:\s*([A-Z0-9]+)', nse_text)
            if nse_match:
                nse_code = nse_match.group(1)
        
        # Pros and cons
        pros = [li.get_text(strip=True) for li in soup.select('.pros ul li') if li.get_text(strip=True)]
        cons = [li.get_text(strip=True) for li in soup.select('.cons ul li') if li.get_text(strip=True)]
        
        # Parse website
        website = None
        company_links_div = soup.select_one('div.company-links')
        if company_links_div:
            all_links = company_links_div.find_all('a', href=True)
            for link in all_links:
                href = link['href']
                if 'bseindia.com' not in href and 'nseindia.com' not in href and href.startswith('http'):
                    website = href
                    break
        
        # Extract all financial tables
        tables = {}
        table_sections = {
            'quarters': 'section#quarters table.data-table',
            'profit-loss': 'section#profit-loss table.data-table',
            'balance-sheet': 'section#balance-sheet table.data-table',
            'cash-flow': 'section#cash-flow table.data-table',
            'ratios': 'section#ratios table.data-table'
        }
        
        for section_name, selector in table_sections.items():
            tables[section_name] = extract_html_table(soup, selector)
        
        # Build historical data from tables
        quarterly_history = build_quarterly_history_from_table(tables.get('quarters'))
        annual_history = build_annual_history_from_table(tables.get('profit-loss'))
        balance_sheet_history = build_balance_sheet_history_from_table(tables.get('balance-sheet'))
        cash_flow_history = build_cash_flow_history_from_table(tables.get('cash-flow'))
        ratios_history = build_ratios_history_from_table(tables.get('ratios'))
        
        # Return structured data
        return {
            'symbol': nse_code,
            'name': company_name,
            'about': about,
            'website': website,
            'bse_code': bse_code,
            'nse_code': nse_code,
            'market_cap': parse_number(ratios_data.get('Market Cap')),
            'current_price': parse_number(ratios_data.get('Current Price')),
            'high_low': ratios_data.get('High / Low'),
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
            'ratios_data': ratios_data,
            
            # Financial tables (raw)
            'quarterly_results_table': tables.get('quarters'),
            'profit_loss_statement_table': tables.get('profit-loss'),
            'balance_sheet_table': tables.get('balance-sheet'),
            'cash_flow_statement_table': tables.get('cash-flow'),
            'ratios_table': tables.get('ratios'),
            
            # Historical data (structured)
            'quarterly_history': quarterly_history,
            'annual_history': annual_history,
            'balance_sheet_history': balance_sheet_history,
            'cash_flow_history': cash_flow_history,
            'ratios_history': ratios_history,
            
            'data_version': 'v4.0_comprehensive_tables',
            'extraction_timestamp': datetime.now().isoformat()
        }
        
    except Exception as e:
        print(f"Error parsing company data: {str(e)}")
        return None

# --- QUEUE STATUS FUNCTIONS ---
def get_queue_status(db):
    """Get current queue status"""
    try:
        # Use stream() and count manually to avoid query limitations
        pending_docs = list(db.collection('scraping_queue').where('status', '==', 'pending').stream())
        processing_docs = list(db.collection('scraping_queue').where('status', '==', 'processing').stream())
        completed_docs = list(db.collection('scraping_queue').where('status', '==', 'completed').stream())
        failed_docs = list(db.collection('scraping_queue').where('status', '==', 'failed').stream())
        
        pending_count = len(pending_docs)
        processing_count = len(processing_docs)
        completed_count = len(completed_docs)
        failed_count = len(failed_docs)
        
        total_count = pending_count + processing_count + completed_count + failed_count
        
        return {
            'pending': pending_count,
            'processing': processing_count,
            'completed': completed_count,
            'failed': failed_count,
            'total': total_count,
            'is_active': processing_count > 0 or pending_count > 0,
            'is_completed': pending_count == 0 and processing_count == 0 and completed_count > 0,
            'progress_percentage': ((completed_count + failed_count) / max(1, total_count)) * 100,
            'status_text': 'Processing Active' if processing_count > 0 or pending_count > 0 else ('Complete' if completed_count > 0 else 'Ready'),
            'timestamp': datetime.now().isoformat()
        }
    except Exception as e:
        print(f"Error getting queue status: {str(e)}")
        return {
            'error': str(e),
            'pending': 0,
            'processing': 0,
            'completed': 0,
            'failed': 0,
            'total': 0,
            'is_active': False,
            'timestamp': datetime.now().isoformat()
        }

def cleanup_old_queue_items(db):
    """Clean up old completed and failed queue items"""
    try:
        cutoff_date = datetime.now() - timedelta(days=7)
        cutoff_iso = cutoff_date.isoformat()
        
        # Delete old completed items
        completed_docs = list(db.collection('scraping_queue')
                            .where('status', '==', 'completed')
                            .where('completed_at', '<', cutoff_iso)
                            .limit(100)
                            .stream())
        
        if completed_docs:
            batch = db.batch()
            for doc in completed_docs:
                batch.delete(doc.reference)
            batch.commit()
            print(f"Cleaned up {len(completed_docs)} old completed items")
        
        # Delete old failed items
        failed_docs = list(db.collection('scraping_queue')
                         .where('status', '==', 'failed')
                         .where('failed_at', '<', cutoff_iso)
                         .limit(100)
                         .stream())
        
        if failed_docs:
            batch = db.batch()
            for doc in failed_docs:
                batch.delete(doc.reference)
            batch.commit()
            print(f"Cleaned up {len(failed_docs)} old failed items")
            
    except Exception as e:
        print(f"Error cleaning up old items: {str(e)}")

def reset_stale_processing_items(db):
    """Reset items that have been processing for too long"""
    try:
        cutoff_time = datetime.now() - timedelta(minutes=30)
        cutoff_iso = cutoff_time.isoformat()
        
        stale_docs = list(db.collection('scraping_queue')
                        .where('status', '==', 'processing')
                        .where('started_at', '<', cutoff_iso)
                        .limit(50)
                        .stream())
        
        if stale_docs:
            batch = db.batch()
            for doc in stale_docs:
                batch.update(doc.reference, {
                    'status': 'pending',
                    'started_at': firestore.DELETE_FIELD,
                    'reset_count': firestore.Increment(1),
                    'reset_at': datetime.now().isoformat()
                })
            batch.commit()
            print(f"Reset {len(stale_docs)} stale processing items")
            
    except Exception as e:
        print(f"Error resetting stale items: {str(e)}")

# --- SCHEDULED FUNCTION - RUNS EVERY 3 MINUTES ---
@scheduler_fn.on_schedule(
    schedule="*/1 * * * *",
    timezone=scheduler_fn.Timezone("Asia/Kolkata")
)
def process_scraping_queue(event: scheduler_fn.ScheduledEvent) -> None:
    """Process items from scraping queue"""
    try:
        print("Starting scheduled scraping process...")
        db = get_db()
        
        # Cleanup and reset stale items
        cleanup_old_queue_items(db)
        reset_stale_processing_items(db)
        
        # Get pending items
        queue_items = list(db.collection('scraping_queue')
                          .where('status', '==', 'pending')
                          .order_by('created_at')
                          .limit(5)
                          .stream())
        
        if not queue_items:
            print("No pending items to process")
            return
        
        print(f"Processing {len(queue_items)} items...")
        processed_count = 0
        failed_count = 0
        
        with requests.Session() as session:
            for doc in queue_items:
                try:
                    data = doc.to_dict()
                    url = data['url']
                    retry_count = data.get('retry_count', 0)
                    max_retries = data.get('max_retries', 3)
                    
                    print(f"Processing: {url}")
                    
                    # Update status to processing
                    doc.reference.update({
                        'status': 'processing',
                        'started_at': datetime.now().isoformat(),
                        'processor_id': 'scheduler_v4_comprehensive'
                    })
                    
                    # Fetch page
                    response = fetch_page(session, url, retries=2)
                    
                    if response:
                        soup = BeautifulSoup(response.content, 'lxml')
                        symbol = extract_symbol_from_page(soup, url)
                        
                        if symbol:
                            print(f"Found symbol: {symbol}")
                            
                            # Parse company data with all tables
                            company_data = parse_company_data(soup, symbol)
                            if company_data:
                                # Save to companies collection
                                db.collection('companies').document(symbol).set(company_data)
                                
                                # Update queue item as completed
                                doc.reference.update({
                                    'status': 'completed',
                                    'completed_at': datetime.now().isoformat(),
                                    'symbol': symbol,
                                    'company_name': company_data.get('name', 'Unknown')
                                })
                                processed_count += 1
                                print(f"Successfully processed: {symbol}")
                            else:
                                # Parsing failed, retry if possible
                                if retry_count < max_retries:
                                    doc.reference.update({
                                        'status': 'pending',
                                        'retry_count': retry_count + 1,
                                        'last_retry': datetime.now().isoformat(),
                                        'started_at': firestore.DELETE_FIELD
                                    })
                                    print(f"Retrying parsing for: {url}")
                                else:
                                    doc.reference.update({
                                        'status': 'failed',
                                        'failed_at': datetime.now().isoformat(),
                                        'error': 'Failed to parse company data'
                                    })
                                    failed_count += 1
                                    print(f"Failed to parse: {url}")
                        else:
                            # Symbol extraction failed
                            if retry_count < max_retries:
                                doc.reference.update({
                                    'status': 'pending',
                                    'retry_count': retry_count + 1,
                                    'last_retry': datetime.now().isoformat(),
                                    'started_at': firestore.DELETE_FIELD
                                })
                            else:
                                doc.reference.update({
                                    'status': 'failed',
                                    'failed_at': datetime.now().isoformat(),
                                    'error': 'Could not extract symbol'
                                })
                                failed_count += 1
                    else:
                        # Page fetch failed
                        if retry_count < max_retries:
                            doc.reference.update({
                                'status': 'pending',
                                'retry_count': retry_count + 1,
                                'last_retry': datetime.now().isoformat(),
                                'started_at': firestore.DELETE_FIELD
                            })
                        else:
                            doc.reference.update({
                                'status': 'failed',
                                'failed_at': datetime.now().isoformat(),
                                'error': 'Failed to fetch page'
                            })
                            failed_count += 1
                    
                    # Random delay between requests
                    time.sleep(random.uniform(2, 5))
                    
                except Exception as e:
                    print(f"Error processing item: {str(e)}")
                    try:
                        doc.reference.update({
                            'status': 'failed',
                            'failed_at': datetime.now().isoformat(),
                            'error': f'Processing error: {str(e)}'
                        })
                        failed_count += 1
                    except:
                        pass
        
        print(f"Batch completed - Processed: {processed_count}, Failed: {failed_count}")
        
        # Send notification for batch completion
        if processed_count > 0 or failed_count > 0:
            notify_job_complete(processed_count, failed_count)
        
    except Exception as e:
        print(f"Error in scheduled function: {str(e)}")
        notify_job_failed(str(e))

# --- HTTP FUNCTIONS ---
@https_fn.on_request()
def queue_scraping_jobs(req: https_fn.Request) -> https_fn.Response:
    """Queue individual scraping jobs for processing"""
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
        
        print("Starting job queuing...")
        db = get_db()
        
        try:
            request_json = req.get_json() or {}
        except Exception:
            request_json = {}
        
        clear_queue = request_json.get('clear_existing', False)
        max_pages = request_json.get('max_pages', 100)  # Default to 100 pages as requested
        
        print(f"Parameters: clear_queue={clear_queue}, max_pages={max_pages}")
        
        if clear_queue:
            print("Clearing existing queue...")
            # Clear existing pending and failed items
            for status in ['pending', 'failed']:
                docs = list(db.collection('scraping_queue').where('status', '==', status).limit(500).stream())
                if docs:
                    batch = db.batch()
                    for doc in docs:
                        batch.delete(doc.reference)
                    batch.commit()
                    print(f"Cleared {len(docs)} {status} items")
        
        # Collect URLs from screener.in
        company_urls = []
        
        with requests.Session() as session:
            for page in range(1, max_pages + 1):
                print(f"Processing page {page}...")
                list_url = f"https://www.screener.in/screens/515361/largecaptop-100midcap101-250smallcap251/?page={page}"
                response = fetch_page(session, list_url)
                
                if not response:
                    print(f"Failed to fetch page {page}")
                    break
                
                list_soup = BeautifulSoup(response.content, 'lxml')
                rows = list_soup.select('table.data-table tr[data-row-company-id]')
                
                if not rows:
                    print(f"No more companies found on page {page}")
                    break
                
                page_urls = []
                for row in rows:
                    link_tag = row.select_one('a')
                    if link_tag and link_tag.get('href'):
                        company_url = f"https://www.screener.in{link_tag['href']}"
                        company_urls.append(company_url)
                        page_urls.append(company_url)
                
                print(f"Found {len(page_urls)} companies on page {page}")
                time.sleep(random.uniform(1, 3))
        
        if not company_urls:
            error_msg = "No company URLs found"
            print(error_msg)
            notify_job_failed(error_msg)
            return https_fn.Response(
                json.dumps({'status': 'error', 'message': error_msg}),
                status=400, headers=headers
            )
        
        print(f"Total URLs collected: {len(company_urls)}")
        
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
                    'scraper_version': 'v4.0_comprehensive_tables'
                })
            
            batch.commit()
            total_queued += len(batch_urls)
            print(f"Queued batch: {len(batch_urls)} items (Total: {total_queued})")
        
        success_message = f'Successfully queued {total_queued} companies for scraping'
        print(success_message)
        
        return https_fn.Response(
            json.dumps({
                'status': 'success',
                'message': success_message,
                'queued_count': total_queued,
                'pages_processed': max_pages,
                'timestamp': datetime.now().isoformat()
            }),
            status=200, headers=headers
        )
        
    except Exception as e:
        error_msg = f"Error queuing jobs: {str(e)}"
        print(error_msg)
        notify_job_failed(error_msg)
        return https_fn.Response(
            json.dumps({'status': 'error', 'message': error_msg}),
            status=500, headers=headers
        )

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
            completed_docs = list(db.collection('scraping_queue')
                                .where('status', '==', 'completed')
                                .order_by('completed_at', direction=firestore.Query.DESCENDING)
                                .limit(10)
                                .stream())
            
            for doc in completed_docs:
                data = doc.to_dict()
                recent_completed.append({
                    'symbol': data.get('symbol', 'Unknown'),
                    'company_name': data.get('company_name', 'Unknown'),
                    'completed_at': data.get('completed_at', ''),
                })
        except Exception as e:
            print(f"Error getting recent completed: {str(e)}")
        
        response_data = {
            'status': 'success',
            'queue_status': status,
            'recent_completed': recent_completed,
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
            docs = list(db.collection('scraping_queue').where('status', '==', 'failed').limit(1000).stream())
            if docs:
                batch = db.batch()
                for doc in docs:
                    batch.delete(doc.reference)
                batch.commit()
                
            return https_fn.Response(
                json.dumps({'status': 'success', 'message': f'Cleared {len(docs)} failed items'}),
                status=200, headers=headers
            )
        
        elif action == 'retry_failed':
            docs = list(db.collection('scraping_queue').where('status', '==', 'failed').limit(100).stream())
            if docs:
                batch = db.batch()
                for doc in docs:
                    batch.update(doc.reference, {
                        'status': 'pending',
                        'retry_count': 0,
                        'failed_at': firestore.DELETE_FIELD,
                        'error': firestore.DELETE_FIELD,
                        'retried_at': datetime.now().isoformat()
                    })
                batch.commit()
                
            return https_fn.Response(
                json.dumps({'status': 'success', 'message': f'Reset {len(docs)} failed items to pending'}),
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

# --- STARTUP FUNCTION - TRIGGERS AUTOMATICALLY AFTER DEPLOYMENT ---
@scheduler_fn.on_schedule(
    schedule="*/1 * * * *",  # Runs every 1 minute as requested
    timezone=scheduler_fn.Timezone("Asia/Kolkata")
)
def auto_start_scraping(event: scheduler_fn.ScheduledEvent) -> None:
    """Auto-start scraping 1 minute after deployment with 100 pages"""
    try:
        db = get_db()
        
        # Check if auto-start has already been done
        auto_start_doc = db.collection('system_config').document('auto_start_status').get()
        
        if auto_start_doc.exists:
            auto_start_data = auto_start_doc.to_dict()
            if auto_start_data.get('completed', False):
                # Auto-start already completed, disable this function
                return
        
        print("Auto-starting scraping process...")
        
        # Mark auto-start as completed first to prevent re-runs
        db.collection('system_config').document('auto_start_status').set({
            'completed': True,
            'started_at': datetime.now().isoformat(),
            'pages_requested': 100
        })
        
        # Clear any existing queue
        for status in ['pending', 'failed', 'processing']:
            docs = list(db.collection('scraping_queue').where('status', '==', status).limit(1000).stream())
            if docs:
                batch = db.batch()
                for doc in docs:
                    batch.delete(doc.reference)
                batch.commit()
                print(f"Cleared {len(docs)} {status} items")
        
        # Collect URLs from screener.in (100 pages as requested)
        company_urls = []
        
        with requests.Session() as session:
            for page in range(1, 101):  # 100 pages as requested
                print(f"Processing page {page}...")
                list_url = f"https://www.screener.in/screens/515361/largecaptop-100midcap101-250smallcap251/?page={page}"
                response = fetch_page(session, list_url)
                
                if not response:
                    print(f"Failed to fetch page {page}")
                    break
                
                list_soup = BeautifulSoup(response.content, 'lxml')
                rows = list_soup.select('table.data-table tr[data-row-company-id]')
                
                if not rows:
                    print(f"No more companies found on page {page}")
                    break
                
                for row in rows:
                    link_tag = row.select_one('a')
                    if link_tag and link_tag.get('href'):
                        company_url = f"https://www.screener.in{link_tag['href']}"
                        company_urls.append(company_url)
                
                time.sleep(random.uniform(1, 3))
        
        if company_urls:
            # Add URLs to Firestore queue
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
                        'priority': 'high',  # High priority for auto-start
                        'retry_count': 0,
                        'max_retries': 3,
                        'scraper_version': 'v4.0_auto_start_comprehensive',
                        'auto_started': True
                    })
                
                batch.commit()
                total_queued += len(batch_urls)
            
            print(f"Auto-start: Queued {total_queued} companies from 100 pages")
            
            # Update auto-start status
            db.collection('system_config').document('auto_start_status').update({
                'queued_count': total_queued,
                'completed_at': datetime.now().isoformat()
            })
            
            # Send notification
            send_job_notification(
                title="🚀 Auto-Scraping Started!",
                body=f"Automatically queued {total_queued} companies from 100 pages for comprehensive data extraction",
                data={'type': 'auto_start_completed', 'queued_count': str(total_queued)}
            )
        
    except Exception as e:
        print(f"Error in auto-start: {str(e)}")
        # Mark as failed but don't prevent retry
        try:
            db = get_db()
            db.collection('system_config').document('auto_start_status').set({
                'completed': False,
                'failed': True,
                'error': str(e),
                'failed_at': datetime.now().isoformat()
            })
        except:
            pass