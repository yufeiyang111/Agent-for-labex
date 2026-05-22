"""
SpaCy NLP Wrapper for sentence segmentation, entity extraction and preprocessing
"""
import spacy
from typing import List, Tuple, Optional


class SpacyNLP:
    def __init__(self, model_name: str = "zh_core_web_sm"):
        self.model_name = model_name
        self.nlp = None

    def load_model(self):
        """Load spaCy model"""
        try:
            self.nlp = spacy.load(self.model_name)
            print(f"Loaded spaCy model: {self.model_name}")
        except OSError:
            print(f"Downloading spaCy model: {self.model_name}...")
            spacy.cli.download(self.model_name)
            self.nlp = spacy.load(self.model_name)

    def _ensure_model(self):
        """Ensure model is loaded"""
        if self.nlp is None:
            self.load_model()

    def sent_segment(self, text: str) -> List[str]:
        """
        Split text into sentences

        Args:
            text: Input text

        Returns:
            List of sentences
        """
        self._ensure_model()
        doc = self.nlp(text)
        return [sent.text.strip() for sent in doc.sents if sent.text.strip()]

    def extract_entities(self, text: str) -> List[Tuple[str, str]]:
        """
        Extract named entities

        Args:
            text: Input text

        Returns:
            List of (entity_text, entity_label) tuples
        """
        self._ensure_model()
        doc = self.nlp(text)
        return [(ent.text, ent.label_) for ent in doc.ents]

    def preprocess(self, text: str) -> str:
        """
        Preprocess text: remove stopwords and lemmatize

        Args:
            text: Input text

        Returns:
            Preprocessed text
        """
        self._ensure_model()
        doc = self.nlp(text)
        tokens = [
            token.lemma_ for token in doc
            if not token.is_stop and not token.is_punct and not token.is_space
        ]
        return " ".join(tokens)


# Cache for loaded models
_models = {}


def get_nlp(model_name: str = "zh_core_web_sm") -> SpacyNLP:
    """
    Get or create a SpacyNLP instance

    Args:
        model_name: spaCy model name (zh_core_web_sm, en_core_web_sm)

    Returns:
        SpacyNLP instance
    """
    if model_name not in _models:
        _models[model_name] = SpacyNLP(model_name)
    return _models[model_name]
