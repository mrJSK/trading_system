# from firebase_functions import https_fn, scheduler_fn
# from firebase_admin import initialize_app, firestore, messaging
# import requests
# import re
# import time
# import random
# from datetime import datetime, timedelta
# from bs4 import BeautifulSoup
# import logging
# import json

# # Initialize Firebase Admin SDK
# initialize_app()

# # Set up logging
# logging.basicConfig(level=logging.INFO)
# logger = logging.getLogger(__name__)

# # Configuration
# USER_AGENTS = [
#     'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36',
#     'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36',
#     'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:126.0) Gecko/20100101 Firefox/126.0',
#     'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36'
# ]

# def get_db():
#     """Get Firestore client - called inside functions only"""
#     return firestore.client()

# # --- NETWORKING FUNCTIONS ---

# def fetch_page(session, url, retries=3, backoff_factor=0.8, referer=None):
#     """Fetches a URL using session with retry mechanism"""
#     headers = {
#         'User-Agent': random.choice(USER_AGENTS),
#         'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
#         'Accept-Language': 'en-US,en;q=0.9',
#         'Connection': 'keep-alive',
#         'Upgrade-Insecure-Requests': '1',
#     }
    
#     if referer:
#         headers['Referer'] = referer
    
#     for attempt in range(retries):
#         try:
#             response = session.get(url, headers=headers, timeout=30)
#             response.raise_for_status()
#             return response
#         except Exception as e:
#             logger.error(f"Attempt {attempt + 1} failed for {url}: {e}")
#             if attempt < retries - 1:
#                 wait_time = backoff_factor * (2 ** attempt) + random.uniform(0, 1)
#                 time.sleep(wait_time)
#             else:
#                 logger.error(f"Final attempt to fetch {url} failed.")
#     return None

# # --- SYMBOL EXTRACTION FUNCTION ---

# def extract_symbol_from_page(soup, url):
#     """Extract the actual stock symbol from the company page"""
#     # Method 1: Try to get from NSE link
#     nse_link = soup.select_one('a[href*="nseindia.com"]')
#     if nse_link:
#         nse_text = nse_link.get_text(strip=True)
#         # Extract symbol from "NSE: SYMBOL" format
#         if 'NSE:' in nse_text:
#             symbol = nse_text.replace('NSE:', '').strip()
#             if symbol:
#                 return symbol
    
#     # Method 2: Try to get from the URL structure
#     url_parts = url.strip('/').split('/')
#     if len(url_parts) >= 2:
#         potential_symbol = url_parts[-2] if url_parts[-1] == 'consolidated' else url_parts[-1]
#         if potential_symbol and potential_symbol != 'company':
#             return potential_symbol
    
#     # Method 3: Try to extract from page structure
#     breadcrumb = soup.select_one('.breadcrumb')
#     if breadcrumb:
#         breadcrumb_text = breadcrumb.get_text(strip=True)
#         # Look for stock symbol pattern in breadcrumb
#         symbol_match = re.search(r'\b([A-Z]{2,10})\b', breadcrumb_text)
#         if symbol_match:
#             return symbol_match.group(1)
    
#     # Method 4: Extract from company nav or title
#     company_nav = soup.select_one('.company-nav h1') or soup.select_one('h1.margin-0')
#     if company_nav:
#         nav_text = company_nav.get_text(strip=True)
#         # Try to extract symbol pattern from title like "NTPC Ltd"
#         symbol_match = re.search(r'^([A-Z]{2,10})', nav_text)
#         if symbol_match:
#             return symbol_match.group(1)
    
#     # Fallback: return None if no symbol found
#     return None

# # --- PARSING FUNCTIONS ---

# def clean_text(text, field_name=""):
#     """Clean and format text data"""
#     if not text:
#         return None
    
#     if field_name in ["bse_code", "nse_code"]:
#         return text.strip().replace('BSE:', '').replace('NSE:', '').strip()
    
#     return text.strip().replace('₹', '').replace(',', '').replace('%', '').replace('Cr.', '').strip()

# def parse_number(text):
#     """Parse numeric values from text"""
#     cleaned = clean_text(text)
#     if cleaned in [None, '']:
#         return None
    
#     match = re.search(r'[-+]?\d*\.\d+|\d+', cleaned)
#     if match:
#         try:
#             return float(match.group(0))
#         except (ValueError, TypeError):
#             return None
#     return None

# def get_calendar_sort_key(header_string):
#     """Sort calendar headers"""
#     MONTH_MAP = {
#         'Jan': 1, 'Feb': 2, 'Mar': 3, 'Apr': 4, 'May': 5, 'Jun': 6,
#         'Jul': 7, 'Aug': 8, 'Sep': 9, 'Oct': 10, 'Nov': 11, 'Dec': 12
#     }
    
#     try:
#         month_str, year_str = header_string.strip().split()
#         return (int(year_str), MONTH_MAP.get(month_str, 0))
#     except (ValueError, KeyError, IndexError):
#         try:
#             return (int(header_string), 0)
#         except (ValueError, TypeError):
#             return (0, 0)

# def parse_website_link(soup):
#     """Parse company website"""
#     company_links_div = soup.select_one('div.company-links')
#     if not company_links_div:
#         return None
    
#     all_links = company_links_div.find_all('a', href=True)
#     for link in all_links:
#         href = link['href']
#         if 'bseindia.com' not in href and 'nseindia.com' not in href:
#             return href
#     return None

# def parse_financial_table(soup, table_id):
#     """Parse financial tables"""
#     section = soup.select_one(f'section#{table_id}')
#     if not section:
#         return {}
    
#     table = section.select_one('table.data-table')
#     if not table:
#         return {}
    
#     original_headers = [th.get_text(strip=True) for th in table.select('thead th')][1:]
#     if not original_headers:
#         return {}
    
#     sorted_headers = sorted(original_headers, key=get_calendar_sort_key, reverse=True)
    
#     body_data = []
#     for row in table.select('tbody tr'):
#         cols = row.select('td')
#         if not cols or 'sub' in row.get('class', []):
#             continue
        
#         row_name = cols[0].get_text(strip=True).replace('+', '').strip()
#         if not row_name:
#             continue
        
#         original_values = [col.get_text(strip=True) for col in cols[1:]]
#         value_map = dict(zip(original_headers, original_values))
#         sorted_values = [value_map.get(h, '') for h in sorted_headers]
        
#         body_data.append({
#             'Description': row_name,
#             'values': sorted_values
#         })
    
#     return {
#         'headers': sorted_headers,
#         'body': body_data
#     }

# def parse_shareholding_table(soup, table_id):
#     """Parse shareholding tables"""
#     table = soup.select_one(f'div#{table_id} table.data-table')
#     if not table:
#         return {}
    
#     original_headers = [th.get_text(strip=True) for th in table.select('thead th')][1:]
#     sorted_headers = sorted(original_headers, key=get_calendar_sort_key, reverse=True)
    
#     data = {}
#     for row in table.select('tbody tr'):
#         cols = row.select('td')
#         if not cols or 'sub' in row.get('class', []):
#             continue
        
#         row_name = cols[0].get_text(strip=True).replace('+', '').strip()
#         if not row_name:
#             continue
        
#         original_values = [col.get_text(strip=True) for col in cols[1:]]
#         value_map = dict(zip(original_headers, original_values))
#         row_data = {h: value_map.get(h, '') for h in sorted_headers}
#         data[row_name] = row_data
    
#     return data

# def parse_growth_tables(soup):
#     """Parse growth tables"""
#     data = {}
#     pl_section = soup.select_one('section#profit-loss')
#     if not pl_section:
#         return data
    
#     tables = pl_section.select('table.ranges-table')
#     for table in tables:
#         title_elem = table.select_one('th')
#         if title_elem:
#             title = title_elem.get_text(strip=True).replace(':', '')
#             table_data = {}
            
#             for row in table.select('tr')[1:]:
#                 cols = row.select('td')
#                 if len(cols) == 2:
#                     key = cols[0].get_text(strip=True).replace(':', '')
#                     value = cols[1].get_text(strip=True)
#                     table_data[key] = value
            
#             data[title] = table_data
    
#     return data

# def process_industry_path(soup):
#     """Process industry classification"""
#     peers_section = soup.select_one('section#peers')
#     if not peers_section:
#         return None
    
#     path_paragraph = peers_section.select_one('p.sub:not(#benchmarks)')
#     if not path_paragraph:
#         return None
    
#     path_links = path_paragraph.select('a')
#     if not path_links:
#         return None
    
#     path_names = [link.get_text(strip=True).replace('&', 'and') for link in path_links]
#     return path_names

# def parse_company_data(soup, symbol):
#     """Complete company data parsing with proper symbol handling"""
#     try:
#         # Basic company info
#         company_name_elem = soup.select_one('h1.margin-0') or soup.select_one('.company-nav h1')
#         company_name = company_name_elem.get_text(strip=True) if company_name_elem else f"Company {symbol}"
        
#         # Clean up company name (remove "Ltd", "Limited", etc. if needed for display)
#         display_name = re.sub(r'\s+(Ltd|Limited|Corporation|Corp|Inc)\.?$', '', company_name, flags=re.IGNORECASE).strip()
        
#         # Ratios data
#         ratios_data = {}
#         for li in soup.select('#top-ratios li'):
#             name_elem = li.select_one('.name')
#             value_elem = li.select_one('.value')
#             if name_elem and value_elem:
#                 ratios_data[name_elem.get_text(strip=True)] = value_elem.get_text(strip=True)
        
#         # About section
#         about_elem = soup.select_one('.company-profile .about p')
#         about = about_elem.get_text(strip=True) if about_elem else None
        
#         # Stock codes - improved extraction
#         bse_link = soup.select_one('a[href*="bseindia.com"]')
#         nse_link = soup.select_one('a[href*="nseindia.com"]')
        
#         # Extract BSE code from BSE link text
#         bse_code = None
#         if bse_link:
#             bse_text = bse_link.get_text(strip=True)
#             bse_match = re.search(r'BSE:\s*(\d+)', bse_text)
#             if bse_match:
#                 bse_code = bse_match.group(1)
        
#         # Extract NSE code from NSE link text (should match our symbol)
#         nse_code = None
#         if nse_link:
#             nse_text = nse_link.get_text(strip=True)
#             nse_match = re.search(r'NSE:\s*([A-Z0-9]+)', nse_text)
#             if nse_match:
#                 nse_code = nse_match.group(1)
        
#         # Use NSE code as symbol if available, otherwise use the provided symbol
#         final_symbol = nse_code if nse_code else symbol
        
#         # Pros and cons
#         pros = [li.get_text(strip=True) for li in soup.select('.pros ul li')]
#         cons = [li.get_text(strip=True) for li in soup.select('.cons ul li')]
        
