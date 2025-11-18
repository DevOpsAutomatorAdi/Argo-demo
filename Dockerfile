# ---------------------------
# 1) Base Image
# ---------------------------
FROM python:3.10-slim

# ---------------------------
# 2) Set working directory
# ---------------------------
WORKDIR /app

# ---------------------------
# 3) Install system dependencies
# ---------------------------
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# ---------------------------
# 4) Copy project files
# ---------------------------
COPY . /app

# ---------------------------
# 5) Install dependencies
# ---------------------------
RUN pip install --no-cache-dir -r requirements.txt

# ---------------------------
# 6) Expose port
# ---------------------------
EXPOSE 8000

# ---------------------------
# 7) Django collectstatic (optional)
# ---------------------------
RUN python manage.py collectstatic --noinput || true

# ---------------------------
# 8) Start Django server
# ---------------------------
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

