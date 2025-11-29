FROM python:3.10-slim-buster

# Install system deps used by the project
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
       gcc \
       build-essential \
       libffi-dev \
       libssl-dev \
       ffmpeg \
       aria2 \
       mediainfo \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app

# Make sure essential python packages are installed in requirements.txt
# If pytube or others are missing, add them to requirements.txt instead of separate pip call
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Optional: expose port for local clarity
EXPOSE 8000

ENV COOKIES_FILE_PATH="youtube_cookies.txt"

# Single-container minimal entry: start gunicorn bound to $PORT and run bot
CMD bash -lc "PORT=${PORT:-8000}; echo running on $PORT; gunicorn --workers 3 --bind 0.0.0.0:${PORT} app:app & python3 main.py"
