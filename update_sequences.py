import psycopg2
from psycopg2 import sql
import os
from osdag_web.postgres_credentials import get_database_name, get_host, get_password, get_port, get_username

#########################################################
# Author : Atharva Pingale ( FOSSEE Summer Fellow '23 ) #
#########################################################

# Get database credentials from settings
DATABASE_NAME = get_database_name()
USER = get_username()
PASSWORD = get_password()
PORT = get_port()
HOST = get_host()

try:
    # Connect to the database
    conn = psycopg2.connect(
        database=DATABASE_NAME,
        host=HOST,
        user=USER,
        password=PASSWORD,
        port=PORT
    )
    conn.autocommit = True
    cursor = conn.cursor()
    
    # Load SQL file
    sql_file_path = "ResourceFiles/Database/update_sequences.sql"
    if os.path.exists(sql_file_path):
        with open(sql_file_path, "r") as file:
            print(f"Executing SQL from {sql_file_path}...")
            data = file.read()
            cursor.execute(data)
            print('SUCCESS: Sequences Updated')
    else:
        print(f"Error: SQL file not found at {sql_file_path}")
    
    cursor.close()
    conn.close()

except Exception as e:
    print(f"Error: {e}")
