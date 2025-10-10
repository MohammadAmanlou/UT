import pandas as pd

# Load stock data
df_prices = pd.read_csv("gold_ohlcv_2020_2025.csv")
df_prices["Date"] = pd.to_datetime(df_prices["Date"]).dt.date  # normalize

# Load cluster data
df_clusters = pd.read_csv("news_clusters_by_day.csv")
df_clusters["date"] = pd.to_datetime(df_clusters["date"]).dt.date  # normalize

# Restrict stock data to the range of the cluster dataset
min_date, max_date = df_clusters["date"].min(), df_clusters["date"].max()
df_prices = df_prices[(df_prices["Date"] >= min_date) & (df_prices["Date"] <= max_date)]

# Merge on date
df_merged = pd.merge(df_prices, df_clusters, left_on="Date", right_on="date", how="inner")

# Drop duplicate date column
df_merged = df_merged.drop(columns=["date"])

# Save merged CSV
output_path = "merged_prices_clusters.csv"
df_merged.to_csv(output_path, index=False)

print(f"Saved: {output_path}  (range {min_date} → {max_date})")
