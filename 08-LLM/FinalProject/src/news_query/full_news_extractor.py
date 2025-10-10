import sqlite3
import requests
from bs4 import BeautifulSoup
from tqdm import tqdm
import re
from datetime import datetime, timedelta
import pandas as pd
import os
from src.news_query.key_word_filtering import ALL_KEYWORDS
import logging
import sys
from concurrent.futures import ThreadPoolExecutor, as_completed


logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.StreamHandler(sys.stdout)
    ]
)
logger = logging.getLogger(__name__)

def get_bbc_urls(db_name, table_name):
    logger.info(f"Fetching BBC URLs from {table_name} in {db_name}")
    conn = sqlite3.connect(db_name)
    cursor = conn.cursor()
    cursor.execute(f"""
        SELECT date, url FROM {table_name}
        WHERE url LIKE '%bbc.co.uk%' OR url LIKE '%bbc.com%'
    """)
    bbc_news = cursor.fetchall()
    conn.close()
    logger.info(f"Retrieved {len(bbc_news)} BBC URLs")
    return bbc_news

def get_times_urls(db_name, table_name):
    logger.info(f"Fetching NYT URLs from {table_name} in {db_name}")
    conn = sqlite3.connect(db_name)
    cursor = conn.cursor()
    cursor.execute(f"""
        SELECT date, url FROM {table_name}
        WHERE url LIKE '%nytimes.com%'
    """)
    times_news = cursor.fetchall()
    conn.close()
    logger.info(f"Retrieved {len(times_news)} NYT URLs")
    return times_news

def init_filtered_news_database(db_name="gdelt_data.db", table_name="filtered_news"):
    logger.info(f"Initializing filtered news database: {db_name}, table: {table_name}")
    conn = sqlite3.connect(db_name)
    cursor = conn.cursor()
    cursor.execute(f'''
        CREATE TABLE IF NOT EXISTS {table_name} (
            date TEXT,
            url TEXT,
            matched_keywords TEXT,
            PRIMARY KEY (date, url)
        )
    ''')
    conn.commit()
    logger.info("Filtered news table initialized")
    return conn

def get_news_content(url, timeout=10):
    try:
        headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
        }
        response = requests.get(url, headers=headers, timeout=timeout)
        response.raise_for_status()
        soup = BeautifulSoup(response.text, 'html.parser')
        paragraphs = soup.find_all('p')
        main_text = ' '.join([p.get_text() for p in paragraphs])
        if not main_text:
            body_divs = soup.find_all('div', class_=re.compile(r'(body|content|article|main)', re.IGNORECASE))
            main_text = ' '.join([div.get_text() for div in body_divs])
        logger.debug(f"Fetched content from {url}")
        return main_text.strip() if main_text else None
    except requests.exceptions.RequestException as e:
        # logger.error(f"Error fetching {url}: {e}")
        return None
    except Exception as e:
        # logger.error(f"Error parsing {url}: {e}")
        return None



def process_article(news_date, news_url, keywords):
    content = get_news_content(news_url)
    if not content:
        return None
    found_keywords = []
    content_lower = content.lower()
    for keyword in keywords:
        if keyword.lower() in content_lower:
            found_keywords.append(keyword)
    if found_keywords:
        matched_keywords_str = ", ".join(sorted(set(found_keywords)))
        return (news_date, news_url, matched_keywords_str)
    return None

def filter_and_save_news(db_name="gdelt_data.db", save_db_name="filtered_news.db", raw_table="raw_news", filtered_table="filtered_news", keywords=ALL_KEYWORDS, url_filter=None):
    logger.info(f"Starting parallel news filtering: db={db_name}, raw_table={raw_table}, filtered_table={filtered_table}")
    conn_raw = sqlite3.connect(db_name)
    cursor_raw = conn_raw.cursor()

    save_database = init_filtered_news_database(save_db_name, filtered_table)
    save_cursor = save_database.cursor()

    query = f"SELECT date, url FROM {raw_table}"
    if url_filter:
        query += f" WHERE {url_filter}"
    cursor_raw.execute(query)
    all_raw_news = cursor_raw.fetchall()
    conn_raw.close()

    logger.info(f"Fetched {len(all_raw_news)} articles for processing")

    filtered_articles = []
    failed_to_fetch_count = 0

    with ThreadPoolExecutor(max_workers=10) as executor:
        future_to_article = {
            executor.submit(process_article, news_date, news_url, keywords): (news_date, news_url)
            for news_date, news_url in all_raw_news
        }

        for future in tqdm(as_completed(future_to_article), total=len(future_to_article), desc="Filtering in parallel"):
            try:
                result = future.result()
                if result:
                    filtered_articles.append(result)
            except Exception as e:
                news_date, news_url = future_to_article[future]
                # logger.error(f"Error processing article {news_url}: {e}")
                failed_to_fetch_count += 1

    logger.info(f"Saving {len(filtered_articles)} filtered articles to DB")
    for article in filtered_articles:
        try:
            save_cursor.execute(f'''
                INSERT OR IGNORE INTO {filtered_table} (date, url, matched_keywords)
                VALUES (?, ?, ?)
            ''', article)
        except sqlite3.Error as e:
            logger.error(f"Error saving article {article[1]}: {e}")

    save_database.commit()
    save_database.close()

    logger.info(f"Filtering complete: Processed={len(all_raw_news)}, Filtered={len(filtered_articles)}, Failed={failed_to_fetch_count}")

