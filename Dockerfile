FROM python:3.10-slim-bullseye

# Install needed system packages
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
      gcc build-essential libffi-dev libssl-dev ffmpeg aria2 mediainfo \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install Python deps using cache-friendly layer
COPY requirements.txt /app/requirements.txt
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r /app/requirements.txt

# Copy rest of the source
COPY . /app

EXPOSE 8000
ENV COOKIES_FILE_PATH="youtube_cookies.txt"

# Start both web and bot; wait so container exits if any process fails
CMD bash -lc "PORT=${PORT:-8000}; echo running on $PORT; \
  gunicorn --workers 3 --bind 0.0.0.0:${PORT} app:app & \
  python3 main.py & \
  wait -n"
