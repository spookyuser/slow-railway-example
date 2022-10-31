import time

from bertopic import BERTopic
from sentence_transformers import SentenceTransformer
from sklearn.datasets import fetch_20newsgroups

docs = fetch_20newsgroups(subset="all", remove=("headers", "footers", "quotes"))
docs = docs.data[:1000]
sentence_model = SentenceTransformer("all-mpnet-base-v2")


# Crete embeddings
start = time.time()
sentence_embeddings = sentence_model.encode(docs, show_progress_bar=True)
end = time.time()
print("Time taken to embed the documents: {:.2f} seconds".format(end - start))

# Cluster documents
start = time.time()
topic_model = BERTopic()
topics, probs = topic_model.fit_transform(docs, embeddings=sentence_embeddings)
end = time.time()
print("Time taken to cluster the documents: {:.2f} seconds".format(end - start))