#         # Return complete data with proper symbol
#         return {
#             'symbol': final_symbol,  # Use the actual trading symbol
#             'name': company_name,    # Full company name
#             'display_name': display_name,  # Clean display name
#             'about': about,
#             'website': parse_website_link(soup),
#             'bse_code': bse_code,
#             'nse_code': final_symbol,  # NSE symbol
#             'market_cap': parse_number(ratios_data.get('Market Cap')),
#             'current_price': parse_number(ratios_data.get('Current Price')),
#             'high_low': clean_text(ratios_data.get('High / Low')),
#             'stock_pe': parse_number(ratios_data.get('Stock P/E')),
#             'book_value': parse_number(ratios_data.get('Book Value')),
#             'dividend_yield': parse_number(ratios_data.get('Dividend Yield')),
#             'roce': parse_number(ratios_data.get('ROCE')),
#             'roe': parse_number(ratios_data.get('ROE')),
#             'face_value': parse_number(ratios_data.get('Face Value')),
#             'pros': pros,
#             'cons': cons,
#             'last_updated': datetime.now().isoformat(),
#             'change_percent': 0.0,
#             'change_amount': 0.0,
#             'previous_close': parse_number(ratios_data.get('Current Price', '0.0')) or 0.0,
            
#             # Financial statements
#             'quarterly_results': parse_financial_table(soup, 'quarters'),
#             'profit_loss_statement': parse_financial_table(soup, 'profit-loss'),
#             'balance_sheet': parse_financial_table(soup, 'balance-sheet'),
#             'cash_flow_statement': parse_financial_table(soup, 'cash-flow'),
#             'ratios': parse_financial_table(soup, 'ratios'),
            
#             # Industry and shareholding
#             'industry_classification': process_industry_path(soup),
#             'shareholding_pattern': {
#                 'quarterly': parse_shareholding_table(soup, 'quarterly-shp')
#             },
            
#             # Growth tables
#             **parse_growth_tables(soup),
            
#             # Raw ratios data for reference
#             'ratios_data': ratios_data
#         }
        
#     except Exception as e:
#         logger.error(f"Error parsing company data for {symbol}: {e}")
#         return None

# # --- QUEUE MANAGEMENT FUNCTIONS ---

# def get_queue_status(db):
#     """Get current queue status"""
#     try:
#         # Get queue counts
#         pending_count = len(list(db.collection('scraping_queue').where('status', '==', 'pending').limit(1000).stream()))
#         processing_count = len(list(db.collection('scraping_queue').where('status', '==', 'processing').limit(1000).stream()))
#         completed_count = len(list(db.collection('scraping_queue').where('status', '==', 'completed').limit(1000).stream()))
#         failed_count = len(list(db.collection('scraping_queue').where('status', '==', 'failed').limit(1000).stream()))
        
#         return {
#             'pending': pending_count,
#             'processing': processing_count,
#             'completed': completed_count,
#             'failed': failed_count,
#             'total': pending_count + processing_count + completed_count + failed_count
#         }
#     except Exception as e:
#         logger.error(f"Error getting queue status: {e}")
#         return {'error': str(e)}

# def cleanup_old_queue_items(db):
#     """Clean up old completed and failed queue items"""
#     try:
#         cutoff_date = datetime.now() - timedelta(days=7)  # Keep items for 7 days
#         cutoff_iso = cutoff_date.isoformat()
        
#         # Delete old completed items
#         completed_docs = db.collection('scraping_queue')\
#                           .where('status', '==', 'completed')\
#                           .where('completed_at', '<', cutoff_iso)\
#                           .limit(100)\
#                           .stream()
        
#         batch = db.batch()
#         count = 0
#         for doc in completed_docs:
#             batch.delete(doc.reference)
#             count += 1
        
#         if count > 0:
#             batch.commit()
#             logger.info(f"Cleaned up {count} old completed queue items")
        
#         # Delete old failed items
#         failed_docs = db.collection('scraping_queue')\
#                      .where('status', '==', 'failed')\
#                      .where('failed_at', '<', cutoff_iso)\
#                      .limit(100)\
#                      .stream()
        
#         batch = db.batch()
#         count = 0
#         for doc in failed_docs:
#             batch.delete(doc.reference)
#             count += 1
        
#         if count > 0:
#             batch.commit()
#             logger.info(f"Cleaned up {count} old failed queue items")
            
#     except Exception as e:
#         logger.error(f"Error cleaning up old queue items: {e}")

# def reset_stale_processing_items(db):
#     """Reset items that have been processing for too long"""
#     try:
#         cutoff_time = datetime.now() - timedelta(minutes=30)  # 30 minutes timeout
#         cutoff_iso = cutoff_time.isoformat()
        
#         stale_docs = db.collection('scraping_queue')\
#                       .where('status', '==', 'processing')\
#                       .where('started_at', '<', cutoff_iso)\
#                       .limit(50)\
#                       .stream()
        
#         batch = db.batch()
#         count = 0
#         for doc in stale_docs:
#             batch.update(doc.reference, {
#                 'status': 'pending',
#                 'started_at': firestore.DELETE_FIELD,
#                 'reset_count': firestore.Increment(1),
#                 'reset_at': datetime.now().isoformat()
#             })
#             count += 1
        
#         if count > 0:
#             batch.commit()
#             logger.info(f"Reset {count} stale processing items")
            
#     except Exception as e:
#         logger.error(f"Error resetting stale processing items: {e}")

# # --- QUEUE-BASED SCRAPING FUNCTIONS ---

# @https_fn.on_request()
# def queue_scraping_jobs(req: https_fn.Request) -> https_fn.Response:
#     """Queue individual scraping jobs for processing"""
#     try:
#         headers = {
#             'Access-Control-Allow-Origin': '*',
#             'Content-Type': 'application/json'
#         }
        
#         if req.method == 'OPTIONS':
#             headers.update({
#                 'Access-Control-Allow-Methods': 'POST',
#                 'Access-Control-Allow-Headers': 'Content-Type',
#                 'Access-Control-Max-Age': '3600'
#             })
#             return https_fn.Response('', status=204, headers=headers)
        
#         logger.info("Queuing scraping jobs triggered")
#         db = get_db()
        
#         try:
#             request_json = req.get_json() or {}
#         except Exception:
#             request_json = {}
        
#         # Check if we should clear existing queue
#         clear_queue = request_json.get('clear_existing', False)
#         max_pages = request_json.get('max_pages', 50)  # Default to 50 pages
        
#         if clear_queue:
#             logger.info("Clearing existing queue items...")
#             # Clear existing pending and failed items
#             for status in ['pending', 'failed']:
#                 docs = db.collection('scraping_queue').where('status', '==', status).limit(500).stream()
#                 batch = db.batch()
#                 count = 0
#                 for doc in docs:
#                     batch.delete(doc.reference)
#                     count += 1
#                     if count >= 500:
#                         batch.commit()
#                         batch = db.batch()
#                         count = 0
#                 if count > 0:
#                     batch.commit()
            
#             logger.info("Existing queue cleared")
        
#         # Collect URLs and add to queue
#         company_urls = []
        
#         with requests.Session() as session:
#             for page in range(1, max_pages + 1):
#                 logger.info(f"Collecting URLs from page {page}")
#                 list_url = f"https://www.screener.in/screens/515361/largecaptop-100midcap101-250smallcap251/?page={page}"
#                 response = fetch_page(session, list_url)
                
#                 if not response:
#                     logger.warning(f"Failed to fetch page {page}")
#                     break
                
#                 list_soup = BeautifulSoup(response.content, 'lxml')
#                 rows = list_soup.select('table.data-table tr[data-row-company-id]')
                
#                 if not rows:
#                     logger.info(f"No more companies found on page {page}")
#                     break
                
#                 page_urls = []
#                 for row in rows:
#                     link_tag = row.select_one('a')
#                     if link_tag and link_tag.get('href'):
#                         company_url = f"https://www.screener.in{link_tag['href']}"
#                         page_urls.append(company_url)
#                         company_urls.append(company_url)
                
#                 logger.info(f"Found {len(page_urls)} companies on page {page}")
#                 time.sleep(random.uniform(1, 3))  # Rate limiting
        
#         if not company_urls:
#             return https_fn.Response(
#                 json.dumps({
#                     'status': 'error',
#                     'message': 'No company URLs found to queue'
#                 }),
#                 status=400,
#                 headers=headers
#             )
        
#         logger.info(f"Collected {len(company_urls)} total company URLs")
        
#         # Add URLs to Firestore queue in batches
#         batch_size = 500  # Firestore batch limit
#         total_queued = 0
        
#         for i in range(0, len(company_urls), batch_size):
#             batch = db.batch()
#             batch_urls = company_urls[i:i + batch_size]
            
#             for url in batch_urls:
#                 doc_ref = db.collection('scraping_queue').document()
#                 batch.set(doc_ref, {
#                     'url': url,
#                     'status': 'pending',
#                     'created_at': datetime.now().isoformat(),
#                     'priority': 'normal',
#                     'retry_count': 0,
#                     'max_retries': 3
#                 })
            
#             batch.commit()
#             total_queued += len(batch_urls)
#             logger.info(f"Queued batch {i//batch_size + 1}: {len(batch_urls)} items (Total: {total_queued})")
        
#         # Update queue statistics
#         queue_stats_ref = db.collection('system').document('queue_stats')
#         queue_stats_ref.set({
#             'last_queue_creation': datetime.now().isoformat(),
#             'total_queued': total_queued,
#             'pages_scraped': max_pages,
#             'queue_status': 'active'
#         })
        
#         return https_fn.Response(
#             json.dumps({
#                 'status': 'success',
#                 'message': f'Successfully queued {total_queued} companies for scraping',
#                 'queued_count': total_queued,
#                 'pages_processed': max_pages,
#                 'timestamp': datetime.now().isoformat()
#             }),
#             status=200,
#             headers=headers
#         )
        
#     except Exception as e:
#         logger.error(f"Error queuing scraping jobs: {e}")
#         return https_fn.Response(
#             json.dumps({
#                 'status': 'error',
#                 'message': str(e),
#                 'timestamp': datetime.now().isoformat()
#             }),
#             status=500,
#             headers={'Access-Control-Allow-Origin': '*', 'Content-Type': 'application/json'}
#         )

# @scheduler_fn.on_schedule(
#     schedule="*/3 * * * *",  # Every 3 minutes
#     timezone=scheduler_fn.Timezone("Asia/Kolkata")
# )
# def process_scraping_queue(event: scheduler_fn.ScheduledEvent) -> None:
#     """Process items from scraping queue"""
#     logger.info("Processing scraping queue...")
    
#     try:
#         db = get_db()
        
#         # Clean up old items and reset stale processing items
#         cleanup_old_queue_items(db)
#         reset_stale_processing_items(db)
        
