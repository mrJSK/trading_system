# from firebase_functions import https_fn, scheduler_fn
# from firebase_admin import initialize_app, firestore, messaging
# from google.cloud.firestore_v1.base_query import FieldFilter
# import requests
# import re
# import time
# import random
# from datetime import datetime, timedelta
# from bs4 import BeautifulSoup
# import json

# initialize_app()

# USER_AGENTS = [
#     'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36',
#     'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36',
#     'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:126.0) Gecko/20100101 Firefox/126.0',
#     'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36'
# ]

# def get_db():
#     return firestore.client()

# def send_job_notification(title, body, data=None):
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
#     send_job_notification(
#         title="❌ Job Failed",
#         body=f"Job failed: {error_message}",
#         data={'type': 'job_failed', 'error': str(error_message)}
#     )

# def fetch_page(session, url, retries=3, backoff_factor=0.8, referer=None):
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

# def extract_symbol_from_page(soup, url):
#     nse_link = soup.select_one('a[href*="nseindia.com"]')
#     if nse_link:
#         nse_text = nse_link.get_text(strip=True)
#         if 'NSE:' in nse_text:
#             symbol = nse_text.replace('NSE:', '').strip()
#             if symbol:
#                 return symbol
    
#     url_parts = url.strip('/').split('/')
#     if len(url_parts) >= 2:
#         potential_symbol = url_parts[-2] if url_parts[-1] == 'consolidated' else url_parts[-1]
#         if potential_symbol and potential_symbol != 'company':
#             return potential_symbol
    
#     breadcrumb = soup.select_one('.breadcrumb')
#     if breadcrumb:
#         breadcrumb_text = breadcrumb.get_text(strip=True)
#         symbol_match = re.search(r'\b([A-Z]{2,10})\b', breadcrumb_text)
#         if symbol_match:
#             return symbol_match.group(1)
    
#     company_nav = soup.select_one('.company-nav h1') or soup.select_one('h1.margin-0')
#     if company_nav:
#         nav_text = company_nav.get_text(strip=True)
#         symbol_match = re.search(r'^([A-Z]{2,10})', nav_text)
#         if symbol_match:
#             return symbol_match.group(1)
    
#     return None

# def clean_text(text, field_name=""):
#     if not text:
#         return None
    
#     if field_name in ["bse_code", "nse_code"]:
#         return text.strip().replace('BSE:', '').replace('NSE:', '').strip()
    
#     return text.strip().replace('₹', '').replace(',', '').replace('%', '').replace('Cr.', '').strip()

# def parse_number(text):
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
#             'description': row_name,
#             'values': sorted_values
#         })
    
#     return {
#         'headers': sorted_headers,
#         'body': body_data
#     }

# def parse_shareholding_table(soup, table_id):
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
#     try:
#         company_name_elem = soup.select_one('h1.margin-0') or soup.select_one('.company-nav h1')
#         company_name = company_name_elem.get_text(strip=True) if company_name_elem else f"Company {symbol}"
        
#         display_name = re.sub(r'\s+(Ltd|Limited|Corporation|Corp|Inc)\.?$', '', company_name, flags=re.IGNORECASE).strip()
        
#         ratios_data = {}
#         for li in soup.select('#top-ratios li'):
#             name_elem = li.select_one('.name')
#             value_elem = li.select_one('.value')
#             if name_elem and value_elem:
#                 ratios_data[name_elem.get_text(strip=True)] = value_elem.get_text(strip=True)
        
#         about_elem = soup.select_one('.company-profile .about p')
#         about = about_elem.get_text(strip=True) if about_elem else None
        
#         bse_link = soup.select_one('a[href*="bseindia.com"]')
#         nse_link = soup.select_one('a[href*="nseindia.com"]')
        
#         bse_code = None
#         if bse_link:
#             bse_text = bse_link.get_text(strip=True)
#             bse_match = re.search(r'BSE:\s*(\d+)', bse_text)
#             if bse_match:
#                 bse_code = bse_match.group(1)
        
#         nse_code = None
#         if nse_link:
#             nse_text = nse_link.get_text(strip=True)
#             nse_match = re.search(r'NSE:\s*([A-Z0-9]+)', nse_text)
#             if nse_match:
#                 nse_code = nse_match.group(1)
        
#         final_symbol = nse_code if nse_code else symbol
        
#         pros = [li.get_text(strip=True) for li in soup.select('.pros ul li')]
#         cons = [li.get_text(strip=True) for li in soup.select('.cons ul li')]
        
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
#             'quarterly_results': parse_financial_table(soup, 'quarters'),
#             'profit_loss_statement': parse_financial_table(soup, 'profit-loss'),
#             'balance_sheet': parse_financial_table(soup, 'balance-sheet'),
#             'cash_flow_statement': parse_financial_table(soup, 'cash-flow'),
#             'ratios': parse_financial_table(soup, 'ratios'),
#             'industry_classification': process_industry_path(soup),
#             'shareholding_pattern': {
#                 'quarterly': parse_shareholding_table(soup, 'quarterly-shp')
#             },
#             **parse_growth_tables(soup),
#             'ratios_data': ratios_data
#         }
        
#     except Exception:
#         return None

# def get_queue_status(db):
#     try:
#         pending_count = len(list(db.collection('scraping_queue').where(filter=FieldFilter('status', '==', 'pending')).limit(1000).stream()))
#         processing_count = len(list(db.collection('scraping_queue').where(filter=FieldFilter('status', '==', 'processing')).limit(1000).stream()))
#         completed_count = len(list(db.collection('scraping_queue').where(filter=FieldFilter('status', '==', 'completed')).limit(1000).stream()))
#         failed_count = len(list(db.collection('scraping_queue').where(filter=FieldFilter('status', '==', 'failed')).limit(1000).stream()))
        
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
#     try:
#         cutoff_date = datetime.now() - timedelta(days=7)
#         cutoff_iso = cutoff_date.isoformat()
        
#         completed_docs = db.collection('scraping_queue')\
#                           .where(filter=FieldFilter('status', '==', 'completed'))\
#                           .where(filter=FieldFilter('completed_at', '<', cutoff_iso))\
#                           .limit(100)\
#                           .stream()
        
#         batch = db.batch()
#         count = 0
#         for doc in completed_docs:
#             batch.delete(doc.reference)
#             count += 1
        
#         if count > 0:
#             batch.commit()
        
#         failed_docs = db.collection('scraping_queue')\
#                      .where(filter=FieldFilter('status', '==', 'failed'))\
#                      .where(filter=FieldFilter('failed_at', '<', cutoff_iso))\
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
#     try:
#         cutoff_time = datetime.now() - timedelta(minutes=30)
#         cutoff_iso = cutoff_time.isoformat()
        
#         stale_docs = db.collection('scraping_queue')\
#                       .where(filter=FieldFilter('status', '==', 'processing'))\
#                       .where(filter=FieldFilter('started_at', '<', cutoff_iso))\
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

# @https_fn.on_request()
# def queue_scraping_jobs(req: https_fn.Request) -> https_fn.Response:
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
#             for status in ['pending', 'failed']:
#                 docs = db.collection('scraping_queue').where(filter=FieldFilter('status', '==', status)).limit(500).stream()
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
#     print(f"Starting queue processing at {datetime.now()}")
    
#     try:
#         db = get_db()
        
#         cleanup_old_queue_items(db)
#         reset_stale_processing_items(db)
        
#         pending_items = list(db.collection('scraping_queue')
#                            .where(filter=FieldFilter('status', '==', 'pending'))
#                            .limit(10)
#                            .stream())
        
#         print(f"Found {len(pending_items)} pending items in queue")
        
#         if not pending_items:
#             print("No pending items found")
#             all_items = list(db.collection('scraping_queue').limit(5).stream())
#             print(f"Total items in queue collection: {len(all_items)}")
            
#             if len(all_items) == 0:
#                 print("Queue collection is empty")
#             else:
#                 for item in all_items:
#                     data = item.to_dict()
#                     print(f"Queue item status: {data.get('status')} - URL: {data.get('url', 'No URL')[:50]}...")
            
#             return
        
#         print(f"Processing first 5 items...")
#         processed_count = 0
#         failed_count = 0
        
#         with requests.Session() as session:
#             for i, doc in enumerate(pending_items[:5]):
#                 print(f"Processing item {i+1}/5")
                
#                 try:
#                     data = doc.to_dict()
#                     url = data['url']
#                     print(f"URL: {url}")
                    
#                     doc.reference.update({
#                         'status': 'processing',
#                         'started_at': datetime.now().isoformat(),
#                         'processor_id': 'scheduler_worker'
#                     })
#                     print(f"Marked {doc.id} as processing")
                    
#                     print("Fetching page...")
#                     response = fetch_page(session, url, retries=2)
                    
#                     if not response:
#                         print("Failed to fetch page")
#                         doc.reference.update({
#                             'status': 'failed',
#                             'failed_at': datetime.now().isoformat(),
#                             'error': 'Failed to fetch page'
#                         })
#                         failed_count += 1
#                         continue
                    
#                     print(f"Page fetched successfully - Size: {len(response.content)} bytes")
                    
#                     soup = BeautifulSoup(response.content, 'lxml')
#                     print("HTML parsed successfully")
                    
#                     symbol = extract_symbol_from_page(soup, url)
#                     print(f"Extracted symbol: {symbol}")
                    
#                     if not symbol:
#                         print("Failed to extract symbol")
#                         doc.reference.update({
#                             'status': 'failed',
#                             'failed_at': datetime.now().isoformat(),
#                             'error': 'Could not extract symbol'
#                         })
#                         failed_count += 1
#                         continue
                    
#                     print("Parsing company data...")
#                     company_data = parse_company_data(soup, symbol)
                    
#                     if not company_data:
#                         print("Failed to parse company data")
#                         doc.reference.update({
#                             'status': 'failed',
#                             'failed_at': datetime.now().isoformat(),
#                             'error': 'Failed to parse company data'
#                         })
#                         failed_count += 1
#                         continue
                    
#                     print(f"Company data parsed successfully")
#                     print(f"Data keys: {list(company_data.keys())}")
#                     print(f"Market cap: {company_data.get('market_cap')}")
#                     print(f"Current price: {company_data.get('current_price')}")
                    
