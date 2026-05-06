"""
Text Preprocessing using SpaCy
"""
import spacy
from typing import List, Optional


class SpaCyNLP:
    def __init__(self, lang: str = "zh_core_web_sm"):
        self.nlp = None
        self.lang = lang
        self._loaded = False

    def load(self, lang: Optional[str] = None):
        """Load spaCy model"""
        model = lang or self.lang
        try:
            self.nlp = spacy.load(model)
            self._loaded = True
            print(f"SpaCy model '{model}' loaded successfully!")
        except OSError:
            print(f"Model '{model}' not found. Installing...")
            import subprocess
            subprocess.run(["python", "-m", "spacy", "download", model], check=True)
            self.nlp = spacy.load(model)
            self._loaded = True

    def is_loaded(self) -> bool:
        return self._loaded and self.nlp is not None

    def sent_segment(self, text: str) -> List[str]:
        """
        Split text into sentences using spaCy's sentence boundary detection

        Args:
            text: Input text

        Returns:
            List of sentences
        """
        if not self.is_loaded():
            self.load()

        doc = self.nlp(text)
        sentences = [sent.text.strip() for sent in doc.sents if sent.text.strip()]
        return sentences

    def tokenize(self, text: str) -> List[str]:
        """
        Tokenize text into words/tokens

        Args:
            text: Input text

        Returns:
            List of tokens
        """
        if not self.is_loaded():
            self.load()

        doc = self.nlp(text)
        return [token.text for token in doc if not token.is_space and not token.is_punct]

    def extract_entities(self, text: str) -> List[tuple]:
        """
        Extract named entities

        Args:
            text: Input text

        Returns:
            List of (entity_text, entity_label) tuples
        """
        if not self.is_loaded():
            self.load()

        doc = self.nlp(text)
        return [(ent.text, ent.label_) for ent in doc.ents]

    def preprocess(self, text: str) -> str:
        """
        Full preprocessing: clean and normalize text

        Args:
            text: Input text

        Returns:
            Preprocessed text
        """
        if not self.is_loaded():
            self.load()

        doc = self.nlp(text)
        # Remove stopwords and punctuation, keep meaningful tokens
        tokens = []
        for token in doc:
            if not token.is_stop and not token.is_punct and not token.is_space:
                # Use lemmatized form if available, otherwise original token
                lemma = token.lemma_ if token.lemma_ else token.text
                tokens.append(lemma)
        return " ".join(tokens)


# Singleton instance for reuse
_nlp_instance = None


def get_nlp(lang: str = "zh_core_web_sm") -> SpaCyNLP:
    """Get or create singleton NLP instance"""
    global _nlp_instance
    if _nlp_instance is None or _nlp_instance.lang != lang:
        _nlp_instance = SpaCyNLP(lang)
    return _nlp_instance