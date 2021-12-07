from flask import Flask
import requests
import json

app = Flask(__name__)

MY_PORT = 5000
OTHER_PORT = 5001
ROOT_DOMAIN = f"http://localhost:{OTHER_PORT}/"
API_ID = 1
API_VER = "1.0.0"


@app.route("/")
def home():
    return {
        "API": API_ID,
        "version": API_VER
    }, 200


@app.route("/api")
def api():
    return requests.get(ROOT_DOMAIN).json(), 200


@app.route("/health")
def health():
    return {
        "status": "Up!!"
    }, 200


if __name__ == "__main__":
    app.run(debug=True, port=MY_PORT)