#                     print(f"Writing to Firestore collection 'companies' with document ID: {symbol}")
                    
#                     try:
#                         doc_ref = db.collection('companies').document(symbol)
#                         doc_ref.set(company_data)
#                         print(f"Successfully wrote {symbol} to Firestore")
                        
#                         written_doc = doc_ref.get()
#                         if written_doc.exists:
#                             print(f"Verified: Document {symbol} exists in Firestore")
#                         else:
#                             print(f"ERROR: Document {symbol} was not found after write")
                        
#                     except Exception as firestore_error:
#                         print(f"FIRESTORE WRITE ERROR: {str(firestore_error)}")
#                         doc.reference.update({
#                             'status': 'failed',
#                             'failed_at': datetime.now().isoformat(),
#                             'error': f'Firestore write failed: {str(firestore_error)}'
#                         })
#                         failed_count += 1
#                         continue
                    
#                     doc.reference.update({
#                         'status': 'completed',
#                         'completed_at': datetime.now().isoformat(),
#                         'symbol': symbol,
#                         'company_name': company_data.get('name', 'Unknown')
#                     })
                    
#                     processed_count += 1
#                     print(f"Successfully processed {symbol}")
                    
#                     time.sleep(random.uniform(2, 5))
                    
#                 except Exception as processing_error:
#                     print(f"PROCESSING ERROR: {str(processing_error)}")
#                     try:
#                         doc.reference.update({
#                             'status': 'failed',
#                             'failed_at': datetime.now().isoformat(),
#                             'error': str(processing_error)
#                         })
#                         failed_count += 1
#                     except:
#                         print("Failed to update error status")
        
#         print(f"PROCESSING COMPLETE")
#         print(f"Processed: {processed_count}")
#         print(f"Failed: {failed_count}")
        
#         if processed_count > 0 or failed_count > 0:
#             notify_job_complete(processed_count, failed_count)
        
#     except Exception as e:
#         print(f"FATAL ERROR in process_scraping_queue: {str(e)}")
#         notify_job_failed(str(e))

# @https_fn.on_request()
# def get_queue_status_api(req: https_fn.Request) -> https_fn.Response:
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
        
#         recent_completed = []
#         try:
#             completed_docs = db.collection('scraping_queue')\
#                              .where(filter=FieldFilter('status', '==', 'completed'))\
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

# @https_fn.on_request()
# def manage_queue(req: https_fn.Request) -> https_fn.Response:
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
#             docs = db.collection('scraping_queue').where(filter=FieldFilter('status', '==', 'failed')).limit(1000).stream()
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
#             docs = db.collection('scraping_queue').where(filter=FieldFilter('status', '==', 'failed')).limit(100).stream()
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

# @https_fn.on_request()
# def manual_scrape_trigger(req: https_fn.Request) -> https_fn.Response:
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
# from firebase_functions import https_fn, scheduler_fn
# from firebase_admin import initialize_app, firestore, messaging
# from google.cloud.firestore_v1.base_query import FieldFilter
# import requests
# import re
# import time
# import random
# from datetime import datetime, timedelta
# from bs4 import BeautifulSoup
# import json
# import logging

# initialize_app()

# # Configure logging
# logging.basicConfig(level=logging.INFO)
# logger = logging.getLogger(__name__)

# USER_AGENTS = [
#     'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36',
#     'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36',
#     'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:126.0) Gecko/20100101 Firefox/126.0',
#     'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36'
# ]

# def get_db():
#     return firestore.client()

# def send_job_notification(title, body, data=None):
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
#     except Exception as e:
#         logger.error(f"Failed to send notification: {e}")
#         return None

# def notify_job_complete(companies_processed, failed_count=0):
#     if failed_count == 0:
#         send_job_notification(
#             title="🎉 Job Completed!",
#             body=f"Successfully processed {companies_processed} companies with enhanced financial data",
#             data={'type': 'job_completed', 'companies_processed': str(companies_processed)}
#         )
#     else:
#         send_job_notification(
#             title="⚠️ Job Completed with Issues",
#             body=f"Processed {companies_processed} companies, {failed_count} failed",
#             data={'type': 'job_completed_with_errors', 'companies_processed': str(companies_processed)}
#         )

# def notify_job_failed(error_message):
#     send_job_notification(
#         title="❌ Job Failed",
#         body=f"Job failed: {error_message}",
#         data={'type': 'job_failed', 'error': str(error_message)}
#     )

# def fetch_page(session, url, retries=5, backoff_factor=0.8, referer=None):
#     """Enhanced fetch with exponential backoff"""
#     headers = {
#         'User-Agent': random.choice(USER_AGENTS),
#         'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
#         'Accept-Language': 'en-US,en;q=0.9',
#         'Connection': 'keep-alive',
#         'Upgrade-Insecure-Requests': '1',
#         'Cache-Control': 'no-cache',
#         'Pragma': 'no-cache'
#     }
    
#     if referer:
#         headers['Referer'] = referer
    
#     for attempt in range(retries):
#         try:
#             if attempt > 0:
#                 wait_time = min(300, backoff_factor * (2 ** attempt) + random.uniform(0, 2))
#                 logger.info(f"Waiting {wait_time:.2f}s before retry {attempt + 1}")
#                 time.sleep(wait_time)
            
#             response = session.get(url, headers=headers, timeout=45)
#             response.raise_for_status()
            
#             # Random delay between successful requests
#             time.sleep(random.uniform(2, 5))
#             return response
            
#         except requests.exceptions.Timeout:
#             logger.warning(f"Timeout for {url} (attempt {attempt + 1})")
#         except requests.exceptions.RequestException as e:
#             logger.warning(f"Request error for {url}: {e} (attempt {attempt + 1})")
#         except Exception as e:
#             logger.error(f"Unexpected error for {url}: {e} (attempt {attempt + 1})")
    
#     logger.error(f"Failed to fetch {url} after {retries} attempts")
#     return None

# def extract_symbol_from_page(soup, url):
#     """Enhanced symbol extraction"""
#     # Method 1: NSE link
#     nse_link = soup.select_one('a[href*="nseindia.com"]')
#     if nse_link:
#         nse_text = nse_link.get_text(strip=True)
#         if 'NSE:' in nse_text:
#             symbol = nse_text.replace('NSE:', '').strip()
#             if symbol and len(symbol) <= 10:
#                 return symbol
    
#     # Method 2: URL parsing
#     url_parts = url.strip('/').split('/')
#     if len(url_parts) >= 2:
#         potential_symbol = url_parts[-2] if url_parts[-1] == 'consolidated' else url_parts[-1]
#         if potential_symbol and potential_symbol != 'company' and len(potential_symbol) <= 10:
#             return potential_symbol
    
#     # Method 3: Breadcrumb
#     breadcrumb = soup.select_one('.breadcrumb')
#     if breadcrumb:
#         breadcrumb_text = breadcrumb.get_text(strip=True)
#         symbol_match = re.search(r'\b([A-Z]{2,10})\b', breadcrumb_text)
#         if symbol_match:
#             return symbol_match.group(1)
    
#     # Method 4: Company navigation
#     company_nav = soup.select_one('.company-nav h1') or soup.select_one('h1.margin-0')
#     if company_nav:
#         nav_text = company_nav.get_text(strip=True)
#         symbol_match = re.search(r'^([A-Z]{2,10})', nav_text)
#         if symbol_match:
#             return symbol_match.group(1)
    
#     return None

# def clean_text(text, field_name=""):
#     if not text:
#         return None
    
#     if field_name in ["bse_code", "nse_code"]:
#         return text.strip().replace('BSE:', '').replace('NSE:', '').strip()
    
#     return text.strip().replace('₹', '').replace(',', '').replace('%', '').replace('Cr.', '').strip()

# def parse_number(text):
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
#     company_links_div = soup.select_one('div.company-links')
#     if not company_links_div:
#         return None
    
#     all_links = company_links_div.find_all('a', href=True)
#     for link in all_links:
#         href = link['href']
#         if 'bseindia.com' not in href and 'nseindia.com' not in href:
#             if href.startswith(('http://', 'https://')):
#                 return href
#     return None

# def parse_financial_table(soup, table_id):
#     """Enhanced financial table parsing"""
#     try:
#         section = soup.select_one(f'section#{table_id}')
#         if not section:
#             return {}
        
#         table = section.select_one('table.data-table')
#         if not table:
#             return {}
        
#         original_headers = [th.get_text(strip=True) for th in table.select('thead th')][1:]
#         if not original_headers:
#             return {}
        
#         sorted_headers = sorted(original_headers, key=get_calendar_sort_key, reverse=True)
        
#         body_data = []
#         for row in table.select('tbody tr'):
#             cols = row.select('td')
#             if not cols or 'sub' in row.get('class', []):
#                 continue
            
#             row_name = cols[0].get_text(strip=True).replace('+', '').strip()
#             if not row_name:
#                 continue
            
#             original_values = [col.get_text(strip=True) for col in cols[1:]]
#             value_map = dict(zip(original_headers, original_values))
#             sorted_values = [value_map.get(h, '') for h in sorted_headers]
            
#             body_data.append({
#                 'description': row_name,
#                 'values': sorted_values
#             })
        
#         return {
#             'headers': sorted_headers,
#             'body': body_data
#         }
#     except Exception as e:
#         logger.error(f"Error parsing financial table {table_id}: {e}")
#         return {}

# def parse_shareholding_table(soup, table_id):
#     try:
#         table = soup.select_one(f'div#{table_id} table.data-table')
#         if not table:
#             return {}
        
#         original_headers = [th.get_text(strip=True) for th in table.select('thead th')][1:]
#         sorted_headers = sorted(original_headers, key=get_calendar_sort_key, reverse=True)
        
#         data = {}
#         for row in table.select('tbody tr'):
#             cols = row.select('td')
#             if not cols or 'sub' in row.get('class', []):
#                 continue
            
#             row_name = cols[0].get_text(strip=True).replace('+', '').strip()
#             if not row_name:
#                 continue
            
#             original_values = [col.get_text(strip=True) for col in cols[1:]]
#             value_map = dict(zip(original_headers, original_values))
#             row_data = {h: value_map.get(h, '') for h in sorted_headers}
#             data[row_name] = row_data
        