#         # Get pending items from queue (prioritized)
#         queue_items = db.collection('scraping_queue')\
#                        .where('status', '==', 'pending')\
#                        .order_by('created_at')\
#                        .limit(5)\
#                        .stream()  # Process 5 items per execution
        
#         items_to_process = list(queue_items)
        
#         if not items_to_process:
#             logger.info("No pending items in queue")
#             return
        
#         logger.info(f"Processing {len(items_to_process)} items from queue")
        
#         with requests.Session() as session:
#             for doc in items_to_process:
#                 try:
#                     data = doc.to_dict()
#                     url = data['url']
#                     retry_count = data.get('retry_count', 0)
#                     max_retries = data.get('max_retries', 3)
                    
#                     logger.info(f"Processing: {url}")
                    
#                     # Update status to processing
#                     doc.reference.update({
#                         'status': 'processing',
#                         'started_at': datetime.now().isoformat(),
#                         'processor_id': 'scheduler_worker'
#                     })
                    
#                     response = fetch_page(session, url, retries=2)
                    
#                     if response:
#                         soup = BeautifulSoup(response.content, 'lxml')
#                         symbol = extract_symbol_from_page(soup, url)
                        
#                         if symbol:
#                             # Check if company already exists and is recent
#                             existing_doc = db.collection('companies').document(symbol).get()
#                             should_update = True
                            
#                             if existing_doc.exists:
#                                 existing_data = existing_doc.to_dict()
#                                 last_updated = existing_data.get('last_updated')
#                                 if last_updated:
#                                     try:
#                                         last_update_time = datetime.fromisoformat(last_updated.replace('Z', '+00:00'))
#                                         if datetime.now() - last_update_time < timedelta(hours=6):
#                                             should_update = False
#                                             logger.info(f"Skipping {symbol} - recently updated")
#                                     except:
#                                         pass
                            
#                             if should_update:
#                                 company_data = parse_company_data(soup, symbol)
#                                 if company_data:
#                                     db.collection('companies').document(symbol).set(company_data)
#                                     doc.reference.update({
#                                         'status': 'completed',
#                                         'completed_at': datetime.now().isoformat(),
#                                         'symbol': symbol,
#                                         'company_name': company_data.get('name', 'Unknown')
#                                     })
#                                     logger.info(f"Successfully processed: {symbol}")
                                    
#                                     # Send notification for new/updated company
#                                     send_company_update_notification(company_data, db)
#                                 else:
#                                     # Parsing failed, retry if possible
#                                     if retry_count < max_retries:
#                                         doc.reference.update({
#                                             'status': 'pending',
#                                             'retry_count': retry_count + 1,
#                                             'last_error': 'Failed to parse company data',
#                                             'last_retry': datetime.now().isoformat()
#                                         })
#                                         logger.warning(f"Parsing failed for {url}, will retry ({retry_count + 1}/{max_retries})")
#                                     else:
#                                         doc.reference.update({
#                                             'status': 'failed',
#                                             'failed_at': datetime.now().isoformat(),
#                                             'error': 'Failed to parse company data after max retries'
#                                         })
#                                         logger.error(f"Max retries reached for parsing {url}")
#                             else:
#                                 # Mark as completed (skipped due to recent update)
#                                 doc.reference.update({
#                                     'status': 'completed',
#                                     'completed_at': datetime.now().isoformat(),
#                                     'symbol': symbol,
#                                     'skipped_reason': 'Recently updated'
#                                 })
#                         else:
#                             # Symbol extraction failed, retry if possible
#                             if retry_count < max_retries:
#                                 doc.reference.update({
#                                     'status': 'pending',
#                                     'retry_count': retry_count + 1,
#                                     'last_error': 'Could not extract symbol',
#                                     'last_retry': datetime.now().isoformat()
#                                 })
#                                 logger.warning(f"Symbol extraction failed for {url}, will retry ({retry_count + 1}/{max_retries})")
#                             else:
#                                 doc.reference.update({
#                                     'status': 'failed',
#                                     'failed_at': datetime.now().isoformat(),
#                                     'error': 'Could not extract symbol after max retries'
#                                 })
#                                 logger.error(f"Max retries reached for symbol extraction {url}")
#                     else:
#                         # Page fetch failed, retry if possible
#                         if retry_count < max_retries:
#                             doc.reference.update({
#                                 'status': 'pending',
#                                 'retry_count': retry_count + 1,
#                                 'last_error': 'Failed to fetch page',
#                                 'last_retry': datetime.now().isoformat()
#                             })
#                             logger.warning(f"Page fetch failed for {url}, will retry ({retry_count + 1}/{max_retries})")
#                         else:
#                             doc.reference.update({
#                                 'status': 'failed',
#                                 'failed_at': datetime.now().isoformat(),
#                                 'error': 'Failed to fetch page after max retries'
#                             })
#                             logger.error(f"Max retries reached for fetching {url}")
                    
#                     # Rate limiting between items
#                     time.sleep(random.uniform(2, 5))
                    
#                 except Exception as e:
#                     logger.error(f"Error processing queue item {url}: {e}")
#                     try:
#                         doc.reference.update({
#                             'status': 'failed',
#                             'failed_at': datetime.now().isoformat(),
#                             'error': str(e)
#                         })
#                     except:
#                         pass  # If we can't update the doc, just continue
        
#         logger.info("Queue processing completed")
        
#     except Exception as e:
#         logger.error(f"Error in queue processing: {e}")

# @https_fn.on_request()
# def get_queue_status_api(req: https_fn.Request) -> https_fn.Response:
#     """HTTP function to get queue status"""
#     try:
#         headers = {
#             'Access-Control-Allow-Origin': '*',
#             'Content-Type': 'application/json'
#         }
        
#         if req.method == 'OPTIONS':
#             headers.update({
#                 'Access-Control-Allow-Methods': 'GET',
#                 'Access-Control-Allow-Headers': 'Content-Type',
#                 'Access-Control-Max-Age': '3600'
#             })
#             return https_fn.Response('', status=204, headers=headers)
        
#         db = get_db()
#         status = get_queue_status(db)
        
#         # Get recent completed items for preview
#         recent_completed = []
#         try:
#             completed_docs = db.collection('scraping_queue')\
#                              .where('status', '==', 'completed')\
#                              .order_by('completed_at', direction=firestore.Query.DESCENDING)\
#                              .limit(10)\
#                              .stream()
            
#             for doc in completed_docs:
#                 data = doc.to_dict()
#                 recent_completed.append({
#                     'symbol': data.get('symbol', 'Unknown'),
#                     'company_name': data.get('company_name', 'Unknown'),
#                     'completed_at': data.get('completed_at', '')
#                 })
#         except Exception as e:
#             logger.error(f"Error getting recent completed items: {e}")
        
#         # Get queue statistics
#         queue_stats = {}
#         try:
#             stats_doc = db.collection('system').document('queue_stats').get()
#             if stats_doc.exists:
#                 queue_stats = stats_doc.to_dict()
#         except Exception as e:
#             logger.error(f"Error getting queue stats: {e}")
        
#         response_data = {
#             'status': 'success',
#             'queue_status': status,
#             'queue_stats': queue_stats,
#             'recent_completed': recent_completed,
#             'timestamp': datetime.now().isoformat()
#         }
        
#         return https_fn.Response(
#             json.dumps(response_data),
#             status=200,
#             headers=headers
#         )
        
#     except Exception as e:
#         logger.error(f"Error getting queue status: {e}")
#         return https_fn.Response(
#             json.dumps({
#                 'status': 'error',
#                 'message': str(e),
#                 'timestamp': datetime.now().isoformat()
#             }),
#             status=500,
#             headers={'Access-Control-Allow-Origin': '*', 'Content-Type': 'application/json'}
#         )

# @https_fn.on_request()
# def manage_queue(req: https_fn.Request) -> https_fn.Response:
#     """HTTP function to manage queue (pause, resume, clear)"""
#     try:
#         headers = {
#             'Access-Control-Allow-Origin': '*',
#             'Content-Type': 'application/json'
#         }
        
#         if req.method == 'OPTIONS':
#             headers.update({
#                 'Access-Control-Allow-Methods': 'POST',
#                 'Access-Control-Allow-Headers': 'Content-Type',
#                 'Access-Control-Max-Age': '3600'
#             })
#             return https_fn.Response('', status=204, headers=headers)
        
#         try:
#             request_json = req.get_json() or {}
#         except Exception:
#             request_json = {}
        
#         action = request_json.get('action')
#         if not action:
#             return https_fn.Response(
#                 json.dumps({'status': 'error', 'message': 'Action is required'}),
#                 status=400,
#                 headers=headers
#             )
        
#         db = get_db()
        
#         if action == 'clear_failed':
#             # Clear all failed items
#             docs = db.collection('scraping_queue').where('status', '==', 'failed').limit(1000).stream()
#             batch = db.batch()
#             count = 0
#             for doc in docs:
#                 batch.delete(doc.reference)
#                 count += 1
#                 if count >= 500:
#                     batch.commit()
#                     batch = db.batch()
#                     count = 0
#             if count > 0:
#                 batch.commit()
                
#             return https_fn.Response(
#                 json.dumps({
#                     'status': 'success',
#                     'message': f'Cleared {count} failed items',
#                     'items_cleared': count
#                 }),
#                 status=200,
#                 headers=headers
#             )
        
#         elif action == 'retry_failed':
#             # Reset failed items to pending
#             docs = db.collection('scraping_queue').where('status', '==', 'failed').limit(100).stream()
#             batch = db.batch()
#             count = 0
#             for doc in docs:
#                 batch.update(doc.reference, {
#                     'status': 'pending',
#                     'retry_count': 0,
#                     'failed_at': firestore.DELETE_FIELD,
#                     'error': firestore.DELETE_FIELD,
#                     'retried_at': datetime.now().isoformat()
#                 })
#                 count += 1
#             if count > 0:
#                 batch.commit()
                
#             return https_fn.Response(
#                 json.dumps({
#                     'status': 'success',
#                     'message': f'Reset {count} failed items to pending',
#                     'items_reset': count
#                 }),
#                 status=200,
#                 headers=headers
#             )
        
#         elif action == 'clear_completed':
#             # Clear completed items older than 1 day
#             cutoff_date = datetime.now() - timedelta(days=1)
#             cutoff_iso = cutoff_date.isoformat()
            
#             docs = db.collection('scraping_queue')\
#                      .where('status', '==', 'completed')\
#                      .where('completed_at', '<', cutoff_iso)\
#                      .limit(1000)\
#                      .stream()
            
#             batch = db.batch()
#             count = 0
#             for doc in docs:
#                 batch.delete(doc.reference)
#                 count += 1
#                 if count >= 500:
#                     batch.commit()
#                     batch = db.batch()
#                     count = 0
#             if count > 0:
#                 batch.commit()
                
