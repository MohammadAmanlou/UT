from langchain_core.tools import tool
from langchain_core.runnables import RunnableConfig
import pandas as pd
import os
from dotenv import load_dotenv
from langchain_community.tools import DuckDuckGoSearchResults
from openai import OpenAI


@tool
def get_date_important_news_topics(date: str, config:RunnableConfig):
    """Provides the top 7 most important news topics for the given date.
    Args:
        date: The date to get the important news from in format YYYY-MM-DD
    Returns:
        A string containing the top 7 important news of the day, cleaned and summarized.
    """
    os.environ["OPENAI_API_KEY"] = os.getenv("AVVALAI_API_KEY")


    client =  config["configurable"].get("client")
    csv_path = config["configurable"].get("news_path")
    df = pd.read_csv(csv_path)

    matching_rows = df[df['date'] == date]
    if matching_rows.empty:
        return f"No news found for {date}"

    news_texts = []
    matching_rows = df[df['date'] == date].head(100)

    for _, row in matching_rows.iterrows():
        news_texts.append(f"Text: {row['news_text']}\n")

    all_news_text = "\n\n".join(news_texts)
    prompt = f"""
        You are given a list of news articles for {date}. 
        Your task:
        1. Identify the 7 most important and most related news articles that will globaly effect the stock market prices.  
        2. Return them as a list.  
        3. Remove unnecessary/irrelevant parts of each article, keeping the essential information.  
        4. Preserve the full meaning of each article (not just headlines).  

        News articles:
        {all_news_text}

        Now, provide the cleaned list of the top 7 most important news articles:
        """

    response = client.chat.completions.create(
        model="gemini-2.0-flash-001",
        messages=[
            {
                "role": "user",
                "content": prompt,
            },
        ],
    )
    return response.choices[0].message.content



@tool
def search_web__for_news_topic(news_topic:str, config:RunnableConfig):
    """Searches for recent news related to a news_topic and returns the top result.
        Args:
            news_topic: generated news topic  
        Returns:
            A string containing the content of the search news.
    
    """
    search = DuckDuckGoSearchResults(backend="news", output_format="list", max_results=1)
    results = search.run(news_topic)

    if not results:
        return "No search results found."

    top_result = results[0]
    return f"{top_result['title']}\n{top_result['link']}"