#         return data
#     except Exception as e:
#         logger.error(f"Error parsing shareholding table {table_id}: {e}")
#         return {}

# def parse_growth_tables(soup):
#     try:
#         data = {}
#         pl_section = soup.select_one('section#profit-loss')
#         if not pl_section:
#             return data
        
#         tables = pl_section.select('table.ranges-table')
#         for table in tables:
#             title_elem = table.select_one('th')
#             if title_elem:
#                 title = title_elem.get_text(strip=True).replace(':', '')
#                 table_data = {}
                
#                 for row in table.select('tr')[1:]:
#                     cols = row.select('td')
#                     if len(cols) == 2:
#                         key = cols[0].get_text(strip=True).replace(':', '')
#                         value = cols[1].get_text(strip=True)
#                         table_data[key] = value
                
#                 data[title] = table_data
        
#         return data
#     except Exception as e:
#         logger.error(f"Error parsing growth tables: {e}")
#         return {}

# def process_industry_path(soup):
#     try:
#         peers_section = soup.select_one('section#peers')
#         if not peers_section:
#             return None
        
#         path_paragraph = peers_section.select_one('p.sub:not(#benchmarks)')
#         if not path_paragraph:
#             return None
        
#         path_links = path_paragraph.select('a')
#         if not path_links:
#             return None
        
#         path_names = [link.get_text(strip=True).replace('&amp;', 'and') for link in path_links]
#         return path_names
#     except Exception as e:
#         logger.error(f"Error processing industry path: {e}")
#         return None

# def extract_enhanced_ratios(soup):
#     """Extract additional financial ratios from ratios section"""
#     try:
#         enhanced_ratios = {}
#         ratios_section = soup.select_one('section#ratios')
        
#         if ratios_section:
#             rows = ratios_section.select('tr')
#             for row in rows:
#                 cells = row.select(['td', 'th'])
#                 if len(cells) >= 2:
#                     metric = cells[0].get_text(strip=True)
#                     value = cells[-1].get_text(strip=True)  # Latest value
                    
#                     # Extract specific ratios using exact field names from screener.in
#                     if 'Debt to Equity' in metric:
#                         enhanced_ratios['debt_to_equity'] = parse_number(value)
#                     elif 'Current Ratio' in metric:
#                         enhanced_ratios['current_ratio'] = parse_number(value)
#                     elif 'Quick Ratio' in metric:
#                         enhanced_ratios['quick_ratio'] = parse_number(value)
#                     elif 'Working Capital Days' in metric or 'Working Capital' in metric:
#                         enhanced_ratios['working_capital_days'] = parse_number(value)
#                     elif 'Debtor Days' in metric or 'Debtors' in metric:
#                         enhanced_ratios['debtor_days'] = parse_number(value)
#                     elif 'Inventory Days' in metric:
#                         enhanced_ratios['inventory_days'] = parse_number(value)
#                     elif 'Cash Conversion Cycle' in metric:
#                         enhanced_ratios['cash_conversion_cycle'] = parse_number(value)
#                     elif 'Interest Coverage' in metric:
#                         enhanced_ratios['interest_coverage'] = parse_number(value)
#                     elif 'Asset Turnover' in metric:
#                         enhanced_ratios['asset_turnover'] = parse_number(value)
        
#         return enhanced_ratios
#     except Exception as e:
#         logger.error(f"Error extracting enhanced ratios: {e}")
#         return {}

# def parse_company_data(soup, symbol):
#     try:
#         company_name_elem = soup.select_one('h1.margin-0') or soup.select_one('.company-nav h1')
#         company_name = company_name_elem.get_text(strip=True) if company_name_elem else f"Company {symbol}"
        
#         display_name = re.sub(r'\s+(Ltd|Limited|Corporation|Corp|Inc)\.?$', '', company_name, flags=re.IGNORECASE).strip()
        
#         ratios_data = {}
#         for li in soup.select('#top-ratios li'):
#             name_elem = li.select_one('.name')
#             value_elem = li.select_one('.value')
#             if name_elem and value_elem:
#                 ratios_data[name_elem.get_text(strip=True)] = value_elem.get_text(strip=True)
        
#         about_elem = soup.select_one('.company-profile .about p')
#         about = about_elem.get_text(strip=True) if about_elem else None
        
#         bse_link = soup.select_one('a[href*="bseindia.com"]')
#         nse_link = soup.select_one('a[href*="nseindia.com"]')
        
#         bse_code = None
#         if bse_link:
#             bse_text = bse_link.get_text(strip=True)
#             bse_match = re.search(r'BSE:\s*(\d+)', bse_text)
#             if bse_match:
#                 bse_code = bse_match.group(1)
        
#         nse_code = None
#         if nse_link:
#             nse_text = nse_link.get_text(strip=True)
#             nse_match = re.search(r'NSE:\s*([A-Z0-9]+)', nse_text)
#             if nse_match:
#                 nse_code = nse_match.group(1)
        
#         final_symbol = nse_code if nse_code else symbol
        
#         pros = [li.get_text(strip=True) for li in soup.select('.pros ul li')]
#         cons = [li.get_text(strip=True) for li in soup.select('.cons ul li')]
        
#         # Extract enhanced ratios
#         enhanced_ratios = extract_enhanced_ratios(soup)
        
#         # Build comprehensive company data
#         company_data = {
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
            
#             # Add enhanced ratios
#             **enhanced_ratios,
            
#             # Comprehensive financial statements
#             'quarterly_results': parse_financial_table(soup, 'quarters'),
#             'profit_loss_statement': parse_financial_table(soup, 'profit-loss'),
#             'balance_sheet': parse_financial_table(soup, 'balance-sheet'),
#             'cash_flow_statement': parse_financial_table(soup, 'cash-flow'),
#             'ratios': parse_financial_table(soup, 'ratios'),
#             'industry_classification': process_industry_path(soup),
#             'shareholding_pattern': {
#                 'quarterly': parse_shareholding_table(soup, 'quarterly-shp')
#             },
#             **parse_growth_tables(soup),
#             'ratios_data': ratios_data
#         }
        
#         # Calculate price to book if both values exist
#         if company_data['current_price'] and company_data['book_value']:
#             company_data['price_to_book'] = round(company_data['current_price'] / company_data['book_value'], 2)
        
#         return company_data
        
#     except Exception as e:
#         logger.error(f"Error parsing company data for {symbol}: {e}")
#         return None

# def get_queue_status(db):
#     try:
#         pending_count = len(list(db.collection('scraping_queue').where(filter=FieldFilter('status', '==', 'pending')).limit(1000).stream()))
#         processing_count = len(list(db.collection('scraping_queue').where(filter=FieldFilter('status', '==', 'processing')).limit(1000).stream()))
#         completed_count = len(list(db.collection('scraping_queue').where(filter=FieldFilter('status', '==', 'completed')).limit(1000).stream()))
#         failed_count = len(list(db.collection('scraping_queue').where(filter=FieldFilter('status', '==', 'failed')).limit(1000).stream()))
        
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
#     try:
#         cutoff_date = datetime.now() - timedelta(days=7)
#         cutoff_iso = cutoff_date.isoformat()
        
#         completed_docs = db.collection('scraping_queue')\
#                           .where(filter=FieldFilter('status', '==', 'completed'))\
#                           .where(filter=FieldFilter('completed_at', '<', cutoff_iso))\
#                           .limit(100)\
#                           .stream()
        
#         batch = db.batch()
#         count = 0
#         for doc in completed_docs:
#             batch.delete(doc.reference)
#             count += 1
        
#         if count > 0:
#             batch.commit()
        
#         failed_docs = db.collection('scraping_queue')\
#                      .where(filter=FieldFilter('status', '==', 'failed'))\
#                      .where(filter=FieldFilter('failed_at', '<', cutoff_iso))\
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
#     try:
#         cutoff_time = datetime.now() - timedelta(minutes=30)
#         cutoff_iso = cutoff_time.isoformat()
        
#         stale_docs = db.collection('scraping_queue')\
#                       .where(filter=FieldFilter('status', '==', 'processing'))\
#                       .where(filter=FieldFilter('started_at', '<', cutoff_iso))\
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

# @https_fn.on_request()
# def queue_scraping_jobs(req: https_fn.Request) -> https_fn.Response:
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
#             for status in ['pending', 'failed']:
#                 docs = db.collection('scraping_queue').where(filter=FieldFilter('status', '==', status)).limit(500).stream()
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
#                 'message': f'Successfully queued {total_queued} companies for enhanced data scraping',
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
#     print(f"Starting enhanced queue processing at {datetime.now()}")
    
#     try:
#         db = get_db()
        
#         cleanup_old_queue_items(db)
#         reset_stale_processing_items(db)
        
#         pending_items = list(db.collection('scraping_queue')
#                            .where(filter=FieldFilter('status', '==', 'pending'))
#                            .limit(5)
#                            .stream())
        
#         print(f"Found {len(pending_items)} pending items in queue")
        
#         if not pending_items:
#             print("No pending items found")
#             return
        
#         processed_count = 0
#         failed_count = 0
        
#         with requests.Session() as session:
#             for i, doc in enumerate(pending_items):
#                 print(f"Processing item {i+1}/{len(pending_items)}")
                
#                 try:
#                     data = doc.to_dict()
#                     url = data['url']
#                     print(f"URL: {url}")
                    
#                     doc.reference.update({
#                         'status': 'processing',
#                         'started_at': datetime.now().isoformat(),
#                         'processor_id': 'enhanced_scheduler_worker'
#                     })
                    
#                     response = fetch_page(session, url, retries=2)
                    
#                     if not response:
#                         print("Failed to fetch page")
#                         doc.reference.update({
#                             'status': 'failed',
#                             'failed_at': datetime.now().isoformat(),
#                             'error': 'Failed to fetch page'
#                         })
#                         failed_count += 1
#                         continue
                    
#                     print(f"Page fetched successfully - Size: {len(response.content)} bytes")
                    
#                     soup = BeautifulSoup(response.content, 'lxml')
#                     symbol = extract_symbol_from_page(soup, url)
                    