#             return https_fn.Response(
#                 json.dumps({
#                     'status': 'success',
#                     'message': f'Cleared {count} old completed items',
#                     'items_cleared': count
#                 }),
#                 status=200,
#                 headers=headers
#             )
        
#         else:
#             return https_fn.Response(
#                 json.dumps({
#                     'status': 'error',
#                     'message': 'Invalid action. Supported: clear_failed, retry_failed, clear_completed'
#                 }),
#                 status=400,
#                 headers=headers
#             )
        
#     except Exception as e:
#         logger.error(f"Error managing queue: {e}")
#         return https_fn.Response(
#             json.dumps({
#                 'status': 'error',
#                 'message': str(e),
#                 'timestamp': datetime.now().isoformat()
#             }),
#             status=500,
#             headers={'Access-Control-Allow-Origin': '*', 'Content-Type': 'application/json'}
#         )

# def send_company_update_notification(company_data, db):
#     """Send notification for company updates"""
#     try:
#         current_price = company_data.get('current_price')
#         if not current_price:
#             return
        
#         doc_ref = db.collection('companies').document(company_data['symbol'])
#         existing_doc = doc_ref.get()
        
#         if existing_doc.exists:
#             existing_data = existing_doc.to_dict()
#             old_price = existing_data.get('current_price')
            
#             if old_price and current_price:
#                 change_percent = abs((current_price - old_price) / old_price * 100)
                
#                 if change_percent < 2:
#                     return
        
#         notification = messaging.Notification(
#             title=f"Stock Update: {company_data['name']}",
#             body=f"Current Price: ₹{current_price} | P/E: {company_data.get('stock_pe', 'N/A')}"
#         )
        
#         message = messaging.Message(
#             notification=notification,
#             data={
#                 'symbol': company_data['symbol'],
#                 'name': company_data['name'],
#                 'current_price': str(current_price),
#                 'market_cap': str(company_data.get('market_cap', '')),
#                 'pe': str(company_data.get('stock_pe', '')),
#                 'type': 'company_update'
#             },
#             topic='company_updates'
#         )
        
#         response = messaging.send(message)
#         logger.info(f"Notification sent for {company_data['symbol']}: {response}")
        
#     except Exception as e:
#         logger.error(f"Error sending notification: {e}")

# @https_fn.on_request()
# def get_companies_data(req: https_fn.Request) -> https_fn.Response:
#     """HTTP function to retrieve complete companies data"""
#     try:
#         headers = {
#             'Access-Control-Allow-Origin': '*',
#             'Content-Type': 'application/json'
#         }
        
#         if req.method == 'OPTIONS':
#             headers.update({
#                 'Access-Control-Allow-Methods': 'GET',
#                 'Access-Control-Allow-Headers': 'Content-Type',
#                 'Access-Control-Max-Age': '3600'
#             })
#             return https_fn.Response('', status=204, headers=headers)
        
#         db = get_db()
        
#         limit = int(req.args.get('limit', '50'))
#         symbol = req.args.get('symbol', None)
        
#         companies_ref = db.collection('companies')
        
#         if symbol:
#             doc = companies_ref.document(symbol).get()
#             if doc.exists:
#                 data = doc.to_dict()
#                 response = {
#                     'status': 'success',
#                     'data': data,
#                     'timestamp': datetime.now().isoformat()
#                 }
#                 return https_fn.Response(
#                     json.dumps(response, default=str),
#                     status=200,
#                     headers=headers
#                 )
#             else:
#                 error_response = {
#                     'status': 'error',
#                     'message': 'Company not found',
#                     'timestamp': datetime.now().isoformat()
#                 }
#                 return https_fn.Response(
#                     json.dumps(error_response),
#                     status=404,
#                     headers=headers
#                 )
#         else:
#             docs = companies_ref.limit(limit).stream()
#             companies = []
#             for doc in docs:
#                 data = doc.to_dict()
#                 data['id'] = doc.id
#                 companies.append(data)
            
#             response = {
#                 'status': 'success',
#                 'data': companies,
#                 'count': len(companies),
#                 'timestamp': datetime.now().isoformat()
#             }
            
#             return https_fn.Response(
#                 json.dumps(response, default=str),
#                 status=200,
#                 headers=headers
#             )
        
#     except Exception as e:
#         logger.error(f"Error retrieving companies data: {e}")
#         error_response = {
#             'status': 'error',
#             'message': str(e),
#             'timestamp': datetime.now().isoformat()
#         }
#         return https_fn.Response(
#             json.dumps(error_response),
#             status=500,
#             headers={'Access-Control-Allow-Origin': '*', 'Content-Type': 'application/json'}
#         )

# # Legacy function for backward compatibility (now just queues jobs)
# @https_fn.on_request()
# def manual_scrape_trigger(req: https_fn.Request) -> https_fn.Response:
#     """HTTP function to trigger queue-based scraping (backward compatible)"""
#     try:
#         headers = {
#             'Access-Control-Allow-Origin': '*',
#             'Content-Type': 'application/json'
#         }
        
#         if req.method == 'OPTIONS':
#             headers.update({
#                 'Access-Control-Allow-Methods': 'POST',
#                 'Access-Control-Allow-Headers': 'Content-Type',
#                 'Access-Control-Max-Age': '3600'
#             })
#             return https_fn.Response('', status=204, headers=headers)
        
#         logger.info("Manual scraping trigger called - redirecting to queue-based approach")
        
#         try:
#             request_json = req.get_json() or {}
#         except Exception:
#             request_json = {}
        
#         if request_json.get('test', False):
#             logger.info("Test request received")
#             response_data = {
#                 'status': 'success',
#                 'message': 'Queue-based scraping system is ready',
#                 'timestamp': datetime.now().isoformat(),
#                 'test_mode': True
#             }
#             return https_fn.Response(
#                 json.dumps(response_data),
#                 status=200,
#                 headers=headers
#             )
        
#         # Redirect to queue creation
#         db = get_db()
        
#         # Check current queue status
#         status = get_queue_status(db)
        
#         if status.get('pending', 0) > 100:
#             return https_fn.Response(
#                 json.dumps({
#                     'status': 'info',
#                     'message': f'Queue already has {status["pending"]} pending items. Use /queue_scraping_jobs to add more or wait for processing.',
#                     'queue_status': status,
#                     'timestamp': datetime.now().isoformat()
#                 }),
#                 status=200,
#                 headers=headers
#             )
        
#         response_data = {
#             'status': 'success',
#             'message': 'This endpoint now uses queue-based processing. Call /queue_scraping_jobs to add items to queue.',
#             'recommendation': 'Use /queue_scraping_jobs to queue new scraping jobs',
#             'current_queue_status': status,
#             'timestamp': datetime.now().isoformat()
#         }
        
#         return https_fn.Response(
#             json.dumps(response_data),
#             status=200,
#             headers=headers
#         )
        
#     except Exception as e:
#         logger.error(f"Error in manual trigger: {e}")
#         error_response = {
#             'status': 'error',
#             'message': str(e),
#             'timestamp': datetime.now().isoformat()
#         }
#         return https_fn.Response(
#             json.dumps(error_response),
#             status=500,
#             headers={'Access-Control-Allow-Origin': '*', 'Content-Type': 'application/json'}
#         )

# from firebase_functions import https_fn, scheduler_fn
# from firebase_admin import initialize_app, firestore, messaging
# import requests
# import re
# import time
# import random
# from datetime import datetime, timedelta
# from bs4 import BeautifulSoup
# import json

# # Initialize Firebase Admin SDK
# initialize_app()

# # Configuration - keep all your user agents
# USER_AGENTS = [
#     'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36',
#     'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36',
#     'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:126.0) Gecko/20100101 Firefox/126.0',
#     'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36'
# ]

# def get_db():
#     """Get Firestore client"""
#     return firestore.client()

# # --- FCM NOTIFICATION FUNCTIONS ---
# def send_job_notification(title, body, data=None):
#     """Send FCM push notification to all subscribed devices"""
#     try:
#         message = messaging.Message(
#             notification=messaging.Notification(title=title, body=body),
#             topic='job_status',
#             data=data or {},
#             android=messaging.AndroidConfig(
#                 notification=messaging.AndroidNotification(
#                     icon='ic_notification',
#                     color='#4CAF50',
#                     sound='default',
#                     channel_id='job_notifications',
#                 ),
#                 priority='high',
#             ),
#         )
#         response = messaging.send(message)
#         return response
#     except Exception:
#         return None

# def notify_job_complete(companies_processed, failed_count=0):
#     """Send FCM notification when job completes"""
#     if failed_count == 0:
#         send_job_notification(
#             title="🎉 Job Completed!",
#             body=f"Successfully processed {companies_processed} companies with full financial data",
#             data={'type': 'job_completed', 'companies_processed': str(companies_processed)}
#         )
#     else:
#         send_job_notification(
#             title="⚠️ Job Completed with Issues",
#             body=f"Processed {companies_processed} companies, {failed_count} failed",
#             data={'type': 'job_completed_with_errors', 'companies_processed': str(companies_processed)}
#         )

# def notify_job_failed(error_message):
#     """Send FCM notification when job fails"""
#     send_job_notification(
#         title="❌ Job Failed",
#         body=f"Job failed: {error_message}",
#         data={'type': 'job_failed', 'error': str(error_message)}
#     )

# # --- NETWORKING FUNCTIONS (UNCHANGED) ---
# def fetch_page(session, url, retries=3, backoff_factor=0.8, referer=None):
#     """Fetches a URL using session with retry mechanism - NO LOGGING"""
#     headers = {
#         'User-Agent': random.choice(USER_AGENTS),
#         'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
#         'Accept-Language': 'en-US,en;q=0.9',
#         'Connection': 'keep-alive',
#         'Upgrade-Insecure-Requests': '1',
#     }
    
#     if referer:
#         headers['Referer'] = referer
    
#     for attempt in range(retries):
#         try:
#             response = session.get(url, headers=headers, timeout=30)
#             response.raise_for_status()
#             return response
#         except Exception:
#             if attempt < retries - 1:
#                 wait_time = backoff_factor * (2 ** attempt) + random.uniform(0, 1)
#                 time.sleep(wait_time)
#     return None

# # --- COMPLETE SYMBOL EXTRACTION (UNCHANGED) ---
# def extract_symbol_from_page(soup, url):
#     """Extract the actual stock symbol from the company page"""
#     # Method 1: Try to get from NSE link
#     nse_link = soup.select_one('a[href*="nseindia.com"]')
#     if nse_link:
#         nse_text = nse_link.get_text(strip=True)
#         if 'NSE:' in nse_text:
#             symbol = nse_text.replace('NSE:', '').strip()
#             if symbol:
#                 return symbol
    
