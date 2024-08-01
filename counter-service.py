import os
from flask import Flask, request
import mysql.connector

app = Flask(__name__)

# Connect to DB
db_host = os.getenv("DB_HOST")
db_user = os.getenv("DB_USER")
db_password = os.getenv("DB_PASSWORD")
db_name = os.getenv("DB_NAME")

conn = mysql.connector.connect(
    host=db_host,
    user=db_user,
    password=db_password,
    db=db_name
)

# Create Table if it doesn't exist
with conn.cursor() as cursor:
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS global_count (
        ID enum('count') NOT NULL,
        count INT UNSIGNED DEFAULT '0',
        primary key(ID)
        )
    """)
    cursor.execute("INSERT IGNORE INTO global_count (ID) VALUES ('count')")
    conn.commit()
        
@app.route('/', methods=["POST", "GET"])
def index():
    if request.method == "POST":
        with conn.cursor() as cursor:
            cursor.execute("UPDATE global_count SET count = count + 1 WHERE ID = 'count'")
            conn.commit()
        return "Best counter in the world! "
    else:
        with conn.cursor() as cursor:
            conn.commit()
            cursor.execute("SELECT count FROM global_count")
            return str(f"Our counter is: {cursor.fetchone()[0]} ")
if __name__ == '__main__':
    app.run(debug=True,port=80,host='0.0.0.0')