#                     if not symbol:
#                         print("Failed to extract symbol")
#                         doc.reference.update({
#                             'status': 'failed',
#                             'failed_at': datetime.now().isoformat(),
#                             'error': 'Could not extract symbol'
#                         })
#                         failed_count += 1
#                         continue
                    
#                     print(f"Extracted symbol: {symbol}")
                    
#                     company_data = parse_company_data(soup, symbol)
                    
#                     if not company_data:
#                         print("Failed to parse company data")
#                         doc.reference.update({
#                             'status': 'failed',
#                             'failed_at': datetime.now().isoformat(),
#                             'error': 'Failed to parse company data'
#                         })
#                         failed_count += 1
#                         continue
                    
#                     print(f"Enhanced company data parsed successfully")
#                     print(f"Enhanced ratios: debt_to_equity={company_data.get('debt_to_equity')}, current_ratio={company_data.get('current_ratio')}")
                    
#                     try:
#                         doc_ref = db.collection('companies').document(symbol)
#                         doc_ref.set(company_data)
#                         print(f"Successfully wrote enhanced data for {symbol} to Firestore")
                        
#                     except Exception as firestore_error:
#                         print(f"FIRESTORE WRITE ERROR: {str(firestore_error)}")
#                         doc.reference.update({
#                             'status': 'failed',
#                             'failed_at': datetime.now().isoformat(),
#                             'error': f'Firestore write failed: {str(firestore_error)}'
#                         })
#                         failed_count += 1
#                         continue
                    
#                     doc.reference.update({
#                         'status': 'completed',
#                         'completed_at': datetime.now().isoformat(),
#                         'symbol': symbol,
#                         'company_name': company_data.get('name', 'Unknown')
#                     })
                    
#                     processed_count += 1
#                     print(f"Successfully processed {symbol}")
                    
#                     time.sleep(random.uniform(2, 5))
                    
#                 except Exception as processing_error:
#                     print(f"PROCESSING ERROR: {str(processing_error)}")
#                     try:
#                         doc.reference.update({
#                             'status': 'failed',
#                             'failed_at': datetime.now().isoformat(),
#                             'error': str(processing_error)
#                         })
#                         failed_count += 1
#                     except:
#                         print("Failed to update error status")
        
#         print(f"ENHANCED PROCESSING COMPLETE")
#         print(f"Processed: {processed_count}")
#         print(f"Failed: {failed_count}")
        
#         if processed_count > 0 or failed_count > 0:
#             notify_job_complete(processed_count, failed_count)
        
#     except Exception as e:
#         print(f"FATAL ERROR in process_scraping_queue: {str(e)}")
#         notify_job_failed(str(e))

# @https_fn.on_request()
# def get_queue_status_api(req: https_fn.Request) -> https_fn.Response:
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
        
#         recent_completed = []
#         try:
#             completed_docs = db.collection('scraping_queue')\
#                              .where(filter=FieldFilter('status', '==', 'completed'))\
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

# @https_fn.on_request()
# def manage_queue(req: https_fn.Request) -> https_fn.Response:
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
#             docs = db.collection('scraping_queue').where(filter=FieldFilter('status', '==', 'failed')).limit(1000).stream()
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
#             docs = db.collection('scraping_queue').where(filter=FieldFilter('status', '==', 'failed')).limit(100).stream()
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

# @https_fn.on_request()
# def manual_scrape_trigger(req: https_fn.Request) -> https_fn.Response:
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
#                 'message': 'Enhanced data scraping system ready with comprehensive financial analysis including debt ratios, liquidity ratios, and efficiency metrics',
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
#             'message': 'Enhanced comprehensive data scraping with complete financial statements and advanced ratios. You will receive push notification when complete.',
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
import logging

initialize_app()

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

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
    except Exception as e:
        logger.error(f"Failed to send notification: {e}")
        return None

def notify_job_complete(companies_processed, failed_count=0):
    if failed_count == 0:
        send_job_notification(
            title="🎉 Enhanced Job Completed!",
            body=f"Successfully processed {companies_processed} companies with comprehensive financial data and key insights",
            data={'type': 'job_completed', 'companies_processed': str(companies_processed)}
        )
    else:
        send_job_notification(
            title="⚠️ Enhanced Job Completed with Issues",
            body=f"Processed {companies_processed} companies, {failed_count} failed",
            data={'type': 'job_completed_with_errors', 'companies_processed': str(companies_processed)}
        )

def notify_job_failed(error_message):
    send_job_notification(
        title="❌ Enhanced Job Failed",
        body=f"Enhanced data scraping failed: {error_message}",
        data={'type': 'job_failed', 'error': str(error_message)}
    )

def fetch_page(session, url, retries=5, backoff_factor=0.8, referer=None):
    """Enhanced fetch with exponential backoff"""
    headers = {
        'User-Agent': random.choice(USER_AGENTS),
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
        'Accept-Language': 'en-US,en;q=0.9',
        'Connection': 'keep-alive',
        'Upgrade-Insecure-Requests': '1',
        'Cache-Control': 'no-cache',
        'Pragma': 'no-cache'
    }
    
    if referer:
        headers['Referer'] = referer
    
    for attempt in range(retries):
        try:
            if attempt > 0:
                wait_time = min(300, backoff_factor * (2 ** attempt) + random.uniform(0, 2))
                logger.info(f"Waiting {wait_time:.2f}s before retry {attempt + 1}")
                time.sleep(wait_time)
            
            response = session.get(url, headers=headers, timeout=45)
            response.raise_for_status()
            
            # Random delay between successful requests
            time.sleep(random.uniform(2, 5))
            return response
            
        except requests.exceptions.Timeout:
            logger.warning(f"Timeout for {url} (attempt {attempt + 1})")
        except requests.exceptions.RequestException as e:
            logger.warning(f"Request error for {url}: {e} (attempt {attempt + 1})")
        except Exception as e:
            logger.error(f"Unexpected error for {url}: {e} (attempt {attempt + 1})")
    
    logger.error(f"Failed to fetch {url} after {retries} attempts")
    return None

def extract_symbol_from_page(soup, url):
    """Enhanced symbol extraction"""
    # Method 1: NSE link
    nse_link = soup.select_one('a[href*="nseindia.com"]')
    if nse_link:
        nse_text = nse_link.get_text(strip=True)
        if 'NSE:' in nse_text:
            symbol = nse_text.replace('NSE:', '').strip()
            if symbol and len(symbol) <= 10:
                return symbol
    
    # Method 2: URL parsing
    url_parts = url.strip('/').split('/')
    if len(url_parts) >= 2:
        potential_symbol = url_parts[-2] if url_parts[-1] == 'consolidated' else url_parts[-1]
        if potential_symbol and potential_symbol != 'company' and len(potential_symbol) <= 10:
            return potential_symbol
    
    # Method 3: Breadcrumb
    breadcrumb = soup.select_one('.breadcrumb')
    if breadcrumb:
        breadcrumb_text = breadcrumb.get_text(strip=True)
        symbol_match = re.search(r'\b([A-Z]{2,10})\b', breadcrumb_text)
        if symbol_match:
            return symbol_match.group(1)
    
    # Method 4: Company navigation
    company_nav = soup.select_one('.company-nav h1') or soup.select_one('h1.margin-0')
    if company_nav:
        nav_text = company_nav.get_text(strip=True)
        symbol_match = re.search(r'^([A-Z]{2,10})', nav_text)
        if symbol_match:
            return symbol_match.group(1)
    
    return None

def clean_text(text, field_name=""):
    """Enhanced text cleaning"""
    if not text:
        return None
    
    if field_name in ["bse_code", "nse_code"]:
        return text.strip().replace('BSE:', '').replace('NSE:', '').strip()
    
    # Remove common symbols and clean
    cleaned = text.strip().replace('₹', '').replace(',', '').replace('%', '').replace('Cr.', '').replace('Cr', '').strip()
    
    # Handle special cases
    if cleaned.lower() in ['n.a.', 'n/a', 'na', '-', '--', '']:
        return None
        
    return cleaned

def parse_number(text):
    """Enhanced number parsing"""
    cleaned = clean_text(text)
    if not cleaned:
        return None
    
    # Handle negative numbers
    is_negative = cleaned.startswith('-') or cleaned.startswith('(')
    cleaned = cleaned.replace('(', '').replace(')', '').replace('-', '').strip()
    
    # Extract number using regex
    match = re.search(r'\d*\.?\d+', cleaned)
    if match:
        try:
            number = float(match.group(0))
            return -number if is_negative else number
        except (ValueError, TypeError):
            return None
    return None

def get_calendar_sort_key(header_string):
    """Enhanced calendar sorting"""
    MONTH_MAP = {
        'Jan': 1, 'Feb': 2, 'Mar': 3, 'Apr': 4, 'May': 5, 'Jun': 6,
        'Jul': 7, 'Aug': 8, 'Sep': 9, 'Oct': 10, 'Nov': 11, 'Dec': 12
    }
    
    try:
        # Handle different date formats
        if 'FY' in header_string:
            year_match = re.search(r'FY(\d{2,4})', header_string)
            if year_match:
                year = int(year_match.group(1))
                if year < 100:  # Convert 2-digit year
                    year = 2000 + year if year < 50 else 1900 + year
                return (year, 0)
        
        parts = header_string.strip().split()
        if len(parts) >= 2:
            month_str, year_str = parts[0], parts[-1]
            year = int(year_str) if year_str.isdigit() else int(re.search(r'\d+', year_str).group())
            return (year, MONTH_MAP.get(month_str, 0))
        
        # Fallback to extracting year only
        year_match = re.search(r'(\d{4})', header_string)
        if year_match:
            return (int(year_match.group(1)), 0)
            
    except (ValueError, KeyError, IndexError, AttributeError):
        pass
    
    return (0, 0)

def parse_website_link(soup):
    company_links_div = soup.select_one('div.company-links')
    if not company_links_div:
        return None
    
    all_links = company_links_div.find_all('a', href=True)
    for link in all_links:
        href = link['href']
        if 'bseindia.com' not in href and 'nseindia.com' not in href:
            if href.startswith(('http://', 'https://')):
                return href
    return None

