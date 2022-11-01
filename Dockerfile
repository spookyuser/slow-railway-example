# Stage 1. Get pydeps
FROM python:3.10.6 as base

RUN mkdir /app
COPY requirements.txt /app
COPY main.py /app
WORKDIR /app

RUN pip install -r requirements.txt

RUN python -c 'from sentence_transformers import SentenceTransformer; embedder = SentenceTransformer("all-mpnet-base-v2")' 

CMD ["gunicorn", "--bind", ":$PORT", "--timeout", "0", "main:app"]