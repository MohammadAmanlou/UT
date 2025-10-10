import sqlite3
from datetime import datetime, timedelta
import time
import gdelt
from dateutil.relativedelta import relativedelta
from tqdm import tqdm
import json

def init_database(db_name="gdelt_data.db",table_name="raw_news"):
    conn = sqlite3.connect(db_name)
    cursor = conn.cursor()
    cursor.execute(f'''
        CREATE TABLE IF NOT EXISTS {table_name} (
            date TEXT,
            url TEXT,
            PRIMARY KEY (date, url)
        )
    ''')
    conn.commit()
    return conn

def save_to_database(conn, date_url_data, table_name="raw_news"):
    cursor = conn.cursor()
    for day in date_url_data:
        date = day['date']
        urls = day['urls']
        for url in urls:
            cursor.execute(f'''
                INSERT OR IGNORE INTO {table_name} (date, url)
                VALUES (?, ?)
            ''', (date, url))
    conn.commit()

def crawl_gdelt(start_date, end_date):
    gd2 = gdelt.gdelt(version=2)
    start_datetime = datetime.strptime(start_date, '%Y %m %d')
    end_datetime = datetime.strptime(end_date, '%Y %m %d')
    if start_datetime > end_datetime:
        raise Exception("No days between dates")
    delta = end_datetime - start_datetime
    num_days = delta.days + 1
    print(f"Starting download for {num_days} days...\n")
    date_url_data = []
    for i in tqdm(range(num_days), desc="Processing dates"):
        current_date = start_datetime + timedelta(days=i)
        current_date_str = current_date.strftime('%Y %m %d')
        formatted_date = current_date.strftime('%d %B %Y')
        start_time = time.time()
        try:
            results_json = gd2.Search([current_date_str], table='mentions', output='json')
            results_json = json.loads(results_json)
            urls = []
            for record in results_json:
                date = record["EventTimeDate"]
                dt = datetime.strptime(str(date), "%Y%m%d%H%M%S")
                formatted_date = dt.strftime("%d %B %Y")
                url = record["MentionIdentifier"]
                urls.append(url)
            date_url_data.append({
                'date': formatted_date,
                'urls': urls
            })
            elapsed_time = time.time() - start_time
            print(f"[{formatted_date}] Retrieved {len(urls)} URLs in {elapsed_time:.2f} seconds")
        except Exception as e:
            print(f"Error processing {formatted_date}: {e}")
            continue
    print("Crawling complete!")
    return date_url_data

def save_gdelt_data(date_url_data, db_name="gdelt_data.db", table_name = "raw_news"):
    conn = init_database(db_name, table_name)
    save_to_database(conn, date_url_data, table_name)
    cursor = conn.cursor()
    cursor.execute(f'''
        SELECT date, url FROM {table_name}
        ORDER BY date
    ''')
    sorted_data = cursor.fetchall()
    print("\nData in database:")
    current_date = None
    url_count = 0
    for date, url in sorted_data:
        if date != current_date:
            if current_date is not None:
                print(f"{current_date}: {url_count} URLs")
            current_date = date
            url_count = 1
        else:
            url_count += 1
    if current_date is not None:
        print(f"{current_date}: {url_count} URLs")
    conn.close()