def parse_financial_table(soup, table_id):
    """FIXED: Enhanced financial table parsing based on actual HTML structure"""
    try:
        section = soup.select_one(f'section#{table_id}')
        if not section:
            logger.warning(f"Section {table_id} not found")
            return {}
        
        table = section.select_one('table.data-table')
        if not table:
            logger.warning(f"Table not found in section {table_id}")
            return {}
        
        # Extract headers - skip first empty header
        header_row = table.select_one('thead tr')
        if not header_row:
            return {}
            
        header_cells = header_row.select('th')
        if len(header_cells) < 2:
            return {}
            
        # Get headers (skip first empty cell)
        headers = [th.get_text(strip=True) for th in header_cells[1:]]
        if not headers:
            return {}
        
        logger.info(f"Found headers for {table_id}: {headers}")
        
        # Extract rows
        body_data = []
        tbody = table.select_one('tbody')
        if not tbody:
            return {}
            
        rows = tbody.select('tr')
        for row in rows:
            cells = row.select('td')
            if len(cells) < 2:
                continue
                
            # Get row label
            row_label = cells[0].get_text(strip=True)
            if not row_label or len(row_label) < 2:
                continue
                
            # Skip sub-rows or special formatting rows
            if 'sub' in row.get('class', []) or '+' in row_label:
                continue
            
            # Extract values
            values = []
            for i, cell in enumerate(cells[1:]):
                if i >= len(headers):
                    break
                    
                cell_text = cell.get_text(strip=True)
                # Clean and parse value
                cleaned_value = clean_financial_value(cell_text)
                values.append(cleaned_value)
            
            # Pad values if needed
            while len(values) < len(headers):
                values.append('N/A')
            
            body_data.append({
                'description': row_label,
                'values': values
            })
        
        result = {
            'headers': headers,
            'body': body_data
        }
        
        logger.info(f"Successfully parsed {table_id}: {len(body_data)} rows")
        return result
        
    except Exception as e:
        logger.error(f"Error parsing table {table_id}: {e}")
        return {}

def clean_financial_value(text):
    """Clean financial values from HTML"""
    if not text or text.strip() == '':
        return 'N/A'
    
    # Remove common symbols and whitespace
    cleaned = text.strip()
    
    # Handle special cases first
    if cleaned in ['-', '--', 'N.A.', 'N/A', 'NA']:
        return 'N/A'
    
    # Remove currency symbols and units
    cleaned = cleaned.replace('₹', '').replace(',', '').replace('Cr.', '').replace('Cr', '')
    cleaned = cleaned.replace('%', '').replace(' ', '').strip()
    
    # Handle negative values in parentheses
    if cleaned.startswith('(') and cleaned.endswith(')'):
        cleaned = '-' + cleaned[1:-1]
    
    # Try to extract number
    number_match = re.search(r'-?\d+\.?\d*', cleaned)
    if number_match:
        try:
            number = float(number_match.group())
            # Format appropriately
            if abs(number) >= 1000:
                return f"{number:,.0f}"
            elif abs(number) >= 1:
                return f"{number:,.2f}".rstrip('0').rstrip('.')
            else:
                return f"{number:.2f}".rstrip('0').rstrip('.')
        except ValueError:
            pass
    
    # Return original if we can't parse
    return cleaned if cleaned else 'N/A'

def parse_shareholding_table(soup, table_id):
    try:
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
    except Exception as e:
        logger.error(f"Error parsing shareholding table {table_id}: {e}")
        return {}

def parse_growth_tables(soup):
    try:
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
    except Exception as e:
        logger.error(f"Error parsing growth tables: {e}")
        return {}

def process_industry_path(soup):
    try:
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
    except Exception as e:
        logger.error(f"Error processing industry path: {e}")
        return None

def extract_enhanced_ratios(soup):
    """FIXED: Extract ratios based on actual HTML structure"""
    try:
        enhanced_ratios = {}
        
        # Method 1: From top ratios section
        top_ratios = soup.select('#top-ratios li')
        for li in top_ratios:
            name_elem = li.select_one('.name')
            value_elem = li.select_one('.value')
            
            if name_elem and value_elem:
                name = name_elem.get_text(strip=True).lower()
                value_text = value_elem.get_text(strip=True)
                
                # Parse the value
                value = parse_number(value_text)
                if value is not None:
                    # Map to our fields
                    if 'market cap' in name:
                        enhanced_ratios['market_cap'] = value
                    elif 'current price' in name:
                        enhanced_ratios['current_price'] = value
                    elif 'stock p/e' in name or 'pe' in name:
                        enhanced_ratios['stock_pe'] = value
                    elif 'book value' in name:
                        enhanced_ratios['book_value'] = value
                    elif 'dividend yield' in name:
                        enhanced_ratios['dividend_yield'] = value
                    elif 'roce' in name:
                        enhanced_ratios['roce'] = value
                    elif 'roe' in name:
                        enhanced_ratios['roe'] = value
        
        # Method 2: From ratios table
        ratios_section = soup.select_one('section#ratios')
        if ratios_section:
            table = ratios_section.select_one('table.data-table')
            if table:
                rows = table.select('tbody tr')
                for row in rows:
                    cells = row.select('td')
                    if len(cells) >= 2:
                        metric = cells[0].get_text(strip=True).lower()
                        # Get the most recent value (usually last column)
                        value_text = cells[-1].get_text(strip=True)
                        value = parse_number(value_text)
                        
                        if value is not None:
                            # Map specific ratios
                            if 'debtor days' in metric:
                                enhanced_ratios['debtor_days'] = value
                            elif 'inventory days' in metric:
                                enhanced_ratios['inventory_days'] = value
                            elif 'cash conversion cycle' in metric:
                                enhanced_ratios['cash_conversion_cycle'] = value
                            elif 'working capital days' in metric:
                                enhanced_ratios['working_capital_days'] = value
                            elif 'current ratio' in metric:
                                enhanced_ratios['current_ratio'] = value
                            elif 'quick ratio' in metric:
                                enhanced_ratios['quick_ratio'] = value
                            elif 'debt to equity' in metric or 'debt/equity' in metric:
                                enhanced_ratios['debt_to_equity'] = value
                            elif 'interest coverage' in metric:
                                enhanced_ratios['interest_coverage'] = value
                            elif 'asset turnover' in metric:
                                enhanced_ratios['asset_turnover'] = value
        
        # Calculate derived ratios
        current_price = enhanced_ratios.get('current_price')
        book_value = enhanced_ratios.get('book_value')
        if current_price and book_value and book_value != 0:
            enhanced_ratios['price_to_book'] = round(current_price / book_value, 2)
        
        logger.info(f"Extracted enhanced ratios: {list(enhanced_ratios.keys())}")
        return enhanced_ratios
        
    except Exception as e:
        logger.error(f"Error extracting enhanced ratios: {e}")
        return {}

def build_annual_history_from_table(financial_table):
    """Build annual history from the actual table structure"""
    try:
        annual_history = []
        
        if not financial_table or 'headers' not in financial_table:
            return annual_history
        
        headers = financial_table['headers']
        body = financial_table['body']
        
        # Parse years from headers like "Mar 2024", "Mar 2023"
        for i, header in enumerate(headers):
            year_match = re.search(r'(\d{4})', header)
            if not year_match:
                continue
                
            year = year_match.group(1)
            
            # Create annual record
            annual_record = {
                'year': year,
                'sales': None,
                'net_profit': None,
                'eps': None,
                'book_value': None,
                'roe': None,
                'roce': None,
                'operating_profit': None,
                'profit_margin': None,
                'dividend_per_share': None,
                'ebitda': None,
                'gross_profit': None,
                'total_assets': None,
                'total_liabilities': None,
                'shareholders_equity': None,
                'total_debt': None,
                'working_capital': None,
                'operating_cash_flow': None,
                'investing_cash_flow': None,
                'financing_cash_flow': None,
                'free_cash_flow': None,
                'current_ratio': None,
                'quick_ratio': None,
                'debt_to_equity': None,
                'pe_ratio': None,
                'pb_ratio': None,
                'ebitda_margin': None,
                'asset_turnover': None,
                'inventory_turnover': None,
                'interest_coverage': None
            }
            
            # Extract data for this year
            for row_data in body:
                description = row_data['description'].lower()
                values = row_data['values']
                
                if i < len(values) and values[i] != 'N/A':
                    value = parse_number(values[i])
                    if value is not None:
                        # Map based on actual descriptions
                        if 'sales' in description or 'revenue' in description:
                            annual_record['sales'] = value
                        elif 'net profit' in description or 'profit after tax' in description:
                            annual_record['net_profit'] = value
                        elif 'eps' in description:
                            annual_record['eps'] = value
                        elif 'operating profit' in description:
                            annual_record['operating_profit'] = value
                        elif 'book value' in description:
                            annual_record['book_value'] = value
                        elif 'ebitda' in description:
                            annual_record['ebitda'] = value
                        elif 'gross profit' in description:
                            annual_record['gross_profit'] = value
                        elif 'total assets' in description:
                            annual_record['total_assets'] = value
                        elif 'total liabilities' in description:
                            annual_record['total_liabilities'] = value
                        elif 'shareholders equity' in description or "shareholders' equity" in description:
                            annual_record['shareholders_equity'] = value
                        elif 'total debt' in description:
                            annual_record['total_debt'] = value
                        elif 'working capital' in description:
                            annual_record['working_capital'] = value
                        elif 'operating cash flow' in description:
                            annual_record['operating_cash_flow'] = value
                        elif 'investing cash flow' in description:
                            annual_record['investing_cash_flow'] = value
                        elif 'financing cash flow' in description:
                            annual_record['financing_cash_flow'] = value
                        elif 'free cash flow' in description:
                            annual_record['free_cash_flow'] = value
                        elif 'current ratio' in description:
                            annual_record['current_ratio'] = value
                        elif 'quick ratio' in description:
                            annual_record['quick_ratio'] = value
                        elif 'debt to equity' in description or 'debt/equity' in description:
                            annual_record['debt_to_equity'] = value
                        elif 'pe ratio' in description or 'p/e' in description:
                            annual_record['pe_ratio'] = value
                        elif 'pb ratio' in description or 'p/b' in description:
                            annual_record['pb_ratio'] = value
                        elif 'interest coverage' in description:
                            annual_record['interest_coverage'] = value
                        elif 'asset turnover' in description:
                            annual_record['asset_turnover'] = value
                        elif 'inventory turnover' in description:
                            annual_record['inventory_turnover'] = value
            
            # Calculate profit margin if we have both values
            if annual_record['net_profit'] and annual_record['sales'] and annual_record['sales'] != 0:
                annual_record['profit_margin'] = round((annual_record['net_profit'] / annual_record['sales']) * 100, 2)
            
            # Calculate EBITDA margin
            if annual_record['ebitda'] and annual_record['sales'] and annual_record['sales'] != 0:
                annual_record['ebitda_margin'] = round((annual_record['ebitda'] / annual_record['sales']) * 100, 2)
            
            annual_history.append(annual_record)
        
        # Sort by year descending
        annual_history.sort(key=lambda x: x['year'], reverse=True)
        return annual_history[:5]  # Last 5 years
        
    except Exception as e:
        logger.error(f"Error building annual history: {e}")
        return []

