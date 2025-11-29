from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Tushar'

# Health endpoint for Render (returns 200)
@app.route('/health')
def health():
    return "healthy", 200

if __name__ == "__main__":
    # Local run for debugging (not used by gunicorn in Render)
    app.run(host="0.0.0.0", port=int(__import__("os").environ.get("PORT", 8000)))
