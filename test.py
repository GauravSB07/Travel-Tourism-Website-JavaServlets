import mysql.connector
import numpy as np
import onnxruntime as ort
from tokenizers import Tokenizer


# -----------------------------
# CONFIG
# -----------------------------

DB_CONFIG = {
    "host": "javadb.rehat.xyz",
    "port": 3306,
    "user": "avnadmin",
    "password": "AVNS_skBVP1sM63j-YORGUKn",
    "database": "travel_tourism",
}

MODEL_DIR = "./bge-m3/onnx"
MODEL_PATH = f"{MODEL_DIR}/model.onnx"
TOKENIZER_PATH = f"{MODEL_DIR}/tokenizer.json"


# -----------------------------
# LOAD MODEL
# -----------------------------

print("Loading BGE-M3...")

tokenizer = Tokenizer.from_file(TOKENIZER_PATH)
session = ort.InferenceSession(
    MODEL_PATH,
    providers=["CPUExecutionProvider"]
)

print("Model loaded.")


# -----------------------------
# EMBEDDING
# -----------------------------

def embed(text):
    encoded = tokenizer.encode_batch([text])

    input_ids = np.array(
        [e.ids for e in encoded],
        dtype=np.int64
    )

    attention_mask = np.array(
        [e.attention_mask for e in encoded],
        dtype=np.int64
    )

    outputs = session.run(
        None,
        {
            "input_ids": input_ids,
            "attention_mask": attention_mask
        }
    )

    # BGE-M3 ONNX model's sentence_embedding output
    embedding = outputs[1][0].astype(np.float32)

    return embedding


# -----------------------------
# VECTOR -> MYSQL STRING
# -----------------------------

def vector_to_mysql(vector):
    return "[" + ",".join(map(str, vector)) + "]"


# -----------------------------
# SEARCH
# -----------------------------

def search_tours(query, limit=3):

    embedding = embed(query)
    vector_string = vector_to_mysql(embedding)

    conn = mysql.connector.connect(**DB_CONFIG)

    cursor = conn.cursor()

    # Construct MyVector query vector inside MySQL
    cursor.execute(
        "SET @query_vec = myvector_construct(%s)",
        (vector_string,)
    )

    cursor.execute("""
        SELECT
            t.id,
            t.name,
            myvector_distance(
                te.embedding_myvector,
                @query_vec,
                'Cosine'
            ) AS distance
        FROM tour_embedding te
        JOIN tours t
            ON t.id = te.tour_id
        WHERE te.embedding_myvector IS NOT NULL
        ORDER BY distance
        LIMIT %s
    """, (limit,))

    results = cursor.fetchall()

    cursor.close()
    conn.close()

    return results


# -----------------------------
# MAIN
# -----------------------------

query = input("\nWhat kind of tour are you looking for?\n> ")

print("\nSearching...\n")

results = search_tours(query)

if not results:
    print("No tours found.")
else:
    print("Top 3 tours:\n")

    for rank, (tour_id, name, distance) in enumerate(results, 1):
        print(f"{rank}. {name}")
        print(f"   ID: {tour_id}")
        print(f"   Distance: {distance:.4f}")
        print()