#     # Method 2: Try to get from the URL structure
#     url_parts = url.strip('/').split('/')
#     if len(url_parts) >= 2:
#         potential_symbol = url_parts[-2] if url_parts[-1] == 'consolidated' else url_parts[-1]
#         if potential_symbol and potential_symbol != 'company':
#             return potential_symbol
    
#     # Method 3: Try to extract from page structure
#     breadcrumb = soup.select_one('.breadcrumb')
#     if breadcrumb:
#         breadcrumb_text = breadcrumb.get_text(strip=True)
#         symbol_match = re.search(r'\b([A-Z]{2,10})\b', breadcrumb_text)
#         if symbol_match:
#             return symbol_match.group(1)
    
#     # Method 4: Extract from company nav or title
#     company_nav = soup.select_one('.company-nav h1') or soup.select_one('h1.margin-0')
#     if company_nav:
#         nav_text = company_nav.get_text(strip=True)
#         symbol_match = re.search(r'^([A-Z]{2,10})', nav_text)
#         if symbol_match:
#             return symbol_match.group(1)
    
#     return None

# # --- COMPLETE PARSING FUNCTIONS (RESTORED) ---
# def clean_text(text, field_name=""):
#     """Clean and format text data"""
#     if not text:
#         return None
    
#     if field_name in ["bse_code", "nse_code"]:
#         return text.strip().replace('BSE:', '').replace('NSE:', '').strip()
    
#     return text.strip().replace('₹', '').replace(',', '').replace('%', '').replace('Cr.', '').strip()

# def parse_number(text):
#     """Parse numeric values from text"""
#     cleaned = clean_text(text)
#     if cleaned in [None, '']:
#         return None
    
#     match = re.search(r'[-+]?\d*\.\d+|\d+', cleaned)
#     if match:
#         try:
#             return float(match.group(0))
#         except (ValueError, TypeError):
#             return None
#     return None

# def get_calendar_sort_key(header_string):
#     """Sort calendar headers"""
#     MONTH_MAP = {
#         'Jan': 1, 'Feb': 2, 'Mar': 3, 'Apr': 4, 'May': 5, 'Jun': 6,
#         'Jul': 7, 'Aug': 8, 'Sep': 9, 'Oct': 10, 'Nov': 11, 'Dec': 12
#     }
    
#     try:
#         month_str, year_str = header_string.strip().split()
#         return (int(year_str), MONTH_MAP.get(month_str, 0))
#     except (ValueError, KeyError, IndexError):
#         try:
#             return (int(header_string), 0)
#         except (ValueError, TypeError):
#             return (0, 0)

# def parse_website_link(soup):
#     """Parse company website"""
#     company_links_div = soup.select_one('div.company-links')
#     if not company_links_div:
#         return None
    
#     all_links = company_links_div.find_all('a', href=True)
#     for link in all_links:
#         href = link['href']
#         if 'bseindia.com' not in href and 'nseindia.com' not in href:
#             return href
#     return None

# def parse_financial_table(soup, table_id):
#     """Parse financial tables - COMPLETE VERSION"""
#     section = soup.select_one(f'section#{table_id}')
#     if not section:
#         return {}
    
#     table = section.select_one('table.data-table')
#     if not table:
#         return {}
    
#     original_headers = [th.get_text(strip=True) for th in table.select('thead th')][1:]
#     if not original_headers:
#         return {}
    
#     sorted_headers = sorted(original_headers, key=get_calendar_sort_key, reverse=True)
    
#     body_data = []
#     for row in table.select('tbody tr'):
#         cols = row.select('td')
#         if not cols or 'sub' in row.get('class', []):
#             continue
        
#         row_name = cols[0].get_text(strip=True).replace('+', '').strip()
#         if not row_name:
#             continue
        
#         original_values = [col.get_text(strip=True) for col in cols[1:]]
#         value_map = dict(zip(original_headers, original_values))
#         sorted_values = [value_map.get(h, '') for h in sorted_headers]
        
#         body_data.append({
#             'Description': row_name,
#             'values': sorted_values
#         })
    
#     return {
#         'headers': sorted_headers,
#         'body': body_data
#     }

# def parse_shareholding_table(soup, table_id):
#     """Parse shareholding tables - COMPLETE VERSION"""
#     table = soup.select_one(f'div#{table_id} table.data-table')
#     if not table:
#         return {}
    
#     original_headers = [th.get_text(strip=True) for th in table.select('thead th')][1:]
#     sorted_headers = sorted(original_headers, key=get_calendar_sort_key, reverse=True)
    
#     data = {}
#     for row in table.select('tbody tr'):
#         cols = row.select('td')
#         if not cols or 'sub' in row.get('class', []):
#             continue
        
#         row_name = cols[0].get_text(strip=True).replace('+', '').strip()
#         if not row_name:
#             continue
        
#         original_values = [col.get_text(strip=True) for col in cols[1:]]
#         value_map = dict(zip(original_headers, original_values))
#         row_data = {h: value_map.get(h, '') for h in sorted_headers}
#         data[row_name] = row_data
    
#     return data

# def parse_growth_tables(soup):
#     """Parse growth tables - COMPLETE VERSION"""
#     data = {}
#     pl_section = soup.select_one('section#profit-loss')
#     if not pl_section:
#         return data
    
#     tables = pl_section.select('table.ranges-table')
#     for table in tables:
#         title_elem = table.select_one('th')
#         if title_elem:
#             title = title_elem.get_text(strip=True).replace(':', '')
#             table_data = {}
            
#             for row in table.select('tr')[1:]:
#                 cols = row.select('td')
#                 if len(cols) == 2:
#                     key = cols[0].get_text(strip=True).replace(':', '')
#                     value = cols[1].get_text(strip=True)
#                     table_data[key] = value
            
#             data[title] = table_data
    
#     return data

# def process_industry_path(soup):
#     """Process industry classification - COMPLETE VERSION"""
#     peers_section = soup.select_one('section#peers')
#     if not peers_section:
#         return None
    
#     path_paragraph = peers_section.select_one('p.sub:not(#benchmarks)')
#     if not path_paragraph:
#         return None
    
#     path_links = path_paragraph.select('a')
#     if not path_links:
#         return None
    
#     path_names = [link.get_text(strip=True).replace('&amp;', 'and') for link in path_links]
#     return path_names

# def parse_company_data(soup, symbol):
#     """COMPLETE company data parsing - ALL ORIGINAL DATA RESTORED"""
#     try:
#         # Basic company info
#         company_name_elem = soup.select_one('h1.margin-0') or soup.select_one('.company-nav h1')
#         company_name = company_name_elem.get_text(strip=True) if company_name_elem else f"Company {symbol}"
        
#         # Clean up company name for display
#         display_name = re.sub(r'\s+(Ltd|Limited|Corporation|Corp|Inc)\.?$', '', company_name, flags=re.IGNORECASE).strip()
        
#         # Ratios data
#         ratios_data = {}
#         for li in soup.select('#top-ratios li'):
#             name_elem = li.select_one('.name')
#             value_elem = li.select_one('.value')
#             if name_elem and value_elem:
#                 ratios_data[name_elem.get_text(strip=True)] = value_elem.get_text(strip=True)
        
#         # About section
#         about_elem = soup.select_one('.company-profile .about p')
#         about = about_elem.get_text(strip=True) if about_elem else None
        
#         # Stock codes - improved extraction
#         bse_link = soup.select_one('a[href*="bseindia.com"]')
#         nse_link = soup.select_one('a[href*="nseindia.com"]')
        
#         # Extract BSE code
#         bse_code = None
#         if bse_link:
#             bse_text = bse_link.get_text(strip=True)
#             bse_match = re.search(r'BSE:\s*(\d+)', bse_text)
#             if bse_match:
#                 bse_code = bse_match.group(1)
        
#         # Extract NSE code
#         nse_code = None
#         if nse_link:
#             nse_text = nse_link.get_text(strip=True)
#             nse_match = re.search(r'NSE:\s*([A-Z0-9]+)', nse_text)
#             if nse_match:
#                 nse_code = nse_match.group(1)
        
#         # Use NSE code as symbol if available
#         final_symbol = nse_code if nse_code else symbol
        
#         # Pros and cons
#         pros = [li.get_text(strip=True) for li in soup.select('.pros ul li')]
#         cons = [li.get_text(strip=True) for li in soup.select('.cons ul li')]
        
#         # Return COMPLETE data with ALL tables and ratios
#         return {
#             'symbol': final_symbol,
#             'name': company_name,
#             'display_name': display_name,
#             'about': about,
#             'website': parse_website_link(soup),
#             'bse_code': bse_code,
#             'nse_code': final_symbol,
#             'market_cap': parse_number(ratios_data.get('Market Cap')),
#             'current_price': parse_number(ratios_data.get('Current Price')),
#             'high_low': clean_text(ratios_data.get('High / Low')),
#             'stock_pe': parse_number(ratios_data.get('Stock P/E')),
#             'book_value': parse_number(ratios_data.get('Book Value')),
#             'dividend_yield': parse_number(ratios_data.get('Dividend Yield')),
#             'roce': parse_number(ratios_data.get('ROCE')),
#             'roe': parse_number(ratios_data.get('ROE')),
#             'face_value': parse_number(ratios_data.get('Face Value')),
#             'pros': pros,
#             'cons': cons,
#             'last_updated': datetime.now().isoformat(),
#             'change_percent': 0.0,
#             'change_amount': 0.0,
#             'previous_close': parse_number(ratios_data.get('Current Price', '0.0')) or 0.0,
            
#             # ALL FINANCIAL STATEMENTS - COMPLETE DATA
#             'quarterly_results': parse_financial_table(soup, 'quarters'),
#             'profit_loss_statement': parse_financial_table(soup, 'profit-loss'),
#             'balance_sheet': parse_financial_table(soup, 'balance-sheet'),
#             'cash_flow_statement': parse_financial_table(soup, 'cash-flow'),
#             'ratios': parse_financial_table(soup, 'ratios'),
            
#             # INDUSTRY AND SHAREHOLDING - COMPLETE DATA
#             'industry_classification': process_industry_path(soup),
#             'shareholding_pattern': {
#                 'quarterly': parse_shareholding_table(soup, 'quarterly-shp')
#             },
            
#             # GROWTH TABLES - COMPLETE DATA
#             **parse_growth_tables(soup),
            
#             # RAW RATIOS DATA - COMPLETE DATA
#             'ratios_data': ratios_data
#         }
        
#     except Exception:
#         return None

# # --- QUEUE STATUS FUNCTIONS (RESTORED) ---
# def get_queue_status(db):
#     """Get current queue status"""
#     try:
#         pending_count = len(list(db.collection('scraping_queue').where('status', '==', 'pending').limit(1000).stream()))
#         processing_count = len(list(db.collection('scraping_queue').where('status', '==', 'processing').limit(1000).stream()))
#         completed_count = len(list(db.collection('scraping_queue').where('status', '==', 'completed').limit(1000).stream()))
#         failed_count = len(list(db.collection('scraping_queue').where('status', '==', 'failed').limit(1000).stream()))
        
