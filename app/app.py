from flask import Flask, jsonify
import os
import psycopg2

app = Flask(__name__)

def get_db_connection():
    database_url = os.getenv("DATABASE_URL")
    if not database_url:
        return None
    return psycopg2.connect(database_url)

@app.route("/")
def home():
    return "Hello from Flask on Render!"

@app.route("/info")
def info():
    return {
        "app": "Flask Render",
        "student": "Nicolas Zekri",
        "version": "v1"
    }

@app.route("/env")
def env():
    return {"env": os.getenv("ENV")}

@app.route("/db-test")
def db_test():
    try:
        conn = get_db_connection()
        if conn is None:
            return jsonify({"error": "DATABASE_URL not set"}), 500

        cur = conn.cursor()
        cur.execute("SELECT version();")
        version = cur.fetchone()[0]
        cur.close()
        conn.close()

        return jsonify({"database": "connected", "version": version})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    port = int(os.getenv("PORT", 5000))
    app.run(host="0.0.0.0", port=port)
