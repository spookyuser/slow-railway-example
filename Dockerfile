# Stage 1. Get pydeps
FROM python:3.10.6

RUN mkdir /app
COPY requirements.txt /app
COPY main.py /app
WORKDIR /app

RUN pip install -r requirements.txt --no-cache-dir

CMD exec gunicorn --bind :$PORT --timeout 0 main:app