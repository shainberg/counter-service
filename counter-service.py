import os
from flask import Flask, request
import pymysql

app = Flask(__name__)

# Connect to DB
db_host = os.getenv("DB_HOST")
db_user = os.getenv("DB_USER")
db_password = os.getenv("DB_PASSWORD")
db_name = os.getenv("DB_NAME")

conn = pymysql.connect(
    host=db_host,
    user=db_user,
    password=db_password,
    db=db_name
)

# Create Table if it doesn't exist
with conn.cursor() as cursor:
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS counter (
            id INT AUTO_INCREMENT PRIMARY KEY,
            count INT NOT NULL
        )
    """)
    cursor.execute("SELECT * FROM counter")
    if cursor.fetchone() is None:
        cursor.execute("INSERT INTO counter (count) VALUES (0)")
        conn.commit()
        
@app.route('/', methods=["POST", "GET"])
def index():
    if request.method == "POST":
        with conn.cursor() as cursor:
            cursor.execute("UPDATE counter SET count = count + 1 WHERE id = 1")
            conn.commit()
        return "Hmm, Plus 1 please "
    else:
        with conn.cursor() as cursor:
            cursor.execute("SELECT count FROM counter WHERE id = 1")
            return str(f"Our counter is: {cursor.fetchone()[0]} ")
if __name__ == '__main__':
    app.run(debug=True,port=80,host='0.0.0.0')
