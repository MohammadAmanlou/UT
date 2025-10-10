import sqlite3
import requests
from bs4 import BeautifulSoup
from tqdm import tqdm
import re

POLITICS_KEYWORDS = [
    "government", "election", "policy", "war", "diplomacy", "president", "parliament",
    "legislation", "sanctions", "protest", "conflict", "trade", "international relations",
    "budget", "geopolitical", "stability", "crisis", "negotiations", "summit", "treaty",
    "security", "defense", "military", "arms", "terrorism", "human rights", "justice",
    "corruption", "democracy", "authoritarianism", "coup", "revolution", "political party",
    "candidate", "voting", "public opinion", "polls", "referendum", "constitution",
    "supreme court", "legislative", "executive", "judicial", "foreign affairs",
    "domestic affairs", "public policy", "social policy", "healthcare", "education",
    "environment", "climate change", "energy", "infrastructure", "urbanization",
    "rural development", "poverty", "inequality", "minimum wage", "taxation", "tariffs",
    "subsidies", "regulation", "deregulation", "national security", "intelligence",
    "espionage", "cyber security", "propaganda", "disinformation", "censorship",
    "freedom of speech", "civil liberties", "civil rights", "police", "crime",
    "law enforcement", "judicial system", "prison", "capital punishment", "immigration",
    "refugee", "border control", "foreign aid", "humanitarian", "peacekeeping",
    "intervention", "sovereignty", "nationalism", "globalism", "multilateralism",
    "bilateralism", "regional blocs", "alliances", "adversaries", "rivals", "cooperation",
    "competition", "conflict resolution", "peace process", "arms control", "non-proliferation",
    "disarmament", "ambassador", "embassy", "consulate", "foreign minister", "secretary of state",
    "prime minister", "chancellor", "monarch", "emperor", "vice president", "governor",
    "mayor", "city council", "congress", "senate", "house of representatives", "assembly",
    "legislature", "bureaucracy", "civil service", "public administration", "public sector",
    "private sector", "non-governmental organization", "civil society", "advocacy group",
    "lobby", "think tank", "academia", "media", "press", "journalism", "public relations",
    "communication", "social media", "internet", "technology", "innovation", "research and development",
    "science policy", "education reform", "healthcare reform", "social security", "welfare",
    "retirement", "pension", "labor unions", "strikes", "demonstrations", "riots", "civil unrest",
    "political violence", "insurgency", "counter-insurgency", "guerrilla warfare", "civil war",
    "coup d'état", "state of emergency", "martial law", "human rights violations", "genocide",
    "war crimes", "crimes against humanity", "international law", "international criminal court",
    "united nations", "nato", "european union", "african union", "asean", "bric", "g7", "g20",
    "world bank", "imf", "wto", "opec", "world health organization", "unesco", "unicef", "unhcr",
    "unodc", "unep", "undp", "unops"
]

# Keywords for Gold Market Forecasting
GOLD_FORECASTING_KEYWORDS = [
    "gold", "price", "market", "investment", "inflation", "interest rates", "central bank",
    "federal reserve", "recession", "dollar", "currency", "economy", "commodity", "finance",
    "stock market", "bond market", "safe haven", "demand", "supply", "mining", "reserves",
    "geopolitical", "crisis", "uncertainty", "volatility", "treasury", "yield",
    "real interest rates", "monetary policy", "fiscal policy", "quantitative easing", "tapering",
    "hawk", "dove", "employment", "GDP", "CPI", "PPI", "trade war", "tariffs", "sanctions",
    "geopolitical risk", "political instability", "war", "conflict", "pandemic", "black swan",
    "economic indicators", "technical analysis", "fundamental analysis", "futures", "options",
    "hedging", "speculation", "bullion", "jewelry", "industrial demand", "central bank buying",
    "sovereign wealth funds", "ETFs", "mutual funds", "physical gold", "digital gold",
    "cryptocurrency", "blockchain", "inflation hedge", "wealth preservation", "deflation",
    "stagflation", "economic growth", "consumer spending", "manufacturing", "services",
    "global trade", "supply chain", "energy prices", "oil", "gas", "precious metals",
    "silver", "platinum", "palladium", "mining stocks", "gold stocks", "inflation expectations",
    "yield curve", "bond yields", "real yields", "equity market", "credit market", "foreign exchange",
    "forex", "exchange rates", "trade balance", "current account", "budget deficit", "national debt",
    "government spending", "taxation", "regulatory environment", "environmental regulations",
    "labor market", "wages", "consumer confidence", "business confidence", "housing market",
    "construction", "retail sales", "exports", "imports", "manufacturing PMI", "services PMI",
    "unemployment rate", "non-farm payrolls", "jobless claims", "average hourly earnings",
    "consumer credit", "industrial production", "capacity utilization", "business inventories",
    "durable goods orders", "new home sales", "existing home sales", "building permits",
    "personal income", "personal consumption expenditures", "core PCE", "producer price index",
    "consumer price index", "inflation rate", "deflation rate", "interest rate hike",
    "interest rate cut", "quantitative tightening", "central bank balance sheet", "fiscal stimulus",
    "austerity", "trade agreements", "trade disputes", "protectionism", "free trade",
    "global warming", "natural disasters", "climate change", "energy transition",
    "supply disruptions", "port congestion", "shipping costs", "raw materials", "commodities index",
    "futures contracts", "options contracts", "derivatives", "short selling", "long position",
    "arbitrage", "market sentiment", "investor confidence", "fear index", "greed index",
    "gold standard", "Bretton Woods", "fiat currency", "debt ceiling", "government shutdown",
    "political polarization", "social unrest", "civil unrest", "election results",
    "electoral uncertainty", "presidential election", "parliamentary election", "referendum",
    "policy changes", "regulatory changes", "capital controls", "foreign investment",
    "foreign aid", "international cooperation", "trade blocs", "alliances", "conflicts",
    "sanctions", "embargoes", "terrorism", "cyberattacks", "military spending", "defense budgets",
    "disarmament", "nuclear weapons", "arms race", "regional tensions", "border disputes",
    "maritime disputes", "territorial claims", "energy security", "food security",
    "water security", "pandemic preparedness", "public health crisis", "vaccine development",
    "treatment options", "lockdowns", "travel restrictions", "supply chain resilience",
    "reshoring", "nearshoring", "economic decoupling", "deglobalization", "multilateral institutions",
    "international organizations", "IMF", "World Bank", "WTO", "UN", "G7", "G20", "BRICS",
    "OPEC", "NATO", "EU", "APEC", "ASEAN", "NAFTA", "USMCA", "TPP", "RCEP", "Iran"
]

