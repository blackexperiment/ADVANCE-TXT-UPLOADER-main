# vars.py
# Do NOT store real tokens here. Use environment variables (Render dashboard / .env locally).

import os
import sys

def required_env(name: str) -> str:
    val = os.environ.get(name)
    if not val:
        print(f"[ERROR] Required environment variable {name} is not set.", file=sys.stderr)
        # Fail fast so the service won't start with missing creds
        raise SystemExit(1)
    return val

# Use required_env for critical secrets so container fails fast if not set.
API_ID = int(required_env("API_ID"))
API_HASH = required_env("API_HASH")
BOT_TOKEN = required_env("BOT_TOKEN")

# Optional: path to cookies file (default to repo path if provided)
COOKIES_FILE_PATH = os.environ.get("COOKIES_FILE_PATH", "youtube_cookies.txt")
