from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.common.exceptions import TimeoutException, NoSuchElementException
import csv
from datetime import date, timedelta
import time

def daterange(start_date, end_date):
    for n in range((end_date - start_date).days + 1):
        yield start_date + timedelta(n)

def scrape_links_for_date(driver, day):
    url = f"https://financialpost.com/sitemap/{day.year}-{day.month}-{day.day}/"
    print(f"Processing: {url}")
    try:
        driver.get(url)
        time.sleep(2)  # Wait for the page to load, adjust if needed

        links = []
        ul = driver.find_element(By.CLASS_NAME, "sitemap-results-list")
        items = ul.find_elements(By.TAG_NAME, "li")

        for li in items:
            a = li.find_element(By.TAG_NAME, "a")
            href = a.get_attribute("href")
            if href:
                links.append((str(day), href))

        return links

    except (NoSuchElementException, TimeoutException):
        print(f"No sitemap or error on: {url}")
        return []
    except Exception as e:
        print(f"Error processing {url}: {e}")
        return []

if __name__ == "__main__":
    options = Options()
    # options.add_argument("--headless")  
    options.add_argument("--disable-gpu")
    options.add_argument("--log-level=3")  
    driver = webdriver.Chrome(options=options) 

    start_date = date(2020, 1, 1)
    end_date = date(2025, 7, 30)
    output_file = "financialpost_sitemap_links.csv"

    with open(output_file, "w", newline='', encoding='utf-8') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(["date", "link"])
        for single_date in daterange(start_date, end_date):
            links = scrape_links_for_date(driver, single_date)
            writer.writerows(links)

    driver.quit()