def build_quarterly_history_from_table(quarterly_table):
    """Build quarterly history from actual quarterly table"""
    try:
        quarterly_history = []
        
        if not quarterly_table or 'headers' not in quarterly_table:
            return quarterly_history
        
        headers = quarterly_table['headers']
        body = quarterly_table['body']
        
        # Parse quarters from headers
        for i, header in enumerate(headers):
            # Headers like "Mar 2024", "Dec 2023", "Sep 2023"
            match = re.search(r'(\w{3})\s+(\d{4})', header)
            if not match:
                continue
                
            month, year = match.groups()
            
            # Map month to quarter
            quarter_map = {
                'Mar': 'Q4', 'Jun': 'Q1', 'Sep': 'Q2', 'Dec': 'Q3'
            }
            quarter = quarter_map.get(month, 'Q1')
            
            quarterly_record = {
                'quarter': quarter,
                'year': year,
                'month': month,
                'sales': None,
                'net_profit': None,
                'eps': None,
                'operating_profit': None,
                'profit_margin': None,
                'ebitda': None,
                'ebitda_margin': None
            }
            
            # Extract data for this quarter
            for row_data in body:
                description = row_data['description'].lower()
                values = row_data['values']
                
                if i < len(values) and values[i] != 'N/A':
                    value = parse_number(values[i])
                    if value is not None:
                        if 'sales' in description or 'revenue' in description:
                            quarterly_record['sales'] = value
                        elif 'net profit' in description:
                            quarterly_record['net_profit'] = value
                        elif 'eps' in description:
                            quarterly_record['eps'] = value
                        elif 'operating profit' in description:
                            quarterly_record['operating_profit'] = value
                        elif 'ebitda' in description:
                            quarterly_record['ebitda'] = value
            
            # Calculate margins
            if quarterly_record['net_profit'] and quarterly_record['sales'] and quarterly_record['sales'] != 0:
                quarterly_record['profit_margin'] = round((quarterly_record['net_profit'] / quarterly_record['sales']) * 100, 2)
            
            if quarterly_record['ebitda'] and quarterly_record['sales'] and quarterly_record['sales'] != 0:
                quarterly_record['ebitda_margin'] = round((quarterly_record['ebitda'] / quarterly_record['sales']) * 100, 2)
            
            quarterly_history.append(quarterly_record)
        
        return quarterly_history[:8]  # Last 8 quarters
        
    except Exception as e:
        logger.error(f"Error building quarterly history: {e}")
        return []

def calculate_quality_metrics(company_data):
    """Calculate quality score and metrics"""
    try:
        quality_factors = []
        
        # Factor 1: Profitability (ROE)
        if company_data.get('roe'):
            if company_data['roe'] > 20:
                quality_factors.append(1.0)
            elif company_data['roe'] > 15:
                quality_factors.append(0.8)
            elif company_data['roe'] > 10:
                quality_factors.append(0.6)
            else:
                quality_factors.append(0.2)
        
        # Factor 2: Debt levels
        if company_data.get('debt_to_equity') is not None:
            if company_data['debt_to_equity'] < 0.1:
                quality_factors.append(1.0)
            elif company_data['debt_to_equity'] < 0.3:
                quality_factors.append(0.8)
            elif company_data['debt_to_equity'] < 0.6:
                quality_factors.append(0.6)
            else:
                quality_factors.append(0.2)
        
        # Factor 3: Liquidity
        if company_data.get('current_ratio'):
            if company_data['current_ratio'] > 2:
                quality_factors.append(1.0)
            elif company_data['current_ratio'] > 1.5:
                quality_factors.append(0.8)
            elif company_data['current_ratio'] > 1:
                quality_factors.append(0.6)
            else:
                quality_factors.append(0.2)
        
        # Factor 4: Efficiency (Interest Coverage)
        if company_data.get('interest_coverage'):
            if company_data['interest_coverage'] > 10:
                quality_factors.append(1.0)
            elif company_data['interest_coverage'] > 5:
                quality_factors.append(0.8)
            elif company_data['interest_coverage'] > 2:
                quality_factors.append(0.6)
            else:
                quality_factors.append(0.2)
        
        # Calculate overall quality score
        if quality_factors:
            quality_score = sum(quality_factors) / len(quality_factors)
            quality_score_out_of_5 = min(5, max(1, round(quality_score * 5)))
        else:
            quality_score_out_of_5 = 3  # Default middle score
        
        # Quality grade
        if quality_score_out_of_5 >= 4.5:
            quality_grade = 'A'
        elif quality_score_out_of_5 >= 3.5:
            quality_grade = 'B'
        elif quality_score_out_of_5 >= 2.5:
            quality_grade = 'C'
        else:
            quality_grade = 'D'
        
        return {
            'quality_score': quality_score_out_of_5,
            'overall_quality_grade': quality_grade
        }
        
    except Exception as e:
        logger.error(f"Error calculating quality metrics: {e}")
        return {'quality_score': 3, 'overall_quality_grade': 'C'}

def calculate_efficiency_metrics(company_data):
    """Calculate working capital and efficiency metrics"""
    try:
        efficiency_data = {}
        
        # Working capital efficiency
        wc_days = company_data.get('working_capital_days')
        if wc_days:
            if wc_days < 30:
                efficiency_data['working_capital_efficiency'] = 'Excellent'
            elif wc_days < 60:
                efficiency_data['working_capital_efficiency'] = 'Good'
            elif wc_days < 90:
                efficiency_data['working_capital_efficiency'] = 'Average'
            else:
                efficiency_data['working_capital_efficiency'] = 'Poor'
        else:
            efficiency_data['working_capital_efficiency'] = 'Unknown'
        
        # Cash conversion cycle efficiency
        ccc = company_data.get('cash_conversion_cycle')
        if ccc:
            if ccc < 30:
                efficiency_data['cash_cycle_efficiency'] = 'Excellent'
            elif ccc < 60:
                efficiency_data['cash_cycle_efficiency'] = 'Good'
            elif ccc < 90:
                efficiency_data['cash_cycle_efficiency'] = 'Average'
            else:
                efficiency_data['cash_cycle_efficiency'] = 'Poor'
        else:
            efficiency_data['cash_cycle_efficiency'] = 'Unknown'
        
        # Liquidity status
        current_ratio = company_data.get('current_ratio')
        if current_ratio:
            if current_ratio > 2.5:
                efficiency_data['liquidity_status'] = 'Excellent'
            elif current_ratio > 1.5:
                efficiency_data['liquidity_status'] = 'Good'
            elif current_ratio > 1.0:
                efficiency_data['liquidity_status'] = 'Adequate'
            else:
                efficiency_data['liquidity_status'] = 'Poor'
        else:
            efficiency_data['liquidity_status'] = 'Unknown'
        
        # Debt status
        debt_ratio = company_data.get('debt_to_equity', 0)
        if debt_ratio < 0.1:
            efficiency_data['debt_status'] = 'Debt Free'
        elif debt_ratio < 0.3:
            efficiency_data['debt_status'] = 'Low Debt'
        elif debt_ratio < 0.6:
            efficiency_data['debt_status'] = 'Moderate Debt'
        else:
            efficiency_data['debt_status'] = 'High Debt'
        
        # Risk level
        risk_factors = 0
        if debt_ratio > 0.5:
            risk_factors += 1
        if current_ratio and current_ratio < 1.2:
            risk_factors += 1
        if company_data.get('interest_coverage', 10) < 3:
            risk_factors += 1
        
        if risk_factors == 0:
            efficiency_data['risk_level'] = 'Low'
        elif risk_factors == 1:
            efficiency_data['risk_level'] = 'Medium'
        else:
            efficiency_data['risk_level'] = 'High'
        
        return efficiency_data
        
    except Exception as e:
        logger.error(f"Error calculating efficiency metrics: {e}")
        return {
            'working_capital_efficiency': 'Unknown',
            'cash_cycle_efficiency': 'Unknown',
            'liquidity_status': 'Unknown',
            'debt_status': 'Unknown',
            'risk_level': 'Medium'
        }

def extract_company_key_points(soup):
    """NEW: Extract key points and company information for enhanced overview"""
    try:
        key_points = {}
        
        # Business overview from about section
        about_section = soup.select_one('.company-profile .about')
        if about_section:
            about_paragraphs = about_section.select('p')
            about_text = ' '.join([p.get_text(strip=True) for p in about_paragraphs])
            key_points['business_overview'] = about_text[:800] + "..." if len(about_text) > 800 else about_text
        
        # Industry classification
        industry_path = process_industry_path(soup)
        if industry_path:
            key_points['industry_classification'] = industry_path
            key_points['sector'] = industry_path[0] if industry_path else None
            key_points['industry'] = industry_path[1] if len(industry_path) > 1 else None
        
        # Key financial metrics summary
        top_ratios = soup.select('#top-ratios li')
        financial_summary = []
        for li in top_ratios:
            name_elem = li.select_one('.name')
            value_elem = li.select_one('.value')
            if name_elem and value_elem:
                financial_summary.append({
                    'metric': name_elem.get_text(strip=True),
                    'value': value_elem.get_text(strip=True)
                })
        key_points['financial_summary'] = financial_summary
        
        # Recent developments from quarterly data
        quarterly_section = soup.select_one('section#quarters')
        if quarterly_section:
            recent_performance = extract_recent_quarter_performance(quarterly_section)
            key_points['recent_performance'] = recent_performance
        
        # Extract company milestones
        key_points['key_milestones'] = extract_company_milestones(soup)
        
        # Investment highlights
        key_points['investment_highlights'] = extract_investment_highlights(soup)
        
        return key_points
        
    except Exception as e:
        logger.error(f"Error extracting key points: {e}")
        return {}

