import json
import pandas as pd

with open("clusters.json", "r", encoding="utf-8") as f:
    valid_topics = set(json.load(f))  

with open("clustered_news.json", "r", encoding="utf-8") as f:
    news = json.load(f)  

date_topic_dict = {}

for item in news:
    date = item["date"]
    clusters = item.get("assigned_clusters", [])
    matched = [c for c in clusters if c in valid_topics]
    if not matched:
        continue  # Skip if none match
    if date not in date_topic_dict:
        date_topic_dict[date] = set()
    date_topic_dict[date].update(matched)

df = pd.DataFrame(0, index=sorted(date_topic_dict.keys()), columns=sorted(valid_topics))

# Fill in 1s for matched topics
for date, topics in date_topic_dict.items():
    for topic in topics:
        df.at[date, topic] = 1

df.reset_index(inplace=True)
df.rename(columns={"index": "date"}, inplace=True)

df.to_csv("topics_by_date.csv", index=False)

print("Saved to topics_by_date.csv")
