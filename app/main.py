from flask import Flask
from flask import jsonify

app = Flask(__name__)


@app.get("/health")
def health():
    return jsonify({"healthy": True})