def get_date_range(start_date="2021-01-01", end_date="2025-06-15"):
    logger.info(f"Generating date range from {start_date} to {end_date}")
    start = datetime.strptime(start_date, "%Y-%m-%d")
    end = datetime.strptime(end_date, "%Y-%m-%d")
    date_list = []
    current_date = start
    while current_date <= end:
        date_list.append(current_date.strftime("%Y-%m-%d"))
        current_date += timedelta(days=1)
    logger.info(f"Generated {len(date_list)} dates")
    return date_list

def find_existing_days(db_name, filtered_table="filtered_news", start_date="2021-01-01", end_date="2025-06-05"):
    logger.info(f"Finding missing days in {filtered_table} from {start_date} to {end_date}")
    conn = sqlite3.connect(db_name)
    cursor = conn.cursor()
    cursor.execute(f"""
        SELECT DISTINCT date FROM {filtered_table}
    """)
    existing_dates = set(row[0] for row in cursor.fetchall())
    conn.close()
    return existing_dates

def all_dates(db_name, table="raw_news"):
    conn = sqlite3.connect(db_name)
    cursor = conn.cursor()
    cursor.execute(f"""
        SELECT DISTINCT date FROM {table}
    """)
    existing_dates = set(row[0] for row in cursor.fetchall())
    conn.close()
    return existing_dates


def fill_missing_days(existing_dates, all_dates_names, db_name="gdelt_data.db",save_db_name="filtered_news.db", raw_table="raw_news", filtered_table="filtered_news", ):
    logger.info(f"Filling missing days in {filtered_table}")
    temp_db = "temp.db"
    temp_table = "temp_raw_news"
    conn = sqlite3.connect(db_name)
    cursor = conn.cursor()
    try:
        os.remove(temp_db)
    except:
        logger.info(f"No temp found")
        
        
    for date in tqdm(all_dates_names, desc="Filling missing days"):
        if date in existing_dates:
            continue

        cursor.execute(f"""
            SELECT date, url FROM {raw_table}
            WHERE date = ?
            AND url NOT LIKE '%bbc.co.uk%'
            AND url NOT LIKE '%bbc.com%'
            AND url NOT LIKE '%nytimes.com%'
            LIMIT 300
        """, (date,))
        articles = cursor.fetchall()

        if articles:
            
          
            temp_conn = sqlite3.connect(temp_db)
            temp_cursor = temp_conn.cursor()
            temp_cursor.execute(f'''
                CREATE TABLE IF NOT EXISTS {temp_table} (
                    date TEXT,
                    url TEXT
                )
            ''')
            temp_cursor.executemany(f'''
                INSERT INTO {temp_table} (date, url)
                VALUES (?, ?)
            ''', articles)
            temp_conn.commit()

            filter_and_save_news(
                db_name=temp_db,
                raw_table=temp_table,
                save_db_name=save_db_name,
                filtered_table=filtered_table,
                keywords=ALL_KEYWORDS
            )
            temp_conn.close()
            os.remove(temp_db)

    conn.close()
    logger.info("Finished filling missing days")
def verify_coverage(all_dates, db_name="gdelt_data.db", filtered_table="filtered_news", ):
    conn = sqlite3.connect(db_name)
    cursor = conn.cursor()
    cursor.execute(f"SELECT DISTINCT date FROM {filtered_table}")
    covered_dates = set(row[0] for row in cursor.fetchall())
    conn.close()

    missing_dates = sorted(list(all_dates - covered_dates))
    logger.info(f"Verification complete: {len(missing_dates)} days missing")
    if missing_dates:
        logger.warning(f"Missing dates: {missing_dates}")
    else:
        logger.info("All days covered")
        
            

if __name__ == "__main__":
    db_name = "gdelt_data.db"
    save_db_name = "filtered_news.db"
    raw_table = "raw_news"
    filtered_table = "filtered_news"
    start_date = "2021-01-01"
    end_date = "2025-06-05"

    # logger.info("Starting main execution")
    # logger.info("Step 2: Filtering BBC and NYT articles")
    # filter_and_save_news(
    #     db_name=db_name,
    #     save_db_name=save_db_name,
    #     raw_table=raw_table,
    #     filtered_table=filtered_table,
    #     keywords=ALL_KEYWORDS,
    #     url_filter="url LIKE '%bbc.co.uk%' OR url LIKE '%bbc.com%' OR url LIKE '%nytimes.com%'"
    # )
    all_dates_names = all_dates(db_name)
    existing_dates = find_existing_days(save_db_name, filtered_table, start_date, end_date)
    # fill_missing_days(existing_dates,all_dates_names,db_name,save_db_name, raw_table, filtered_table)
    verify_coverage(all_dates_names, save_db_name, filtered_table)
    # conn = sqlite3.connect("filtered_news.db")
    # cursor = conn.cursor()
    # cursor.execute(f"""
    #     SELECT date, url FROM filtered_news
    # """)
    # bbc_news = cursor.fetchall()
    # conn.close()

    # # Get unique dates
    # unique_dates = set(date for date, url in bbc_news)

    # # Print unique dates and their count
    # print(f"Unique dates: {unique_dates}")
    # print(f"Total unique dates: {len(unique_dates)}")
    # print(f"Total BBC articles found: {len(bbc_news)}\n")