#         return {
#             'pending': pending_count,
#             'processing': processing_count,
#             'completed': completed_count,
#             'failed': failed_count,
#             'total': pending_count + processing_count + completed_count + failed_count,
#             'is_active': processing_count > 0 or pending_count > 0,
#             'is_completed': pending_count == 0 and processing_count == 0 and completed_count > 0,
#             'progress_percentage': ((completed_count + failed_count) / max(1, pending_count + processing_count + completed_count + failed_count)) * 100,
#             'status_text': 'Active' if processing_count > 0 or pending_count > 0 else ('Completed' if completed_count > 0 else 'Ready'),
#             'timestamp': datetime.now().isoformat()
#         }
#     except Exception as e:
#         return {'error': str(e)}

# def cleanup_old_queue_items(db):
#     """Clean up old completed and failed queue items - NO LOGGING"""
#     try:
#         cutoff_date = datetime.now() - timedelta(days=7)
#         cutoff_iso = cutoff_date.isoformat()
        
#         # Delete old completed items
#         completed_docs = db.collection('scraping_queue')\
#                           .where('status', '==', 'completed')\
#                           .where('completed_at', '<', cutoff_iso)\
#                           .limit(100)\
#                           .stream()
        
#         batch = db.batch()
#         count = 0
#         for doc in completed_docs:
#             batch.delete(doc.reference)
#             count += 1
        
#         if count > 0:
#             batch.commit()
        
#         # Delete old failed items
#         failed_docs = db.collection('scraping_queue')\
#                      .where('status', '==', 'failed')\
#                      .where('failed_at', '<', cutoff_iso)\
#                      .limit(100)\
#                      .stream()
        
#         batch = db.batch()
#         count = 0
#         for doc in failed_docs:
#             batch.delete(doc.reference)
#             count += 1
        
#         if count > 0:
#             batch.commit()
            
#     except Exception:
#         pass

# def reset_stale_processing_items(db):
#     """Reset items that have been processing for too long - NO LOGGING"""
#     try:
#         cutoff_time = datetime.now() - timedelta(minutes=30)
#         cutoff_iso = cutoff_time.isoformat()
        
#         stale_docs = db.collection('scraping_queue')\
#                       .where('status', '==', 'processing')\
#                       .where('started_at', '<', cutoff_iso)\
#                       .limit(50)\
#                       .stream()
        
#         batch = db.batch()
#         count = 0
#         for doc in stale_docs:
#             batch.update(doc.reference, {
#                 'status': 'pending',
#                 'started_at': firestore.DELETE_FIELD,
#                 'reset_count': firestore.Increment(1),
#                 'reset_at': datetime.now().isoformat()
#             })
#             count += 1
        
#         if count > 0:
#             batch.commit()
            
#     except Exception:
#         pass

# # --- HTTP FUNCTIONS (COMPLETE, NO LOGGING) ---
# @https_fn.on_request()
# def queue_scraping_jobs(req: https_fn.Request) -> https_fn.Response:
#     """Queue individual scraping jobs for processing - NO LOGGING"""
#     try:
#         headers = {
#             'Access-Control-Allow-Origin': '*',
#             'Content-Type': 'application/json'
#         }
        
#         if req.method == 'OPTIONS':
#             headers.update({
#                 'Access-Control-Allow-Methods': 'POST',
#                 'Access-Control-Allow-Headers': 'Content-Type',
#                 'Access-Control-Max-Age': '3600'
#             })
#             return https_fn.Response('', status=204, headers=headers)
        
#         db = get_db()
        
#         try:
#             request_json = req.get_json() or {}
#         except Exception:
#             request_json = {}
        
#         clear_queue = request_json.get('clear_existing', False)
#         max_pages = request_json.get('max_pages', 50)
        
#         if clear_queue:
#             # Clear existing pending and failed items
#             for status in ['pending', 'failed']:
#                 docs = db.collection('scraping_queue').where('status', '==', status).limit(500).stream()
#                 batch = db.batch()
#                 count = 0
#                 for doc in docs:
#                     batch.delete(doc.reference)
#                     count += 1
#                     if count >= 500:
#                         batch.commit()
#                         batch = db.batch()
#                         count = 0
#                 if count > 0:
#                     batch.commit()
        
#         # Collect URLs
#         company_urls = []
        
#         with requests.Session() as session:
#             for page in range(1, max_pages + 1):
#                 list_url = f"https://www.screener.in/screens/515361/largecaptop-100midcap101-250smallcap251/?page={page}"
#                 response = fetch_page(session, list_url)
                
#                 if not response:
#                     break
                
#                 list_soup = BeautifulSoup(response.content, 'lxml')
#                 rows = list_soup.select('table.data-table tr[data-row-company-id]')
                
#                 if not rows:
#                     break
                
#                 for row in rows:
#                     link_tag = row.select_one('a')
#                     if link_tag and link_tag.get('href'):
#                         company_url = f"https://www.screener.in{link_tag['href']}"
#                         company_urls.append(company_url)
                
#                 time.sleep(random.uniform(1, 3))
        
#         if not company_urls:
#             notify_job_failed("No company URLs found")
#             return https_fn.Response(
#                 json.dumps({'status': 'error', 'message': 'No company URLs found to queue'}),
#                 status=400, headers=headers
#             )
        
#         # Add URLs to Firestore queue in batches
#         batch_size = 500
#         total_queued = 0
        
#         for i in range(0, len(company_urls), batch_size):
#             batch = db.batch()
#             batch_urls = company_urls[i:i + batch_size]
            
#             for url in batch_urls:
#                 doc_ref = db.collection('scraping_queue').document()
#                 batch.set(doc_ref, {
#                     'url': url,
#                     'status': 'pending',
#                     'created_at': datetime.now().isoformat(),
#                     'priority': 'normal',
#                     'retry_count': 0,
#                     'max_retries': 3
#                 })
            
#             batch.commit()
#             total_queued += len(batch_urls)
        
#         return https_fn.Response(
#             json.dumps({
#                 'status': 'success',
#                 'message': f'Successfully queued {total_queued} companies for comprehensive data scraping',
#                 'queued_count': total_queued,
#                 'pages_processed': max_pages,
#                 'timestamp': datetime.now().isoformat()
#             }),
#             status=200, headers=headers
#         )
        
#     except Exception as e:
#         notify_job_failed(str(e))
#         return https_fn.Response(
#             json.dumps({'status': 'error', 'message': str(e)}),
#             status=500, headers=headers
#         )

# @scheduler_fn.on_schedule(
#     schedule="*/3 * * * *",
#     timezone=scheduler_fn.Timezone("Asia/Kolkata")
# )
# def process_scraping_queue(event: scheduler_fn.ScheduledEvent) -> None:
#     """Process items from scraping queue with COMPLETE data parsing - NO LOGGING"""
#     try:
#         db = get_db()
        
#         cleanup_old_queue_items(db)
#         reset_stale_processing_items(db)
        
#         queue_items = db.collection('scraping_queue')\
#                        .where('status', '==', 'pending')\
#                        .order_by('created_at')\
#                        .limit(5)\
#                        .stream()
        
#         items_to_process = list(queue_items)
        
#         if not items_to_process:
#             return
        
#         processed_count = 0
#         failed_count = 0
        
#         with requests.Session() as session:
#             for doc in items_to_process:
#                 try:
#                     data = doc.to_dict()
#                     url = data['url']
#                     retry_count = data.get('retry_count', 0)
#                     max_retries = data.get('max_retries', 3)
                    
#                     # Update status to processing
#                     doc.reference.update({
#                         'status': 'processing',
#                         'started_at': datetime.now().isoformat(),
#                         'processor_id': 'scheduler_worker'
#                     })
                    
#                     response = fetch_page(session, url, retries=2)
                    
#                     if response:
#                         soup = BeautifulSoup(response.content, 'lxml')
#                         symbol = extract_symbol_from_page(soup, url)
                        
#                         if symbol:
#                             # Check if company should be updated
#                             existing_doc = db.collection('companies').document(symbol).get()
#                             should_update = True
                            
#                             if existing_doc.exists:
#                                 existing_data = existing_doc.to_dict()
#                                 last_updated = existing_data.get('last_updated')
#                                 if last_updated:
#                                     try:
#                                         last_update_time = datetime.fromisoformat(last_updated.replace('Z', '+00:00'))
#                                         if datetime.now() - last_update_time < timedelta(hours=6):
#                                             should_update = False
#                                     except:
#                                         pass
                            
#                             if should_update:
#                                 # Parse COMPLETE company data with ALL tables
#                                 company_data = parse_company_data(soup, symbol)
#                                 if company_data:
#                                     db.collection('companies').document(symbol).set(company_data)
#                                     doc.reference.update({
#                                         'status': 'completed',
#                                         'completed_at': datetime.now().isoformat(),
#                                         'symbol': symbol,
#                                         'company_name': company_data.get('name', 'Unknown')
#                                     })
#                                     processed_count += 1
#                                 else:
#                                     # Parsing failed, retry if possible
#                                     if retry_count < max_retries:
#                                         doc.reference.update({
#                                             'status': 'pending',
#                                             'retry_count': retry_count + 1,
#                                             'last_retry': datetime.now().isoformat()
#                                         })
#                                     else:
#                                         doc.reference.update({
#                                             'status': 'failed',
#                                             'failed_at': datetime.now().isoformat(),
#                                             'error': 'Failed to parse complete company data'
#                                         })
#                                         failed_count += 1
#                             else:
#                                 # Mark as completed (skipped due to recent update)
#                                 doc.reference.update({
#                                     'status': 'completed',
#                                     'completed_at': datetime.now().isoformat(),
#                                     'symbol': symbol,
#                                     'skipped_reason': 'Recently updated'
#                                 })
#                         else:
#                             # Symbol extraction failed, retry if possible
#                             if retry_count < max_retries:
#                                 doc.reference.update({
#                                     'status': 'pending',
#                                     'retry_count': retry_count + 1,
#                                     'last_retry': datetime.now().isoformat()
#                                 })
#                             else:
#                                 doc.reference.update({
#                                     'status': 'failed',
#                                     'failed_at': datetime.now().isoformat(),
#                                     'error': 'Could not extract symbol'
#                                 })
#                                 failed_count += 1
#                     else:
#                         # Page fetch failed, retry if possible
#                         if retry_count < max_retries:
#                             doc.reference.update({
#                                 'status': 'pending',
#                                 'retry_count': retry_count + 1,
#                                 'last_retry': datetime.now().isoformat()
#                             })
#                         else:
#                             doc.reference.update({
#                                 'status': 'failed',
#                                 'failed_at': datetime.now().isoformat(),
#                                 'error': 'Failed to fetch page'
#                             })
#                             failed_count += 1
                    
