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
            title="🎉 Job Completed!",
            body=f"Successfully processed {companies_processed} companies with enhanced financial data",
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
            if href.startswith(('http://', 'https://')):
                return href
    return None

def parse_financial_table(soup, table_id):
    """Enhanced financial table parsing"""
    try:
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
    except Exception as e:
        logger.error(f"Error parsing financial table {table_id}: {e}")
        return {}

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
    """Extract additional financial ratios from ratios section"""
    try:
        enhanced_ratios = {}
        ratios_section = soup.select_one('section#ratios')
        
        if ratios_section:
            rows = ratios_section.select('tr')
            for row in rows:
                cells = row.select(['td', 'th'])
                if len(cells) >= 2:
                    metric = cells[0].get_text(strip=True)
                    value = cells[-1].get_text(strip=True)  # Latest value
                    
                    # Extract specific ratios using exact field names from screener.in
                    if 'Debt to Equity' in metric:
                        enhanced_ratios['debt_to_equity'] = parse_number(value)
                    elif 'Current Ratio' in metric:
                        enhanced_ratios['current_ratio'] = parse_number(value)
                    elif 'Quick Ratio' in metric:
                        enhanced_ratios['quick_ratio'] = parse_number(value)
                    elif 'Working Capital Days' in metric or 'Working Capital' in metric:
                        enhanced_ratios['working_capital_days'] = parse_number(value)
                    elif 'Debtor Days' in metric or 'Debtors' in metric:
                        enhanced_ratios['debtor_days'] = parse_number(value)
                    elif 'Inventory Days' in metric:
                        enhanced_ratios['inventory_days'] = parse_number(value)
                    elif 'Cash Conversion Cycle' in metric:
                        enhanced_ratios['cash_conversion_cycle'] = parse_number(value)
                    elif 'Interest Coverage' in metric:
                        enhanced_ratios['interest_coverage'] = parse_number(value)
                    elif 'Asset Turnover' in metric:
                        enhanced_ratios['asset_turnover'] = parse_number(value)
        
        return enhanced_ratios
    except Exception as e:
        logger.error(f"Error extracting enhanced ratios: {e}")
        return {}

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
        
        # Extract enhanced ratios
        enhanced_ratios = extract_enhanced_ratios(soup)
        
        # Build comprehensive company data
        company_data = {
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
            
            # Add enhanced ratios
            **enhanced_ratios,
            
            # Comprehensive financial statements
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
        
        # Calculate price to book if both values exist
        if company_data['current_price'] and company_data['book_value']:
            company_data['price_to_book'] = round(company_data['current_price'] / company_data['book_value'], 2)
        
        return company_data
        
    except Exception as e:
        logger.error(f"Error parsing company data for {symbol}: {e}")
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
                'message': f'Successfully queued {total_queued} companies for enhanced data scraping',
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
    print(f"Starting enhanced queue processing at {datetime.now()}")
    
    try:
        db = get_db()
        
        cleanup_old_queue_items(db)
        reset_stale_processing_items(db)
        
        pending_items = list(db.collection('scraping_queue')
                           .where(filter=FieldFilter('status', '==', 'pending'))
                           .limit(5)
                           .stream())
        
        print(f"Found {len(pending_items)} pending items in queue")
        
        if not pending_items:
            print("No pending items found")
            return
        
        processed_count = 0
        failed_count = 0
        
        with requests.Session() as session:
            for i, doc in enumerate(pending_items):
                print(f"Processing item {i+1}/{len(pending_items)}")
                
                try:
                    data = doc.to_dict()
                    url = data['url']
                    print(f"URL: {url}")
                    
                    doc.reference.update({
                        'status': 'processing',
                        'started_at': datetime.now().isoformat(),
                        'processor_id': 'enhanced_scheduler_worker'
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
                    
                    print(f"Enhanced company data parsed successfully")
                    print(f"Enhanced ratios: debt_to_equity={company_data.get('debt_to_equity')}, current_ratio={company_data.get('current_ratio')}")
                    
                    try:
                        doc_ref = db.collection('companies').document(symbol)
                        doc_ref.set(company_data)
                        print(f"Successfully wrote enhanced data for {symbol} to Firestore")
                        
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
        
        print(f"ENHANCED PROCESSING COMPLETE")
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
                'message': 'Enhanced data scraping system ready with comprehensive financial analysis including debt ratios, liquidity ratios, and efficiency metrics',
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
            'message': 'Enhanced comprehensive data scraping with complete financial statements and advanced ratios. You will receive push notification when complete.',
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
