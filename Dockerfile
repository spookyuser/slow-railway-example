# Stage 1. Get pydeps
FROM python:3.10.6

RUN useradd --create-home appuser
USER appuser
WORKDIR /home/appuser

RUN mkdir app
COPY requirements.txt app
COPY main.py app
WORKDIR app

RUN pip install -r requirements.txt --no-cache-dir

RUN python -c 'from sentence_transformers import SentenceTransformer; embedder = SentenceTransformer("all-mpnet-base-v2")' 

CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 main:app