#                     time.sleep(random.uniform(2, 5))
                    
#                 except Exception:
#                     try:
#                         doc.reference.update({
#                             'status': 'failed',
#                             'failed_at': datetime.now().isoformat()
#                         })
#                         failed_count += 1
#                     except:
#                         pass
        
#         # Send FCM notification for batch completion
#         if processed_count > 0 or failed_count > 0:
#             notify_job_complete(processed_count, failed_count)
        
#     except Exception as e:
#         notify_job_failed(str(e))

# # --- QUEUE STATUS API (RESTORED) ---
# @https_fn.on_request()
# def get_queue_status_api(req: https_fn.Request) -> https_fn.Response:
#     """HTTP function to get queue status"""
#     try:
#         headers = {
#             'Access-Control-Allow-Origin': '*',
#             'Content-Type': 'application/json'
#         }
        
#         if req.method == 'OPTIONS':
#             headers.update({
#                 'Access-Control-Allow-Methods': 'GET',
#                 'Access-Control-Allow-Headers': 'Content-Type',
#                 'Access-Control-Max-Age': '3600'
#             })
#             return https_fn.Response('', status=204, headers=headers)
        
#         db = get_db()
#         status = get_queue_status(db)
        
#         # Get recent completed items
#         recent_completed = []
#         try:
#             completed_docs = db.collection('scraping_queue')\
#                              .where('status', '==', 'completed')\
#                              .order_by('completed_at', direction=firestore.Query.DESCENDING)\
#                              .limit(10)\
#                              .stream()
            
#             for doc in completed_docs:
#                 data = doc.to_dict()
#                 recent_completed.append({
#                     'symbol': data.get('symbol', 'Unknown'),
#                     'company_name': data.get('company_name', 'Unknown'),
#                     'completed_at': data.get('completed_at', '')
#                 })
#         except Exception:
#             pass
        
#         response_data = {
#             'status': 'success',
#             'queue_status': status,
#             'recent_completed': recent_completed,
#             'timestamp': datetime.now().isoformat()
#         }
        
#         return https_fn.Response(
#             json.dumps(response_data),
#             status=200, headers=headers
#         )
        
#     except Exception as e:
#         return https_fn.Response(
#             json.dumps({'status': 'error', 'message': str(e)}),
#             status=500, headers=headers
#         )

# # --- QUEUE MANAGEMENT (RESTORED) ---
# @https_fn.on_request()
# def manage_queue(req: https_fn.Request) -> https_fn.Response:
#     """HTTP function to manage queue (clear, retry)"""
#     try:
#         headers = {
#             'Access-Control-Allow-Origin': '*',
#             'Content-Type': 'application/json'
#         }
        
#         if req.method == 'OPTIONS':
#             headers.update({
#                 'Access-Control-Allow-Methods': 'POST',
#                 'Access-Control-Allow-Headers': 'Content-Type',
#                 'Access-Control-Max-Age': '3600'
#             })
#             return https_fn.Response('', status=204, headers=headers)
        
#         try:
#             request_json = req.get_json() or {}
#         except Exception:
#             request_json = {}
        
#         action = request_json.get('action')
#         if not action:
#             return https_fn.Response(
#                 json.dumps({'status': 'error', 'message': 'Action is required'}),
#                 status=400, headers=headers
#             )
        
#         db = get_db()
        
#         if action == 'clear_failed':
#             docs = db.collection('scraping_queue').where('status', '==', 'failed').limit(1000).stream()
#             batch = db.batch()
#             count = 0
#             for doc in docs:
#                 batch.delete(doc.reference)
#                 count += 1
#                 if count >= 500:
#                     batch.commit()
#                     batch = db.batch()
#                     count = 0
#             if count > 0:
#                 batch.commit()
                
#             return https_fn.Response(
#                 json.dumps({'status': 'success', 'message': f'Cleared {count} failed items'}),
#                 status=200, headers=headers
#             )
        
#         elif action == 'retry_failed':
#             docs = db.collection('scraping_queue').where('status', '==', 'failed').limit(100).stream()
#             batch = db.batch()
#             count = 0
#             for doc in docs:
#                 batch.update(doc.reference, {
#                     'status': 'pending',
#                     'retry_count': 0,
#                     'failed_at': firestore.DELETE_FIELD,
#                     'error': firestore.DELETE_FIELD,
#                     'retried_at': datetime.now().isoformat()
#                 })
#                 count += 1
#             if count > 0:
#                 batch.commit()
                
#             return https_fn.Response(
#                 json.dumps({'status': 'success', 'message': f'Reset {count} failed items to pending'}),
#                 status=200, headers=headers
#             )
        
#         else:
#             return https_fn.Response(
#                 json.dumps({'status': 'error', 'message': 'Invalid action'}),
#                 status=400, headers=headers
#             )
        
#     except Exception as e:
#         return https_fn.Response(
#             json.dumps({'status': 'error', 'message': str(e)}),
#             status=500, headers=headers
#         )

# # --- LEGACY COMPATIBILITY (RESTORED) ---
# @https_fn.on_request()
# def manual_scrape_trigger(req: https_fn.Request) -> https_fn.Response:
#     """HTTP function for backward compatibility"""
#     try:
#         headers = {
#             'Access-Control-Allow-Origin': '*',
#             'Content-Type': 'application/json'
#         }
        
#         if req.method == 'OPTIONS':
#             headers.update({
#                 'Access-Control-Allow-Methods': 'POST',
#                 'Access-Control-Allow-Headers': 'Content-Type',
#                 'Access-Control-Max-Age': '3600'
#             })
#             return https_fn.Response('', status=204, headers=headers)
        
#         try:
#             request_json = req.get_json() or {}
#         except Exception:
#             request_json = {}
        
#         if request_json.get('test', False):
#             response_data = {
#                 'status': 'success',
#                 'message': 'Complete data scraping system is ready with all financial tables',
#                 'timestamp': datetime.now().isoformat(),
#                 'test_mode': True
#             }
#             return https_fn.Response(
#                 json.dumps(response_data),
#                 status=200, headers=headers
#             )
        
#         db = get_db()
#         status = get_queue_status(db)
        
#         response_data = {
#             'status': 'success',
#             'message': 'Comprehensive data scraping with complete financial statements. You will receive push notification when complete.',
#             'current_queue_status': status,
#             'timestamp': datetime.now().isoformat()
#         }
        
#         return https_fn.Response(
#             json.dumps(response_data),
#             status=200, headers=headers
#         )
        
#     except Exception as e:
#         return https_fn.Response(
#             json.dumps({'status': 'error', 'message': str(e)}),
#             status=500, headers=headers
#         )
from firebase_functions import https_fn, scheduler_fn
from firebase_admin import initialize_app, firestore, messaging
from google.cloud.firestore_v1.base_query import FieldFilter
import requests
import re
import time
import random
from datetime import datetime, timedelta
from bs4 import BeautifulSoup
import json

initialize_app()

USER_AGENTS = [
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36',
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:126.0) Gecko/20100101 Firefox/126.0',
    'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36'
]

def get_db():
    return firestore.client()

def send_job_notification(title, body, data=None):
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
    if failed_count == 0:
        send_job_notification(
            title="🎉 Job Completed!",
            body=f"Successfully processed {companies_processed} companies with full financial data",
            data={'type': 'job_completed', 'companies_processed': str(companies_processed)}
        )
    else:
        send_job_notification(
            title="⚠️ Job Completed with Issues",
            body=f"Processed {companies_processed} companies, {failed_count} failed",
            data={'type': 'job_completed_with_errors', 'companies_processed': str(companies_processed)}
        )

def notify_job_failed(error_message):
    send_job_notification(
        title="❌ Job Failed",
        body=f"Job failed: {error_message}",
        data={'type': 'job_failed', 'error': str(error_message)}
    )

def fetch_page(session, url, retries=3, backoff_factor=0.8, referer=None):
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

def extract_symbol_from_page(soup, url):
    nse_link = soup.select_one('a[href*="nseindia.com"]')
    if nse_link:
        nse_text = nse_link.get_text(strip=True)
        if 'NSE:' in nse_text:
            symbol = nse_text.replace('NSE:', '').strip()
            if symbol:
                return symbol
    
    url_parts = url.strip('/').split('/')
    if len(url_parts) >= 2:
        potential_symbol = url_parts[-2] if url_parts[-1] == 'consolidated' else url_parts[-1]
        if potential_symbol and potential_symbol != 'company':
            return potential_symbol
    
    breadcrumb = soup.select_one('.breadcrumb')
    if breadcrumb:
        breadcrumb_text = breadcrumb.get_text(strip=True)
        symbol_match = re.search(r'\b([A-Z]{2,10})\b', breadcrumb_text)
        if symbol_match:
            return symbol_match.group(1)
    
    company_nav = soup.select_one('.company-nav h1') or soup.select_one('h1.margin-0')
    if company_nav:
        nav_text = company_nav.get_text(strip=True)
        symbol_match = re.search(r'^([A-Z]{2,10})', nav_text)
        if symbol_match:
            return symbol_match.group(1)
    
    return None

def clean_text(text, field_name=""):
    if not text:
        return None
    
    if field_name in ["bse_code", "nse_code"]:
        return text.strip().replace('BSE:', '').replace('NSE:', '').strip()
    
    return text.strip().replace('₹', '').replace(',', '').replace('%', '').replace('Cr.', '').strip()

def parse_number(text):
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
            'description': row_name,
            'values': sorted_values
        })
    
    return {
        'headers': sorted_headers,
        'body': body_data
    }

def parse_shareholding_table(soup, table_id):
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