ALL_KEYWORDS = list(set(POLITICS_KEYWORDS + GOLD_FORECASTING_KEYWORDS))


def init_filtered_news_database(db_name="gdelt_data.db", table_name="filtered_news"):
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
    return conn

def get_news_content(url, timeout=10):
    """
    Fetches the content of a given URL and extracts main text.
    Returns None if an error occurs or content is not found.
    """
    try:
        headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
        }
        response = requests.get(url, headers=headers, timeout=timeout)
        response.raise_for_status() # Raise an HTTPError for bad responses (4xx or 5xx)

        soup = BeautifulSoup(response.text, 'html.parser')

        # Try to extract common elements where news content resides
        paragraphs = soup.find_all('p')
        main_text = ' '.join([p.get_text() for p in paragraphs])

        # Fallback for some sites: try to find common news article body elements
        if not main_text:
            body_divs = soup.find_all('div', class_=re.compile(r'(body|content|article|main)', re.IGNORECASE))
            main_text = ' '.join([div.get_text() for div in body_divs])

        return main_text.strip() if main_text else None

    except requests.exceptions.RequestException as e:
        print(f"  Error fetching {url}: {e}")
        return None
    except Exception as e:
        print(f"  Error parsing {url}: {e}")
        return None

def filter_and_save_news(db_name="gdelt_data.db", raw_table="raw_news", filtered_table="filtered_news", keywords=ALL_KEYWORDS):
    """
    Reads URLs from raw_table, fetches their content, filters based on keywords,
    and saves matching news to filtered_table.
    """
    conn_raw = sqlite3.connect(db_name)
    cursor_raw = conn_raw.cursor()

    conn_filtered = init_filtered_news_database(db_name, filtered_table)
    cursor_filtered = conn_filtered.cursor()

    cursor_raw.execute(f"SELECT date, url FROM {raw_table}")
    all_raw_news = cursor_raw.fetchall()

    print(f"\nStarting to filter {len(all_raw_news)} raw news URLs...")
    processed_count = 0
    filtered_count = 0
    failed_to_fetch_count = 0

    for news_date, news_url in tqdm(all_raw_news, desc="Filtering news articles"):
        content = get_news_content(news_url)
        processed_count += 1
        if content:
            found_keywords = []
            content_lower = content.lower()
            for keyword in keywords:
                if keyword.lower() in content_lower:
                    found_keywords.append(keyword)

            if found_keywords:
                matched_keywords_str = ", ".join(sorted(list(set(found_keywords)))) # Store unique matched keywords
                try:
                    cursor_filtered.execute(f'''
                        INSERT OR IGNORE INTO {filtered_table} (date, url, matched_keywords)
                        VALUES (?, ?, ?)
                    ''', (news_date, news_url, matched_keywords_str))
                    filtered_count += 1
                except sqlite3.Error as e:
                    print(f"Error saving filtered news to DB for {news_url}: {e}")
            
        else:
            failed_to_fetch_count += 1
            # print(f"Could not fetch or parse content for URL: {news_url}")

        # Commit periodically to avoid large transactions and losing data on crash
        if processed_count % 100 == 0:
            conn_filtered.commit()
            # print(f"Processed {processed_count} URLs. Filtered: {filtered_count}")

    conn_filtered.commit()
    conn_raw.close()
    conn_filtered.close()

    print(f"\nFiltering complete!")
    print(f"Total URLs processed: {processed_count}")
    print(f"Successfully filtered and saved: {filtered_count} URLs to '{filtered_table}' table.")
    print(f"Failed to fetch/parse content for: {failed_to_fetch_count} URLs.")

    # Optional: Display content from filtered_news table
    conn_display = sqlite3.connect(db_name)
    cursor_display = conn_display.cursor()
    cursor_display.execute(f"SELECT COUNT(*) FROM {filtered_table}")
    count = cursor_display.fetchone()[0]
    print(f"Total records in '{filtered_table}' table: {count}")
    conn_display.close()



if __name__ == "__main__":
    print(f"\n--- Starting News Filtering based on Keywords ---")
    filter_and_save_news("gdelt_data.db", "raw_news", "filtered_news", ALL_KEYWORDS)
    print("--- News Filtering Complete ---")


