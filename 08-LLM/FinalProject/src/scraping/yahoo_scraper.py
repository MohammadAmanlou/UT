import requests
from bs4 import BeautifulSoup
import time
import pandas as pd
from datetime import datetime
from dateutil.relativedelta import relativedelta
from utils import parse_relative_time
import sqlite3
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')

# File handler
file_handler = logging.FileHandler('news_crawler.log')
file_handler.setFormatter(formatter)
logger.addHandler(file_handler)

# Console (stream) handler
stream_handler = logging.StreamHandler()
stream_handler.setFormatter(formatter)
logger.addHandler(stream_handler)

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
}


def crawl_yahoo_finance_latest(url):
    try:
        response = requests.get(url, headers=headers)
        response.raise_for_status() 
        soup = BeautifulSoup(response.text, 'html.parser')
        hero_section = soup.find('div', class_='hero-headlines hero-second-col yf-36pijq')
        if not hero_section:
            return []
        articles = hero_section.find_all('li', class_='story-item headlineFz-small yf-36pijq')
        reference_time = datetime.now()
        article_data = []
        for article in articles:
            title_tag = article.find('h3', class_='clamp tw-line-clamp-none yf-1jsv3x8')
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
            article_data.append({
                'title': title,
                'url': url,
                'publication_time': pub_time,
                'absolute_time': absolute_time,
                'tickers': ', '.join(tickers) if tickers else 'N/A'
            })
        return article_data
    except requests.RequestException as e:
        print(f"Error fetching page: {e}")
        return []
    except Exception as e:
        print(f"Error parsing page: {e}")
        return []

def crawl_gold_news(url, months=12):
    try:
        cutoff_date = datetime.now() - relativedelta(months=months)
        article_data = []
        page = 1
        while True:
            page_url = f"{url}?p={page}" if page > 1 else url
            response = requests.get(page_url, headers=headers)
            response.raise_for_status()
            soup = BeautifulSoup(response.text, 'html.parser')
            news_stream = soup.find('div', class_='news-stream yf-1napat3')
            if not news_stream:
                break
            articles = news_stream.find_all('li', class_='stream-item story-item yf-1drgw5l')
            if not articles:
                break
            reference_time = datetime.now()
            page_has_older_articles = False
            for article in articles:
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
                            page_has_older_articles = True
                            break
                    except ValueError:
                        pass
                article_data.append({
                    'title': title,
                    'url': url,
                    'publication_time': pub_time,
                    'absolute_time': absolute_time,
                    'tickers': ', '.join(tickers) if tickers else 'N/A'
                })
            if page_has_older_articles:
                break
            page += 1
            time.sleep(2)
        filtered_articles = [
            article for article in article_data
            if article['absolute_time'] != 'N/A' and
            datetime.strptime(article['absolute_time'], '%Y-%m-%d %H:%M:%S') >= cutoff_date
        ] if article_data else []
        return filtered_articles
    except requests.RequestException as e:
        print(f"Error fetching page: {e}")
        return []
    except Exception as e:
        print(f"Error parsing page: {e}")
        return []



def save_to_sqlite(data, db_name, table_name):
    conn = sqlite3.connect(db_name)
    cursor = conn.cursor()
    
    cursor.execute(f'''
        CREATE TABLE IF NOT EXISTS {table_name} (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            url TEXT,
            publication_time TEXT,
            absolute_time TEXT,
            tickers TEXT
        )
    ''')
    
    for article in data:
        cursor.execute(f'''
            INSERT INTO {table_name} (title, url, publication_time, absolute_time, tickers)
            VALUES (?, ?, ?, ?, ?)
        ''', (
            article['title'],
            article['url'],
            article['publication_time'],
            article['absolute_time'],
            article['tickers']
        ))

    conn.commit()
    conn.close()
    logging.info(f"Saved {len(data)} articles to {table_name} table in {db_name}")

def save_to_csv(data, filename):
    df = pd.DataFrame(data)
    df.to_csv(filename, index=False, encoding='utf-8')
    logging.info(f"Saved {len(data)} articles to {filename}")

def save_latest_news():
    url = 'https://finance.yahoo.com/'
    logging.info(f"Crawling {url}")
    articles = crawl_yahoo_finance_latest(url)
    if articles:
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        filename = f'yahoo_finance_hero_news_{timestamp}.csv'
        db_name = 'yahoo_finance_news.db'
        table_name = 'all_news'
        save_to_sqlite(articles, db_name, table_name)
    else:
        logging.warning("No articles found or an error occurred.")
    time.sleep(2)

def save_gold_news():
    gold_url = 'https://finance.yahoo.com/quote/GC=F/news/'
    logging.info(f"Crawling GOLD news from {gold_url}")
    gold_articles = crawl_gold_news(gold_url, months=6)
    if gold_articles:
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        db_name = 'yahoo_finance_news.db'
        table_name = 'gold_news'
        save_to_sqlite(gold_articles, db_name, table_name)
    else:
        logging.warning("No GOLD news articles found or an error occurred.")
    time.sleep(2)

if __name__ == '__main__':
    save_gold_news()
    save_latest_news()