import os
from pathlib import Path

import mysql.connector
import numpy as np
import onnxruntime as ort
from tokenizers import Tokenizer


# ------------------------------------------------------------
# Database configuration
# ------------------------------------------------------------

DB_CONFIG = {
    "host": os.getenv("DB_HOST", "javadb.rehat.xyz"),
    "port": int(os.getenv("DB_PORT", "3306")),
    "user": os.getenv("DB_USER", "avnadmin"),
    "password": os.getenv("DB_PASSWORD", "YOUR_PASSWORD"),
    "database": os.getenv("DB_NAME", "travel_tourism"),
}


# ------------------------------------------------------------
# Model configuration
# ------------------------------------------------------------

MODEL_DIR = Path(
    os.getenv("BGE_MODEL_DIR", "./bge-m3/onnx")
)

MODEL_PATH = MODEL_DIR / "model.onnx"
TOKENIZER_PATH = MODEL_DIR / "tokenizer.json"

MAX_LENGTH = 8192
BATCH_SIZE = 4
EMBEDDING_DIM = 1024


# ------------------------------------------------------------
# Load tokenizer
# ------------------------------------------------------------

print("Loading tokenizer...")

tokenizer = Tokenizer.from_file(
    str(TOKENIZER_PATH)
)

# Truncate long texts to the model's maximum length.
tokenizer.enable_truncation(
    max_length=MAX_LENGTH
)

# IMPORTANT:
# encode_batch() returns sequences of different lengths unless
# padding is enabled. ONNX requires a rectangular [batch, length]
# input tensor, so let the tokenizer handle the padding.
tokenizer.enable_padding()


# ------------------------------------------------------------
# Load ONNX model
# ------------------------------------------------------------

print("Loading ONNX model...")

session = ort.InferenceSession(
    str(MODEL_PATH),
    providers=["CPUExecutionProvider"],
)


# ------------------------------------------------------------
# Print model information
# ------------------------------------------------------------

print("\nModel inputs:")

for inp in session.get_inputs():
    print(
        f"  {inp.name}: "
        f"{inp.shape} "
        f"{inp.type}"
    )

print("\nModel outputs:")

for out in session.get_outputs():
    print(
        f"  {out.name}: "
        f"{out.shape} "
        f"{out.type}"
    )


# ------------------------------------------------------------
# Generate embeddings
# ------------------------------------------------------------

def generate_embeddings(texts):
    """
    Generate one 1024-dimensional BGE-M3 embedding per text.

    The ONNX model already provides a sentence_embedding output,
    so there is no need to manually mean-pool token_embeddings.
    """

    encoded = tokenizer.encode_batch(texts)

    input_ids = np.asarray(
        [encoding.ids for encoding in encoded],
        dtype=np.int64,
    )

    attention_mask = np.asarray(
        [encoding.attention_mask for encoding in encoded],
        dtype=np.int64,
    )

    outputs = session.run(
        None,
        {
            "input_ids": input_ids,
            "attention_mask": attention_mask,
        },
    )

    # Model outputs:
    #
    # outputs[0] = token_embeddings
    #             [batch, sequence_length, 1024]
    #
    # outputs[1] = sentence_embedding
    #             [batch, 1024]
    #
    embeddings = outputs[1].astype(
        np.float32,
        copy=False,
    )

    expected_shape = (
        len(texts),
        EMBEDDING_DIM,
    )

    if embeddings.shape != expected_shape:
        raise RuntimeError(
            f"Expected embedding shape "
            f"{expected_shape}, "
            f"got {embeddings.shape}"
        )

    return embeddings


# ------------------------------------------------------------
# Convert embedding to MySQL VECTOR string
# ------------------------------------------------------------

def vector_to_mysql(embedding):
    """
    Convert a NumPy embedding into the string format accepted
    by MySQL's STRING_TO_VECTOR() function.

    Example:
        [0.123,-0.456,0.789,...]
    """

    return "[" + ",".join(
        format(float(value), ".8g")
        for value in embedding
    ) + "]"


# ------------------------------------------------------------
# Main
# ------------------------------------------------------------

def main():

    print("\nConnecting to MySQL...")

    connection = mysql.connector.connect(
        **DB_CONFIG
    )

    cursor = connection.cursor()

    try:

        # ----------------------------------------------------
        # Get all tours that already have generated text
        # ----------------------------------------------------

        cursor.execute(
            """
            SELECT tour_id, embedding_text
            FROM tour_embedding
            WHERE embedding_text IS NOT NULL
              AND embedding_text <> ''
            ORDER BY tour_id
            """
        )

        rows = cursor.fetchall()

        print(
            f"Found {len(rows)} tours "
            f"with embedding text."
        )

        if not rows:
            print("Nothing to embed.")
            return

        # ----------------------------------------------------
        # MySQL update
        # ----------------------------------------------------

        update_sql = """
            UPDATE tour_embedding
            SET embedding = STRING_TO_VECTOR(%s)
            WHERE tour_id = %s
        """

        total = len(rows)

        # ----------------------------------------------------
        # Process tours in batches
        # ----------------------------------------------------

        for start in range(
            0,
            total,
            BATCH_SIZE,
        ):

            batch = rows[
                start:start + BATCH_SIZE
            ]

            tour_ids = [
                row[0]
                for row in batch
            ]

            texts = [
                row[1]
                for row in batch
            ]

            print(
                f"Generating embeddings "
                f"{start + 1}-"
                f"{start + len(batch)} / "
                f"{total}..."
            )

            # Generate embeddings for this batch.
            embeddings = generate_embeddings(
                texts
            )

            updates = []

            for tour_id, embedding in zip(
                tour_ids,
                embeddings,
            ):

                vector = vector_to_mysql(
                    embedding
                )

                updates.append(
                    (
                        vector,
                        tour_id,
                    )
                )

            # Store embeddings.
            cursor.executemany(
                update_sql,
                updates,
            )

            connection.commit()

            print(
                f"Stored embeddings for "
                f"tour IDs: {tour_ids}"
            )

        print("\nDone.")

        print(
            f"Generated and stored "
            f"{total} embeddings."
        )

    except Exception:

        connection.rollback()

        print(
            "\nERROR: "
            "Rolling back database changes."
        )

        raise

    finally:

        cursor.close()
        connection.close()


# ------------------------------------------------------------
# Entry point
# ------------------------------------------------------------

if __name__ == "__main__":
    main()