def parse_company_data(soup, symbol):
    try:
        company_name_elem = soup.select_one('h1.margin-0') or soup.select_one('.company-nav h1')
        company_name = company_name_elem.get_text(strip=True) if company_name_elem else f"Company {symbol}"
        
        display_name = re.sub(r'\s+(Ltd|Limited|Corporation|Corp|Inc)\.?$', '', company_name, flags=re.IGNORECASE).strip()
        
        ratios_data = {}
        for li in soup.select('#top-ratios li'):
            name_elem = li.select_one('.name')
            value_elem = li.select_one('.value')
            if name_elem and value_elem:
                ratios_data[name_elem.get_text(strip=True)] = value_elem.get_text(strip=True)
        
        about_elem = soup.select_one('.company-profile .about p')
        about = about_elem.get_text(strip=True) if about_elem else None
        
        bse_link = soup.select_one('a[href*="bseindia.com"]')
        nse_link = soup.select_one('a[href*="nseindia.com"]')
        
        bse_code = None
        if bse_link:
            bse_text = bse_link.get_text(strip=True)
            bse_match = re.search(r'BSE:\s*(\d+)', bse_text)
            if bse_match:
                bse_code = bse_match.group(1)
        
        nse_code = None
        if nse_link:
            nse_text = nse_link.get_text(strip=True)
            nse_match = re.search(r'NSE:\s*([A-Z0-9]+)', nse_text)
            if nse_match:
                nse_code = nse_match.group(1)
        
        final_symbol = nse_code if nse_code else symbol
        
        pros = [li.get_text(strip=True) for li in soup.select('.pros ul li')]
        cons = [li.get_text(strip=True) for li in soup.select('.cons ul li')]
        
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
            'quarterly_results': parse_financial_table(soup, 'quarters'),
            'profit_loss_statement': parse_financial_table(soup, 'profit-loss'),
            'balance_sheet': parse_financial_table(soup, 'balance-sheet'),
            'cash_flow_statement': parse_financial_table(soup, 'cash-flow'),
            'ratios': parse_financial_table(soup, 'ratios'),
            'industry_classification': process_industry_path(soup),
            'shareholding_pattern': {
                'quarterly': parse_shareholding_table(soup, 'quarterly-shp')
            },
            **parse_growth_tables(soup),
            'ratios_data': ratios_data
        }
        
    except Exception:
        return None

def get_queue_status(db):
    try:
        pending_count = len(list(db.collection('scraping_queue').where(filter=FieldFilter('status', '==', 'pending')).limit(1000).stream()))
        processing_count = len(list(db.collection('scraping_queue').where(filter=FieldFilter('status', '==', 'processing')).limit(1000).stream()))
        completed_count = len(list(db.collection('scraping_queue').where(filter=FieldFilter('status', '==', 'completed')).limit(1000).stream()))
        failed_count = len(list(db.collection('scraping_queue').where(filter=FieldFilter('status', '==', 'failed')).limit(1000).stream()))
        
        return {
            'pending': pending_count,
            'processing': processing_count,
            'completed': completed_count,
            'failed': failed_count,
            'total': pending_count + processing_count + completed_count + failed_count,
            'is_active': processing_count > 0 or pending_count > 0,
            'is_completed': pending_count == 0 and processing_count == 0 and completed_count > 0,
            'progress_percentage': ((completed_count + failed_count) / max(1, pending_count + processing_count + completed_count + failed_count)) * 100,
            'status_text': 'Active' if processing_count > 0 or pending_count > 0 else ('Completed' if completed_count > 0 else 'Ready'),
            'timestamp': datetime.now().isoformat()
        }
    except Exception as e:
        return {'error': str(e)}

def cleanup_old_queue_items(db):
    try:
        cutoff_date = datetime.now() - timedelta(days=7)
        cutoff_iso = cutoff_date.isoformat()
        
        completed_docs = db.collection('scraping_queue')\
                          .where(filter=FieldFilter('status', '==', 'completed'))\
                          .where(filter=FieldFilter('completed_at', '<', cutoff_iso))\
                          .limit(100)\
                          .stream()
        
        batch = db.batch()
        count = 0
        for doc in completed_docs:
            batch.delete(doc.reference)
            count += 1
        
        if count > 0:
            batch.commit()
        
        failed_docs = db.collection('scraping_queue')\
                     .where(filter=FieldFilter('status', '==', 'failed'))\
                     .where(filter=FieldFilter('failed_at', '<', cutoff_iso))\
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
    try:
        cutoff_time = datetime.now() - timedelta(minutes=30)
        cutoff_iso = cutoff_time.isoformat()
        
        stale_docs = db.collection('scraping_queue')\
                      .where(filter=FieldFilter('status', '==', 'processing'))\
                      .where(filter=FieldFilter('started_at', '<', cutoff_iso))\
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

@https_fn.on_request()
def queue_scraping_jobs(req: https_fn.Request) -> https_fn.Response:
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
        max_pages = request_json.get('max_pages', 50)
        
        if clear_queue:
            for status in ['pending', 'failed']:
                docs = db.collection('scraping_queue').where(filter=FieldFilter('status', '==', status)).limit(500).stream()
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
                    'max_retries': 3
                })
            
            batch.commit()
            total_queued += len(batch_urls)
        
        return https_fn.Response(
            json.dumps({
                'status': 'success',
                'message': f'Successfully queued {total_queued} companies for comprehensive data scraping',
                'queued_count': total_queued,
                'pages_processed': max_pages,
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
    print(f"Starting queue processing at {datetime.now()}")
    
    try:
        db = get_db()
        
        cleanup_old_queue_items(db)
        reset_stale_processing_items(db)
        
        pending_items = list(db.collection('scraping_queue')
                           .where(filter=FieldFilter('status', '==', 'pending'))
                           .limit(10)
                           .stream())
        
        print(f"Found {len(pending_items)} pending items in queue")
        
        if not pending_items:
            print("No pending items found")
            all_items = list(db.collection('scraping_queue').limit(5).stream())
            print(f"Total items in queue collection: {len(all_items)}")
            
            if len(all_items) == 0:
                print("Queue collection is empty")
            else:
                for item in all_items:
                    data = item.to_dict()
                    print(f"Queue item status: {data.get('status')} - URL: {data.get('url', 'No URL')[:50]}...")
            
            return
        
        print(f"Processing first 5 items...")
        processed_count = 0
        failed_count = 0
        
        with requests.Session() as session:
            for i, doc in enumerate(pending_items[:5]):
                print(f"Processing item {i+1}/5")
                
                try:
                    data = doc.to_dict()
                    url = data['url']
                    print(f"URL: {url}")
                    
                    doc.reference.update({
                        'status': 'processing',
                        'started_at': datetime.now().isoformat(),
                        'processor_id': 'scheduler_worker'
                    })
                    print(f"Marked {doc.id} as processing")
                    
                    print("Fetching page...")
                    response = fetch_page(session, url, retries=2)
                    
                    if not response:
                        print("Failed to fetch page")
                        doc.reference.update({
                            'status': 'failed',
                            'failed_at': datetime.now().isoformat(),
                            'error': 'Failed to fetch page'
                        })
                        failed_count += 1
                        continue
                    
                    print(f"Page fetched successfully - Size: {len(response.content)} bytes")
                    
                    soup = BeautifulSoup(response.content, 'lxml')
                    print("HTML parsed successfully")
                    
                    symbol = extract_symbol_from_page(soup, url)
                    print(f"Extracted symbol: {symbol}")
                    
                    if not symbol:
                        print("Failed to extract symbol")
                        doc.reference.update({
                            'status': 'failed',
                            'failed_at': datetime.now().isoformat(),
                            'error': 'Could not extract symbol'
                        })
                        failed_count += 1
                        continue
                    
                    print("Parsing company data...")
                    company_data = parse_company_data(soup, symbol)
                    
                    if not company_data:
                        print("Failed to parse company data")
                        doc.reference.update({
                            'status': 'failed',
                            'failed_at': datetime.now().isoformat(),
                            'error': 'Failed to parse company data'
                        })
                        failed_count += 1
                        continue
                    
                    print(f"Company data parsed successfully")
                    print(f"Data keys: {list(company_data.keys())}")
                    print(f"Market cap: {company_data.get('market_cap')}")
                    print(f"Current price: {company_data.get('current_price')}")
                    
                    print(f"Writing to Firestore collection 'companies' with document ID: {symbol}")
                    
                    try:
                        doc_ref = db.collection('companies').document(symbol)
                        doc_ref.set(company_data)
                        print(f"Successfully wrote {symbol} to Firestore")
                        
                        written_doc = doc_ref.get()
                        if written_doc.exists:
                            print(f"Verified: Document {symbol} exists in Firestore")
                        else:
                            print(f"ERROR: Document {symbol} was not found after write")
                        
                    except Exception as firestore_error:
                        print(f"FIRESTORE WRITE ERROR: {str(firestore_error)}")
                        doc.reference.update({
                            'status': 'failed',
                            'failed_at': datetime.now().isoformat(),
                            'error': f'Firestore write failed: {str(firestore_error)}'
                        })
                        failed_count += 1
                        continue
                    
                    doc.reference.update({
                        'status': 'completed',
                        'completed_at': datetime.now().isoformat(),
                        'symbol': symbol,
                        'company_name': company_data.get('name', 'Unknown')
                    })
                    
                    processed_count += 1
                    print(f"Successfully processed {symbol}")
                    
                    time.sleep(random.uniform(2, 5))
                    
                except Exception as processing_error:
                    print(f"PROCESSING ERROR: {str(processing_error)}")
                    try:
                        doc.reference.update({
                            'status': 'failed',
                            'failed_at': datetime.now().isoformat(),
                            'error': str(processing_error)
                        })
                        failed_count += 1
                    except:
                        print("Failed to update error status")
        
        print(f"PROCESSING COMPLETE")
        print(f"Processed: {processed_count}")
        print(f"Failed: {failed_count}")
        
        if processed_count > 0 or failed_count > 0:
            notify_job_complete(processed_count, failed_count)
        
    except Exception as e:
        print(f"FATAL ERROR in process_scraping_queue: {str(e)}")
        notify_job_failed(str(e))

@https_fn.on_request()
def get_queue_status_api(req: https_fn.Request) -> https_fn.Response:
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
        
        recent_completed = []
        try:
            completed_docs = db.collection('scraping_queue')\
                             .where(filter=FieldFilter('status', '==', 'completed'))\
                             .order_by('completed_at', direction=firestore.Query.DESCENDING)\
                             .limit(10)\
                             .stream()
            
            for doc in completed_docs:
                data = doc.to_dict()
                recent_completed.append({
                    'symbol': data.get('symbol', 'Unknown'),
                    'company_name': data.get('company_name', 'Unknown'),
                    'completed_at': data.get('completed_at', '')
                })
        except Exception:
            pass
        
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
            docs = db.collection('scraping_queue').where(filter=FieldFilter('status', '==', 'failed')).limit(1000).stream()
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
                json.dumps({'status': 'success', 'message': f'Cleared {count} failed items'}),
                status=200, headers=headers
            )
        
        elif action == 'retry_failed':
            docs = db.collection('scraping_queue').where(filter=FieldFilter('status', '==', 'failed')).limit(100).stream()
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
                json.dumps({'status': 'success', 'message': f'Reset {count} failed items to pending'}),
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

@https_fn.on_request()
def manual_scrape_trigger(req: https_fn.Request) -> https_fn.Response:
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
                'message': 'Complete data scraping system is ready with all financial tables',
                'timestamp': datetime.now().isoformat(),
                'test_mode': True
            }
            return https_fn.Response(
                json.dumps(response_data),
                status=200, headers=headers
            )
        
        db = get_db()
        status = get_queue_status(db)
        
        response_data = {
            'status': 'success',
            'message': 'Comprehensive data scraping with complete financial statements. You will receive push notification when complete.',
            'current_queue_status': status,
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
