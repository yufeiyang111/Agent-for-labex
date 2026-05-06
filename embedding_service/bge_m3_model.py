"""
BGE-M3 Embedding Model Wrapper
"""
from sentence_transformers import SentenceTransformer
import torch
import numpy as np
from typing import List


class BGE_M3_Model:
    def __init__(self, model_name: str = "BAAI/bge-m3"):
        self.model_name = model_name
        self.model = None
        self.device = "cuda" if torch.cuda.is_available() else "cpu"

    def load_model(self):
        """Load the BGE-M3 model"""
        print(f"Loading BGE-M3 model on {self.device}...")
        self.model = SentenceTransformer(self.model_name, device=self.device)
        print("Model loaded successfully!")

    def encode(self, texts: List[str], normalize: bool = True) -> List[List[float]]:
        """
        Encode texts into embeddings

        Args:
            texts: List of text strings
            normalize: Whether to normalize embeddings to unit length

        Returns:
            List of embedding vectors
        """
        if self.model is None:
            self.load_model()

        embeddings = self.model.encode(
            texts,
            normalize_embeddings=normalize,
            convert_to_numpy=True,
            show_progress_bar=False
        )

        return embeddings.tolist()

    def get_dim(self) -> int:
        """Get embedding dimension"""
        if self.model is None:
            self.load_model()
        return self.model.get_sentence_embedding_dimension()


if __name__ == "__main__":
    model = BGE_M3_Model()
    model.load_model()
    test_texts = ["Hello world", "这是一条测试文本"]
    embeddings = model.encode(test_texts)
    print(f"Generated {len(embeddings)} embeddings with dimension {len(embeddings[0])}")
