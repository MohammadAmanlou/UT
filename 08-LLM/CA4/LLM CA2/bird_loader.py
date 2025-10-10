import json
import os
import sqlite3
import pandas as pd

def dict_factory(cursor, row):
    d = {}
    for idx, col in enumerate(cursor.description):
        d[col[0]] = row[idx]
    return d

def read_bird(file_path="dev/dev_tables.json", descriptions_path="dev/dev_databases/dev_databases"):


    with open(file_path, 'r') as file:
            data = json.load(file)

    available_dbs = os.listdir(descriptions_path)
    available_dbs = [os.path.basename(db) for db in available_dbs]
    schema = {}
    for db in data:
        db_id = db['db_id']
        table_names = db['table_names']
        column_names = db['column_names']
        column_types = db['column_types']
        primary_keys = db['primary_keys']
        foreign_keys = db['foreign_keys']
        table_names_original = db['table_names_original']
        column_names_original = db['column_names_original']

        if db_id not in available_dbs:
            continue

        current_db = {
            "db_id": db_id,
            "table_names": table_names,
            "column_names": column_names,
            "column_types": column_types,
            "primary_keys": primary_keys,
            "foreign_keys": foreign_keys,
            "table_names_original": table_names_original,
            "column_names_original": column_names_original
        }
        

        current_description_path = os.path.join(descriptions_path, db_id, "database_description")
        current_sqlite_path = os.path.join(descriptions_path, db_id, f"{db_id}.sqlite")
        
        conn = sqlite3.connect(current_sqlite_path)
        conn.row_factory = dict_factory 

        cursor = conn.cursor()

        table_column_descriptions = {}
        table_heads = {}
        for table in table_names_original:
            quoted_table = f'"{table}"' if table == "order" else table
            cursor.execute(f"SELECT * FROM {quoted_table} LIMIT 5")

            rows = cursor.fetchall()
            column_names = rows[0].keys()
            table_head = []
            for row in rows:
                table_head.append({col: row[col] for col in column_names})
            table_head = {col: [str(row[col])[:50] for row in table_head] for col in column_names}
            table_heads[table] = table_head
            table_description_path = os.path.join(current_description_path, table + ".csv")
            current_table_description = {}

            if os.path.exists(table_description_path):
                df = pd.read_csv(table_description_path, encoding='windows-1252')
                df.columns = df.columns.str.replace('ï»¿', '')
                current_table_description = {item["original_column_name"]:item for item in df.to_dict(orient='records')}

            else:
                print(f"File not found: {table_description_path}")
            table_column_descriptions[table] = current_table_description
            table_heads[table] = table_head
        current_db["table_column_descriptions"] = table_column_descriptions
        current_db["table_heads"] = table_heads
        schema[db_id] = current_db
    return schema