def extract_recent_quarter_performance(quarterly_section):
    """Extract recent quarter performance data"""
    try:
        table = quarterly_section.select_one('table.data-table')
        if not table:
            return None
            
        headers = [th.get_text(strip=True) for th in table.select('thead th')][1:]
        if not headers:
            return None
            
        # Get latest quarter data
        latest_quarter = headers[0] if headers else None
        performance_data = {'quarter': latest_quarter}
        
        # Extract key metrics for latest quarter
        rows = table.select('tbody tr')
        for row in rows:
            cells = row.select('td')
            if len(cells) >= 2:
                metric = cells[0].get_text(strip=True).lower()
                value = cells[1].get_text(strip=True)
                
                if 'sales' in metric or 'revenue' in metric:
                    performance_data['sales'] = value
                elif 'net profit' in metric:
                    performance_data['net_profit'] = value
                elif 'eps' in metric:
                    performance_data['eps'] = value
                elif 'ebitda' in metric:
                    performance_data['ebitda'] = value
        
        return performance_data
        
    except Exception as e:
        logger.error(f"Error extracting recent performance: {e}")
        return None

def extract_company_milestones(soup):
    """Extract key company milestones and achievements"""
    try:
        milestones = []
        
        # Look for milestone information in various sections
        milestone_indicators = [
            {'text': 'established', 'category': 'foundation'},
            {'text': 'ipo', 'category': 'public_listing'},
            {'text': 'acquisition', 'category': 'expansion'},
            {'text': 'merger', 'category': 'expansion'},
            {'text': 'dividend', 'category': 'shareholder_return'},
            {'text': 'expansion', 'category': 'growth'},
        ]
        
        # Check company profile section for historical information
        profile_section = soup.select_one('.company-profile')
        if profile_section:
            profile_text = profile_section.get_text().lower()
            
            for indicator in milestone_indicators:
                if indicator['text'] in profile_text:
                    milestones.append({
                        'category': indicator['category'],
                        'description': f"Company {indicator['text']} milestone",
                        'relevance': 'medium'
                    })
        
        return milestones[:5]  # Return top 5 milestones
        
    except Exception as e:
        logger.error(f"Error extracting milestones: {e}")
        return []

def extract_investment_highlights(soup):
    """Extract investment highlights and key factors"""
    try:
        highlights = []
        
        # Extract from pros section if available
        pros_section = soup.select('.pros ul li')
        for pro in pros_section[:3]:  # Top 3 pros as highlights
            highlights.append({
                'type': 'strength',
                'description': pro.get_text(strip=True),
                'impact': 'positive'
            })
        
        # Extract financial highlights from ratios
        ratios_section = soup.select('#top-ratios li')
        for ratio in ratios_section:
            name_elem = ratio.select_one('.name')
            value_elem = ratio.select_one('.value')
            
            if name_elem and value_elem:
                name = name_elem.get_text(strip=True).lower()
                value = value_elem.get_text(strip=True)
                
                # Identify key financial highlights
                if 'roe' in name and parse_number(value) and parse_number(value) > 15:
                    highlights.append({
                        'type': 'financial_metric',
                        'description': f"Strong ROE of {value}",
                        'impact': 'positive'
                    })
                elif 'dividend yield' in name and parse_number(value) and parse_number(value) > 2:
                    highlights.append({
                        'type': 'income_generation',
                        'description': f"Regular dividend yield of {value}",
                        'impact': 'positive'
                    })
        
        return highlights[:5]  # Return top 5 highlights
        
    except Exception as e:
        logger.error(f"Error extracting investment highlights: {e}")
        return []

def parse_company_data(soup, symbol):
    """ENHANCED: Company data parsing with comprehensive financial data and key points"""
    try:
        # Basic company information
        company_name_elem = soup.select_one('h1.margin-0') or soup.select_one('.company-nav h1')
        company_name = company_name_elem.get_text(strip=True) if company_name_elem else f"Company {symbol}"
        
        display_name = re.sub(r'\s+(Ltd|Limited|Corporation|Corp|Inc)\.?$', '', company_name, flags=re.IGNORECASE).strip()
        
        # Extract top ratios
        ratios_data = {}
        for li in soup.select('#top-ratios li'):
            name_elem = li.select_one('.name')
            value_elem = li.select_one('.value')
            if name_elem and value_elem:
                ratios_data[name_elem.get_text(strip=True)] = value_elem.get_text(strip=True)
        
        # Company description
        about_elem = soup.select('.company-profile .about p')
        about = ' '.join([p.get_text(strip=True) for p in about_elem]) if about_elem else None
        
        # Extract exchange codes
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
        
        # Extract pros and cons
        pros = [li.get_text(strip=True) for li in soup.select('.pros ul li')]
        cons = [li.get_text(strip=True) for li in soup.select('.cons ul li')]
        
        # Extract enhanced ratios
        enhanced_ratios = extract_enhanced_ratios(soup)
        
        # Parse financial tables
        quarterly_results = parse_financial_table(soup, 'quarters')
        profit_loss_statement = parse_financial_table(soup, 'profit-loss')
        balance_sheet = parse_financial_table(soup, 'balance-sheet')
        cash_flow_statement = parse_financial_table(soup, 'cash-flow')
        ratios_table = parse_financial_table(soup, 'ratios')
        
        # Build historical data
        annual_history = build_annual_history_from_table(profit_loss_statement)
        quarterly_history = build_quarterly_history_from_table(quarterly_results)
        
        # Extract key points and company insights
        key_points = extract_company_key_points(soup)
        
        # Build comprehensive company data
        company_data = {
            # Basic Information
            'symbol': final_symbol,
            'name': company_name,
            'display_name': display_name,
            'description': about,
            'website': parse_website_link(soup),
            'bse_code': bse_code,
            'nse_code': final_symbol,
            
            # Financial Metrics
            'market_cap': parse_number(ratios_data.get('Market Cap')),
            'current_price': parse_number(ratios_data.get('Current Price')),
            'high_low': clean_text(ratios_data.get('High / Low')),
            'stock_pe': parse_number(ratios_data.get('Stock P/E')),
            'book_value': parse_number(ratios_data.get('Book Value')),
            'dividend_yield': parse_number(ratios_data.get('Dividend Yield')),
            'roce': parse_number(ratios_data.get('ROCE')),
            'roe': parse_number(ratios_data.get('ROE')),
            'face_value': parse_number(ratios_data.get('Face Value')),
            
            # Enhanced ratios from detailed analysis
            **enhanced_ratios,
            
            # Analysis
            'pros': pros,
            'cons': cons,
            
            # NEW: Key Points and Company Insights
            'business_overview': key_points.get('business_overview', ''),
            'sector': key_points.get('sector', ''),
            'industry': key_points.get('industry', ''),
            'industry_classification': key_points.get('industry_classification', []),
            'recent_performance': key_points.get('recent_performance', {}),
            'key_milestones': key_points.get('key_milestones', []),
            'investment_highlights': key_points.get('investment_highlights', []),
            'financial_summary': key_points.get('financial_summary', []),
            
            # Timestamps
            'last_updated': datetime.now().isoformat(),
            'change_percent': 0.0,
            'change_amount': 0.0,
            'previous_close': parse_number(ratios_data.get('Current Price', '0.0')) or 0.0,
            
            # Historical Data
            'annual_data_history': annual_history,
            'quarterly_data_history': quarterly_history,
            
            # Financial Statements
            'quarterly_results': quarterly_results,
            'profit_loss_statement': profit_loss_statement,
            'balance_sheet': balance_sheet,
            'cash_flow_statement': cash_flow_statement,
            'ratios': ratios_table,
            
            # Additional Data
            'shareholding_pattern': {
                'quarterly': parse_shareholding_table(soup, 'quarterly-shp')
            },
            **parse_growth_tables(soup),
            'ratios_data': ratios_data
        }
        
        # Calculate derived metrics
        if company_data['current_price'] and company_data['book_value'] and company_data['book_value'] != 0:
            company_data['price_to_book'] = round(company_data['current_price'] / company_data['book_value'], 2)
        
        # Add quality metrics
        quality_metrics = calculate_quality_metrics(company_data)
        company_data.update(quality_metrics)
        
        # Add efficiency metrics
        efficiency_metrics = calculate_efficiency_metrics(company_data)
        company_data.update(efficiency_metrics)
        
        # Additional boolean flags for easier filtering
        company_data['is_debt_free'] = company_data.get('debt_to_equity', 1) < 0.1
        company_data['pays_dividends'] = company_data.get('dividend_yield', 0) > 0
        company_data['is_profitable'] = company_data.get('roe', 0) > 0
        company_data['has_consistent_profits'] = len([h for h in annual_history if h.get('net_profit', 0) > 0]) >= 3
        
        # Growth calculations
        recent_growth = []
        if len(annual_history) >= 2:
            for i in range(1, min(4, len(annual_history))):
                if annual_history[i-1].get('sales') and annual_history[i].get('sales'):
                    growth = ((annual_history[i-1]['sales'] - annual_history[i]['sales']) / annual_history[i]['sales']) * 100
                    recent_growth.append(growth)
        
        avg_growth = sum(recent_growth) / len(recent_growth) if recent_growth else 0
        company_data['sales_growth_3y'] = round(avg_growth, 1) if recent_growth else None
        
        # Profit growth calculation
        profit_growth = []
        if len(annual_history) >= 2:
            for i in range(1, min(4, len(annual_history))):
                if annual_history[i-1].get('net_profit') and annual_history[i].get('net_profit'):
                    growth = ((annual_history[i-1]['net_profit'] - annual_history[i]['net_profit']) / annual_history[i]['net_profit']) * 100
                    profit_growth.append(growth)
        
        avg_profit_growth = sum(profit_growth) / len(profit_growth) if profit_growth else 0
        company_data['profit_growth_3y'] = round(avg_profit_growth, 1) if profit_growth else None
        
        # Stock classification
        company_data['is_growth_stock'] = avg_growth > 15
        company_data['is_value_stock'] = company_data.get('stock_pe', 50) < 15 and company_data.get('price_to_book', 5) < 2
        
        # Market cap classification
        market_cap = company_data.get('market_cap', 0)
        if market_cap >= 20000:
            company_data['market_cap_category'] = 'Large Cap'
            company_data['market_cap_category_text'] = 'Large Cap'
        elif market_cap >= 5000:
            company_data['market_cap_category'] = 'Mid Cap'
            company_data['market_cap_category_text'] = 'Mid Cap'
        else:
            company_data['market_cap_category'] = 'Small Cap'
            company_data['market_cap_category_text'] = 'Small Cap'
        
        # Formatted fields for display
        company_data['formatted_price'] = f"₹{company_data['current_price']:,.2f}" if company_data['current_price'] else "N/A"
        company_data['formatted_market_cap'] = f"₹{company_data['market_cap']:,.0f} Cr" if company_data['market_cap'] else "N/A"
        company_data['formatted_change'] = f"{company_data['change_percent']:+.2f}%" if company_data['change_percent'] else "0.00%"
        company_data['formatted_last_updated'] = datetime.now().strftime("%d %b %Y")
        
        # Price movement indicators
        company_data['is_gainer'] = company_data['change_percent'] > 0
        company_data['is_loser'] = company_data['change_percent'] < 0
        
        logger.info(f"Successfully parsed ENHANCED data for {symbol}")
        logger.info(f"Enhanced ratios found: {list(enhanced_ratios.keys())}")
        logger.info(f"Quality score: {company_data.get('quality_score')}")
        logger.info(f"Annual history: {len(annual_history)} years")
        logger.info(f"Quarterly history: {len(quarterly_history)} quarters")
        logger.info(f"Key points extracted: business_overview={bool(company_data.get('business_overview'))}")
        logger.info(f"Investment highlights: {len(company_data.get('investment_highlights', []))}")
        
        return company_data
        
    except Exception as e:
        logger.error(f"Error parsing ENHANCED company data for {symbol}: {e}")
        return None

