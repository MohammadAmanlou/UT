import os
import json
import time
import pandas as pd
import re
from dotenv import load_dotenv
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from webdriver_manager.chrome import ChromeDriverManager
from openai import OpenAI
from tqdm import tqdm


load_dotenv()
API_KEY = os.getenv("AVVALAI_API_KEY")
os.environ["AVVALAI_API_KEY"] = API_KEY


system_prompt = """You are a news classification assistant. Your job is to assign a short news article to the most relevant topic cluster.

You will receive a list of existing topic clusters and a news article. You must:
1. Assign the article to one or more of the existing clusters if it's relevant.
2. If the article doesn't fit any current cluster, create new ones and assign the article to them.

Be concise and only return the result in the specified JSON format.
"""

def build_user_prompt(news_text, clusters):
    return f"""Here is the current list of topic clusters:
        {json.dumps(clusters, indent=2)}

        Here is the news article:
        \"\"\" 
        {news_text}
        \"\"\"

        Now, decide which clusters it belongs to. If none match, create new ones and assign the article to them.
        I want the clusters to be detailed especially in financial news — but not too specific. Aim for around 1000 clusters total for 200,000 news items.
        Title each cluster with 4–5 descriptive words. Dont create clusters with multiple subjects like "financial and econimics". Each cluster should focus on a single topic. Try as much as possible to use the existing clusters, but if the article is not relevant to any of them, create new clusters. DONT GO FOR NEW CLUSTERS UNLESS YOU ARE REALLY NEEDED.

        Return your response in this JSON format:
        {{
          "assigned_clusters": ["<cluster name 1>", "<cluster name 2>, ..."],
        }}
        Only return the JSON, no explanation or extra text.
    """


def update_clusters(initial_clusters_path, clusters, assigned_clusters):
    new_clusters_added = False
    for assigned_cluster in assigned_clusters:
        if assigned_cluster not in clusters:
            clusters.append(assigned_cluster)
            new_clusters_added = True
    if new_clusters_added:
        with open(initial_clusters_path, "w", encoding="utf-8") as f:
            json.dump(clusters, f, indent=2, ensure_ascii=False)
    return clusters

def append_to_json(json_path, date, link, clusters):
    new_entry = {
        "date": str(date),
        "link": link,
        "assigned_clusters": clusters
    }

    if os.path.exists(json_path):
        with open(json_path, "r", encoding="utf-8") as f:
            existing_data = json.load(f)
    else:
        existing_data = []

    existing_data.append(new_entry)

    with open(json_path, "w", encoding="utf-8") as f:
        json.dump(existing_data, f, indent=2, ensure_ascii=False)

def clean_json_response(raw_text):
    cleaned = re.sub(r"^```(?:json)?|```$", "", raw_text.strip(), flags=re.IGNORECASE)
    cleaned = cleaned.replace("\\n", "").replace("\\r", "").strip()
    return cleaned


if __name__ == "__main__":
    client = OpenAI(
        base_url="https://api.avalai.ir/v1",        
        api_key=API_KEY,
    )

    chrome_options = Options()
    # chrome_options.add_argument("--headless")
    chrome_options = Options()
    chrome_options.add_argument("--ignore-certificate-errors")   # Ignores invalid SSL certs
    chrome_options.add_argument("--log-level=3")                  # Suppress logs (3 = FATAL)
    chrome_options.add_argument("--disable-logging")              # Disable logging entirely
    chrome_options.add_argument("--disable-notifications")        # Optional: disables popups
    chrome_options.add_experimental_option("excludeSwitches", ["enable-logging"])  # Hides DevTools warnings
    # chrome_options.add_argument("--disable-gpu")
    chrome_options.add_argument("--no-sandbox")

    service = Service(ChromeDriverManager().install())
    driver = webdriver.Chrome(service=service, options=chrome_options)
    
    csv_path = "2023.csv"
    start_date = "2025-06-10"
    end_date = "2025-06-30"
    sample_per_day = 5
    initial_clusters_path = "clusters.json"
    clustered_news_path = "clustered_news.json"
    with open(initial_clusters_path, "r") as f:
        clusters = json.load(f)

    df = pd.read_csv(csv_path, parse_dates=["date"])
    df["date"] = pd.to_datetime(df["date"])

    start = pd.to_datetime(start_date)
    end = pd.to_datetime(end_date)
    date_range = pd.date_range(start=start, end=end)

    for single_date in tqdm(date_range, desc="Processing dates"):
        day_rows = df[df["date"] == single_date].head(20) 
        if day_rows.empty:
            continue

        for idx, row in day_rows.iterrows():
            link = row.get("link")
            if not link:
                continue

            try:
                driver.get(link)
                time.sleep(0.5)  # Wait for the page to load
                try:
                    title_elem = driver.find_element(By.XPATH, '//h1[@class="article-title" and @id="articleTitle"]')
                    title = title_elem.text.strip()
                except:
                    title = "No title found"

                paragraphs = driver.find_elements(By.TAG_NAME, "p")
                paragraph_texts = [p.text.strip() for p in paragraphs[:5]]
                news_text = f"{title}\n" + "\n".join(paragraph_texts)

                user_prompt = build_user_prompt(news_text, clusters)

                completion = client.chat.completions.create(
                    model="gpt-4o-mini-2024-07-18",
                    messages=[
                        {"role": "system", "content": system_prompt},
                        {"role": "user", "content": user_prompt}
                    ],
                    temperature=1,
                    max_tokens=100,
                    top_p=1,
                    stream=False
                )

                response_content = completion.choices[0].message.content
                result = json.loads(clean_json_response(response_content))
                assigned_clusters = result["assigned_clusters"]
                clusters = update_clusters(initial_clusters_path, clusters, assigned_clusters)
                append_to_json(clustered_news_path, single_date.date(), link, assigned_clusters)

            except Exception as e:
                print(f"Error processing {link}: {e}")

driver.quit()
