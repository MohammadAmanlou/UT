import sqlite3
import pandas as pd



db_name = "yahoo_news2.db"
table_name = "gold_news"  # Table name is lowercase based on how it's saved in your script

conn = sqlite3.connect(db_name)
query = f"""
    SELECT * FROM {table_name}
    ORDER BY id DESC
    LIMIT 10
"""
df = pd.read_sql_query(query, conn)
conn.close()

print(df)