# Keep all existing helper functions for queue management
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
            'status_text': 'Enhanced Processing Active' if processing_count > 0 or pending_count > 0 else ('Enhanced Data Complete' if completed_count > 0 else 'Ready for Enhanced Scraping'),
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
        max_pages = request_json.get('max_pages', 200)
        
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
                    'max_retries': 3,
                    'scraper_version': 'enhanced_v3.0_with_key_points'
                })
            
            batch.commit()
            total_queued += len(batch_urls)
        
        return https_fn.Response(
            json.dumps({
                'status': 'success',
                'message': f'Successfully queued {total_queued} companies for ENHANCED comprehensive data scraping with key points and company insights',
                'queued_count': total_queued,
                'pages_processed': max_pages,
                'enhancement_features': [
                    'Working capital efficiency analysis',
                    'Cash conversion cycle calculation',
                    'Enhanced liquidity ratios',
                    'Comprehensive quality scoring',
                    'Historical data building (5 years annual, 8 quarters)',
                    'Business overview extraction',
                    'Key company milestones',
                    'Investment highlights',
                    'Recent performance analysis',
                    'Industry classification'
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
    print(f"Starting ENHANCED queue processing with key points extraction at {datetime.now()}")
    
    try:
        db = get_db()
        
        cleanup_old_queue_items(db)
        reset_stale_processing_items(db)
        
        pending_items = list(db.collection('scraping_queue')
                           .where(filter=FieldFilter('status', '==', 'pending'))
                           .limit(5)
                           .stream())
        
        print(f"Found {len(pending_items)} pending items for ENHANCED processing with key points")
        
        if not pending_items:
            print("No pending items found")
            return
        
        processed_count = 0
        failed_count = 0
        
        with requests.Session() as session:
            for i, doc in enumerate(pending_items):
                print(f"ENHANCED processing item {i+1}/{len(pending_items)} with key points extraction")
                
                try:
                    data = doc.to_dict()
                    url = data['url']
                    print(f"URL: {url}")
                    
                    doc.reference.update({
                        'status': 'processing',
                        'started_at': datetime.now().isoformat(),
                        'processor_id': 'enhanced_scheduler_v3_key_points'
                    })
                    
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
                    symbol = extract_symbol_from_page(soup, url)
                    
                    if not symbol:
                        print("Failed to extract symbol")
                        doc.reference.update({
                            'status': 'failed',
                            'failed_at': datetime.now().isoformat(),
                            'error': 'Could not extract symbol'
                        })
                        failed_count += 1
                        continue
                    
                    print(f"Extracted symbol: {symbol}")
                    
                    # Use the ENHANCED parsing function with key points
                    company_data = parse_company_data(soup, symbol)
                    
                    if not company_data:
                        print("Failed to parse ENHANCED company data with key points")
                        doc.reference.update({
                            'status': 'failed',
                            'failed_at': datetime.now().isoformat(),
                            'error': 'Failed to parse enhanced company data with key points'
                        })
                        failed_count += 1
                        continue
                    
                    print(f"ENHANCED company data with key points parsed successfully")
                    print(f"Quality score: {company_data.get('quality_score')}")
                    print(f"Working capital efficiency: {company_data.get('working_capital_efficiency')}")
                    print(f"Business overview: {bool(company_data.get('business_overview'))}")
                    print(f"Investment highlights: {len(company_data.get('investment_highlights', []))}")
                    print(f"Key milestones: {len(company_data.get('key_milestones', []))}")
                    print(f"Annual history records: {len(company_data.get('annual_data_history', []))}")
                    print(f"Enhanced ratios: {[k for k in company_data.keys() if k in ['debt_to_equity', 'current_ratio', 'working_capital_days', 'cash_conversion_cycle']]}")
                    
                    try:
                        doc_ref = db.collection('companies').document(symbol)
                        doc_ref.set(company_data)
                        print(f"Successfully wrote ENHANCED data with key points for {symbol} to Firestore")
                        
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
                        'company_name': company_data.get('name', 'Unknown'),
                        'enhancement_version': 'v3.0_with_key_points',
                        'features_extracted': [
                            'enhanced_ratios',
                            'quality_metrics',
                            'efficiency_analysis',
                            'historical_data',
                            'key_points',
                            'business_overview',
                            'investment_highlights',
                            'company_milestones'
                        ]
                    })
                    
                    processed_count += 1
                    print(f"Successfully processed ENHANCED data with key points for {symbol}")
                    
                    time.sleep(random.uniform(2, 5))
                    
                except Exception as processing_error:
                    print(f"ENHANCED PROCESSING ERROR: {str(processing_error)}")
                    try:
                        doc.reference.update({
                            'status': 'failed',
                            'failed_at': datetime.now().isoformat(),
                            'error': str(processing_error)
                        })
                        failed_count += 1
                    except:
                        print("Failed to update error status")
        
        print(f"ENHANCED PROCESSING WITH KEY POINTS COMPLETE")
        print(f"Processed: {processed_count}")
        print(f"Failed: {failed_count}")
        
        if processed_count > 0 or failed_count > 0:
            notify_job_complete(processed_count, failed_count)
        
    except Exception as e:
        print(f"FATAL ERROR in enhanced process_scraping_queue with key points: {str(e)}")
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
                    'completed_at': data.get('completed_at', ''),
                    'enhancement_version': data.get('enhancement_version', 'v1.0'),
                    'features_extracted': data.get('features_extracted', [])
                })
        except Exception:
            pass
        
        response_data = {
            'status': 'success',
            'queue_status': status,
            'recent_completed': recent_completed,
            'enhancement_features': [
                'Working Capital Analysis',
                'Cash Conversion Cycle',
                'Enhanced Liquidity Ratios',
                'Quality Scoring System',
                'Historical Data Building',
                'Business Overview Extraction',
                'Key Company Milestones',
                'Investment Highlights',
                'Recent Performance Analysis',
                'Industry Classification'
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
                json.dumps({'status': 'success', 'message': f'Cleared {count} failed enhanced processing items'}),
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
                json.dumps({'status': 'success', 'message': f'Reset {count} failed items to pending for enhanced reprocessing with key points'}),
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
                'message': 'ENHANCED data scraping system ready with comprehensive financial analysis and company insights',
                'enhanced_features': [
                    'Working capital efficiency analysis',
                    'Cash conversion cycle calculation', 
                    'Enhanced liquidity ratios',
                    'Comprehensive quality scoring',
                    'Historical data building (5 years annual, 8 quarters)',
                    'Business overview extraction',
                    'Key company milestones identification',
                    'Investment highlights analysis',
                    'Recent performance tracking',
                    'Industry classification mapping',
                    'Advanced pattern matching for ratios',
                    'Automatic debt and risk classification',
                    'Growth stock identification',
                    'Value stock detection'
                ],
                'timestamp': datetime.now().isoformat(),
                'test_mode': True,
                'version': 'enhanced_v3.0_with_key_points'
            }
            return https_fn.Response(
                json.dumps(response_data),
                status=200, headers=headers
            )
        
        db = get_db()
        status = get_queue_status(db)
        
        response_data = {
            'status': 'success',
            'message': 'ENHANCED comprehensive data scraping initiated with complete financial statements, working capital analysis, key company insights, and business overview. Push notification will be sent when complete.',
            'current_queue_status': status,
            'enhancement_details': {
                'financial_analysis': {
                    'working_capital_analysis': 'Debtor days, inventory days, cash conversion cycle',
                    'liquidity_metrics': 'Current ratio, quick ratio, liquidity status assessment',
                    'quality_scoring': '5-point quality score with A-D grading',
                    'historical_data': 'Annual (5 years) and quarterly (8 quarters) history',
                    'efficiency_classification': 'Excellent/Good/Average/Poor ratings',
                    'risk_assessment': 'Low/Medium/High risk categorization'
                },
                'company_insights': {
                    'business_overview': 'Comprehensive company description and operations',
                    'key_milestones': 'Important company achievements and developments',
                    'investment_highlights': 'Key factors for investment consideration',
                    'recent_performance': 'Latest quarterly performance analysis',
                    'industry_classification': 'Sector and industry mapping'
                }
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
