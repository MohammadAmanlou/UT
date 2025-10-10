import time
import pandas as pd
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from datetime import datetime
from dateutil.relativedelta import relativedelta
import sqlite3
import logging
from utils import parse_relative_time

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

def get_full_news_page(ticker, max_scrolls=120, pause=2):
    logging.info(f"Starting browser for ticker: {ticker}")
    url = f'https://finance.yahoo.com/quote/{ticker}/news'
    options = Options()
    options.add_argument("--headless")
    options.add_argument("--disable-gpu")
    options.add_argument("--no-sandbox")

    driver = webdriver.Chrome(options=options)
    driver.get(url)
    time.sleep(3)

    last_height = driver.execute_script("return document.body.scrollHeight")
    for i in range(max_scrolls):
        logging.info(f"Scrolling {i+1}/{max_scrolls}")
        driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        time.sleep(pause)
        new_height = driver.execute_script("return document.body.scrollHeight")
        if new_height == last_height:
            # logging.info("Reached end of page.")
            time.sleep(5)
            continue
        last_height = new_height

    html = driver.page_source
    driver.quit()
    logging.info("Browser closed and page source retrieved.")
    return html

def crawl_gold_news(ticker='GC=F', months=24):
    logging.info(f"Starting news crawl for ticker: {ticker} over last {months} months")
    try:
        cutoff_date = datetime.now() - relativedelta(months=months)
        html = get_full_news_page(ticker,50, 5)
        soup = BeautifulSoup(html, 'html.parser')
        news_stream = soup.find('div', class_='news-stream yf-1napat3')
        if not news_stream:
            logging.warning("News stream section not found.")
            return []
        articles = news_stream.find_all('li', class_='stream-item story-item yf-1drgw5l')
        reference_time = datetime.now()
        article_data = []
        for idx, article in enumerate(articles):
            title_tag = article.find('h3', class_='clamp yf-1jsv3x8')
            title = title_tag.text.strip() if title_tag else 'N/A'
            link_tag = article.find('a', class_='subtle-link', href=True)
            url = link_tag['href'] if link_tag else 'N/A'
            if url != 'N/A' and not url.startswith('http'):
                url = 'https://finance.yahoo.com' + url
            pub_tag = article.find('div', class_='publishing yf-1weyqlp')
            pub_time = pub_tag.text.split('•')[1].strip() if pub_tag and '•' in pub_tag.text else 'N/A'
            absolute_time = parse_relative_time(pub_time, reference_time)
            ticker_tags = article.find_all('a', class_='ticker x-small hover2 border has-follow streaming yf-1jsynna')
            tickers = [ticker.find('span', class_='symbol yf-1jsynna').text.strip() for ticker in ticker_tags if ticker.find('span', class_='symbol yf-1jsynna')] if ticker_tags else []
            if absolute_time != 'N/A':
                try:
                    article_date = datetime.strptime(absolute_time, '%Y-%m-%d %H:%M:%S')
                    if article_date < cutoff_date:
                        continue
                except ValueError as ve:
                    logging.error(f"Date parsing error: {ve}")
            article_data.append({
                'title': title,
                'url': url,
                'relative_time': pub_time,
                'absolute_time': absolute_time,
                'tickers': ', '.join(tickers) if tickers else 'N/A'
            })
            logging.info(f"Parsed article {idx+1}: {title}")
        filtered_articles = [
            article for article in article_data
            if article['absolute_time'] != 'N/A' and
            datetime.strptime(article['absolute_time'], '%Y-%m-%d %H:%M:%S') >= cutoff_date
        ] if article_data else []
        logging.info(f"Total articles after filtering: {len(filtered_articles)}")
        return filtered_articles
    except Exception as e:
        logging.error(f"Error parsing page: {e}")
        return []

def save_to_sqlite(data, db_name, table_name):
    logging.info(f"Saving data to SQLite DB: {db_name}, Table: {table_name}")
    try:
        conn = sqlite3.connect(db_name)
        cursor = conn.cursor()
        cursor.execute(f'''
            CREATE TABLE IF NOT EXISTS {table_name} (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                title TEXT,
                url TEXT,
                relative_time TEXT,
                absolute_time TEXT
            )
        ''')
        for idx, article in enumerate(data):
            cursor.execute(f'''
                INSERT INTO {table_name} (title, url, relative_time, absolute_time)
                VALUES (?, ?, ?, ?)
            ''', (
                article['title'], article['url'],
                article['relative_time'], article['absolute_time']
            ))
            logging.info(f"Inserted article {idx+1}: {article['title']}")
        conn.commit()
        conn.close()
        logging.info(f"Saved {len(data)} articles to SQLite DB: {db_name}")
    except Exception as e:
        logging.error(f"Failed to save to SQLite: {e}")

if __name__ == "__main__":
    ticker = "GC=F"
    logging.info("Script started")
    articles = crawl_gold_news()
    if articles:
        ts = datetime.now().strftime('%Y%m%d_%H%M%S')
        save_to_sqlite(articles, "yahoo_news.db", "gold_news")
    else:
        logging.info("No articles found to save.")
    logging.info("Script finished")
