import numpy as np
import mysql.connector

DB_CONFIG = {
    "host": "javadb.rehat.xyz",
    "port": 3306,
    "user": "avnadmin",
    "password": "AVNS_skBVP1sM63j-YORGUKn",
    "database": "travel_tourism",
}

INPUT_FILE = "embeddings.npy"

conn = mysql.connector.connect(**DB_CONFIG)
cursor = conn.cursor()

embeddings = np.load(INPUT_FILE)

print("Shape:", embeddings.shape)
print("Dtype:", embeddings.dtype)

if embeddings.ndim != 2 or embeddings.shape[1] != 1024:
    raise ValueError(f"Expected (N, 1024), got {embeddings.shape}")

embeddings = embeddings.astype(np.float32)

for i, vector in enumerate(embeddings):
    vector_string = "[" + ",".join(map(str, vector)) + "]"

    cursor.execute(
        """
        SELECT myvector_construct(%s)
        """,
        (vector_string,)
    )

    mysql_vector = cursor.fetchone()[0]

    print(
        f"Vector {i}: "
        f"{len(vector_string)} chars -> "
        f"{len(mysql_vector)} bytes"
    )

    # Just testing conversion for now.
    # Nothing is written to the database yet.

cursor.close()
conn.close()

print("Conversion test completed successfully.")
