import sqlite3

from bird_loader import read_bird

class DBManager:
    def __init__(self) -> None:
        self.db_paths = {
            "student_club": "data/dev_databases/student_club/student_club.sqlite",
            "superhero": "data/dev_databases/superhero/superhero.sqlite",
            "toxicology": "data/dev_databases/toxicology/toxicology.sqlite"
        }

        self.connections = {}
        self.cursors = {}
        self.bird_schema = read_bird(file_path="data/tables.json", descriptions_path="data/dev_databases")
        self.add_connection("student_club", "data/dev_databases/student_club/student_club.sqlite")
        self.add_connection("superhero", "data/dev_databases/superhero/superhero.sqlite")
        self.add_connection("toxicology", "data/dev_databases/toxicology/toxicology.sqlite")
        
    def is_connected(self, db_name: str):
        return db_name in self.connections

    def add_connection(self, db_name: str, db_path: str):
        if self.is_connected(db_name):
            raise ValueError(f"Connection to {db_name} already exists.")
        conn = sqlite3.connect(db_path)
        # conn.row_factory = sqlite3.Row
        conn.row_factory = dict_factory
        self.connections[db_name] = conn
        self.cursors[db_name] = conn.cursor()
        return conn

    def get_database_list(self):
        """Get a list of all connected databases."""
        return list(self.connections.keys())

    def query(self, query: str, db_name: str):
        """Execute a query on the specified database and return the result."""
        if db_name not in self.db_paths:
            raise ValueError(f"No path found for database: {db_name}")
        try:
            conn = sqlite3.connect(self.db_paths[db_name])
            conn.row_factory = dict_factory
            cursor = conn.cursor()
            cursor.execute(query)
            result = cursor.fetchall()
        except Exception as e:
            result = f"Error executing query: {query} on database: {db_name}. Error: {e}"
        finally:
            conn.close()
        return result
    
    def get_tables(self, db_name: str):
        """Get a list of all tables in the specified database."""
        query = "SELECT name FROM sqlite_master WHERE type='table';"
        return [row["name"] for row in self.query(query, db_name)]
    
    def get_table_columns(self, table_name: str, db_name: str):
        """Get a list of all columns in the specified table."""
        query = f"PRAGMA table_info({table_name});"
        return [row["name"] for row in self.query(query, db_name)]
    
    def get_column_description(self, db_name: str, table_name: str, column_name: str):
        """Get the description of a specific column in a table."""
        if db_name not in self.bird_schema:
            raise ValueError(f"No schema found for database: {db_name}")
        if table_name not in self.bird_schema[db_name]["table_names_original"]:
            raise ValueError(f"No schema found for table: {table_name} in database: {db_name}")
        if column_name not in self.bird_schema[db_name]["table_column_descriptions"][table_name]:
            raise ValueError(f"No schema found for column: {column_name} in table: {table_name} of database: {db_name}")
        return self.bird_schema[db_name]["table_column_descriptions"][table_name][column_name]
    
    def get_schema(self, db_name: str):
        """Get the schema of the specified database."""
        tables = self.get_tables(db_name)
        schema = ""
        for table in tables:
            columns = self.get_table_columns(table, db_name)
            schema += f"{table} ({', '.join(columns)})\n"
        return schema
    
    def get_db_head(self, db_name: str):
        """Get the head of the specified database."""
        tables = self.get_tables(db_name)
        head = ""
        for table in tables:
            columns = self.get_table_columns(table, db_name)
            head += f'Table Name: "{table}"\n'
            head += f'Columns Name: ({", ".join([f"{col}" for col in columns])})\n'
            

            
            query = f"SELECT * FROM {table} LIMIT 1"
            current = self.query(query, db_name)
            if current:
                row_values = ", ".join([str(value) for value in current[0].values()])
                head += f'First Row Values: ({row_values})\n'
        return head
    
    def get_table_head(self, table_name: str, db_name: str):
        """Get the head of the specified table."""
        columns = self.get_table_columns(table_name, db_name)
        head = f'Table Name: "{table_name}"\n'
        head += f'Columns Name: ({", ".join([f"{col}" for col in columns])})\n'

        query = f"SELECT * FROM {table_name} LIMIT 5"
        current = self.query(query, db_name)
        if current:
            for row in current:
                row_values = ", ".join([str(value) for value in row.values()])
                head += f'Row Values: ({row_values})\n'
        return head

def dict_factory(cursor, row):
    d = {}
    for idx, col in enumerate(cursor.description):
        d[col[0]] = row[idx]
    return d

if __name__ == "__main__":
    db_manager = DBManager()

    # Example Usage:
    # print(db.get_tables())
    # print(db.get_schema())
    # print(db.get_table_columns(db.get_tables()[0]))
    # print(db.get_db_head())
    # db_manager.add_connection("california_schools", "minidev/dev_databases/california_schools/california_schools.sqlite")
    # db_manager.add_connection("card_games", "minidev/dev_databases/card_games/card_games.sqlite")
    # db_manager.add_connection("codebase_community", "minidev/dev_databases/codebase_community/codebase_community.sqlite")
    # db_manager.add_connection("debit_card_specializing", "minidev/dev_databases/debit_card_specializing/debit_card_specializing.sqlite")
    # db_manager.add_connection("european_football_2", "minidev/dev_databases/european_football_2/european_football_2.sqlite")
    # db_manager.add_connection("financial", "minidev/dev_databases/financial/financial.sqlite")
    # db_manager.add_connection("formula_1", "minidev/dev_databases/formula_1/formula_1.sqlite")
    # db_manager.add_connection("student_club", "minidev/dev_databases/student_club/student_club.sqlite")
    # db_manager.add_connection("superhero", "minidev/dev_databases/superhero/superhero.sqlite")
    # db_manager.add_connection("toxicology", "minidev/dev_databases/toxicology/toxicology.sqlite")
    # db_manager.add_connection("thrombosis_prediction", "minidev/dev_databases/thrombosis_prediction/thrombosis_prediction.sqlite")

    print(list(db_manager.query("SELECT count(*) FROM superhero", "superhero"))[0])
    print(db_manager.get_tables("superhero"))
    print(db_manager.get_schema("superhero"))
    print(db_manager.get_table_columns("superhero", "superhero"))
    print(db_manager.get_db_head("superhero"))
    print("-" * 25)
    print(db_manager.get_table_head("superhero", "superhero"))
    print("-" * 25)
    print(db_manager.get_database_list())
    print("-" * 25)
    print(db_manager.query("SELECT count(*) FROM Super_hero", "superhero"))
    print("-" * 25)
    print(db_manager.query("SELECT * FROM superhero", "superhero")[:5])
    print("-" * 25)
    print(db_manager.get_column_description("superhero", "superhero", "full_name"))
    print("-" * 25)
    print(db_manager.get_table_head("connected", "toxicology"))
    