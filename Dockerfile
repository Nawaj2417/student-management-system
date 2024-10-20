# Set base image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set work directory
WORKDIR /app

# Install dependencies
COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install -r requirements.txt
RUN pip install gunicorn  # Ensure gunicorn is installed
# Copy project
COPY . /app/

# Collect static files
RUN python manage.py collectstatic --noinput

# Run Django server with Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "Home.wsgi:application"]

