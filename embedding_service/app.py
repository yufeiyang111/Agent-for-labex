"""
Flask HTTP Service for BGE-M3 Embeddings
Run independently: python app.py
"""
from flask import Flask, request, jsonify
from bge_m3_model import BGE_M3_Model
from spacy_nlp import get_nlp
import numpy as np

app = Flask(__name__)

# Global model instance
model = None


def get_model():
    """Get or initialize the model"""
    global model
    if model is None:
        model = BGE_M3_Model()
        model.load_model()
    return model


@app.route("/health", methods=["GET"])
def health_check():
    """Health check endpoint"""
    return jsonify({"status": "ok", "model": "BAAI/bge-m3"})


@app.route("/embed", methods=["POST"])
def embed():
    """
    Generate embeddings for text(s)

    Request body:
        {
            "texts": ["text1", "text2", ...]  // Required: list of texts
            "normalize": true/false            // Optional: normalize embeddings
        }

    Response:
        {
            "code": 0,
            "data": {
                "embeddings": [[0.1, 0.2, ...], [0.3, 0.4, ...]],  // List of vectors
                "dimension": 1024,
                "count": 2
            }
        }
    """
    try:
        data = request.get_json()

        if not data or "texts" not in data:
            return jsonify({
                "code": 1,
                "message": "Missing required field: texts"
            }), 400

        texts = data["texts"]
        if not isinstance(texts, list) or len(texts) == 0:
            return jsonify({
                "code": 1,
                "message": "texts must be a non-empty list"
            }), 400

        normalize = data.get("normalize", True)

        # Get embeddings
        bge_model = get_model()
        embeddings = bge_model.encode(texts, normalize=normalize)

        return jsonify({
            "code": 0,
            "data": {
                "embeddings": embeddings,
                "dimension": len(embeddings[0]) if embeddings else 0,
                "count": len(embeddings)
            }
        })

    except Exception as e:
        return jsonify({
            "code": 1,
            "message": str(e)
        }), 500


@app.route("/embed/dimension", methods=["GET"])
def embed_dimension():
    """
    Get embedding dimension

    Response:
        {
            "code": 0,
            "data": {
                "dimension": 1024
            }
        }
    """
    try:
        bge_model = get_model()
        dim = bge_model.get_dim()
        return jsonify({
            "code": 0,
            "data": {"dimension": dim}
        })
    except Exception as e:
        return jsonify({
            "code": 1,
            "message": str(e)
        }), 500


@app.route("/nlp/sentences", methods=["POST"])
def nlp_sentences():
    """
    Split text into sentences using SpaCy

    Request body:
        {
            "text": "文本内容...",
            "lang": "zh"  // Optional: zh or en, default zh
        }

    Response:
        {
            "code": 0,
            "data": {
                "sentences": ["句子1", "句子2", ...]
            }
        }
    """
    try:
        data = request.get_json()

        if not data or "text" not in data:
            return jsonify({
                "code": 1,
                "message": "Missing required field: text"
            }), 400

        text = data["text"]
        lang = data.get("lang", "zh")

        # Map lang to spaCy model name
        model_map = {
            "zh": "zh_core_web_sm",
            "en": "en_core_web_sm"
        }
        model_name = model_map.get(lang, "zh_core_web_sm")

        nlp = get_nlp(model_name)
        sentences = nlp.sent_segment(text)

        return jsonify({
            "code": 0,
            "data": {
                "sentences": sentences
            }
        })

    except Exception as e:
        return jsonify({
            "code": 1,
            "message": str(e)
        }), 500


@app.route("/nlp/entities", methods=["POST"])
def nlp_entities():
    """
    Extract named entities using SpaCy

    Request body:
        {
            "text": "文本内容...",
            "lang": "zh"
        }

    Response:
        {
            "code": 0,
            "data": {
                "entities": [["实体1", "ORG"], ["实体2", "PERSON"], ...]
            }
        }
    """
    try:
        data = request.get_json()

        if not data or "text" not in data:
            return jsonify({
                "code": 1,
                "message": "Missing required field: text"
            }), 400

        text = data["text"]
        lang = data.get("lang", "zh")

        model_map = {
            "zh": "zh_core_web_sm",
            "en": "en_core_web_sm"
        }
        model_name = model_map.get(lang, "zh_core_web_sm")

        nlp = get_nlp(model_name)
        entities = nlp.extract_entities(text)

        return jsonify({
            "code": 0,
            "data": {
                "entities": entities
            }
        })

    except Exception as e:
        return jsonify({
            "code": 1,
            "message": str(e)
        }), 500


@app.route("/nlp/preprocess", methods=["POST"])
def nlp_preprocess():
    """
    Preprocess text (remove stopwords, lemmatize)

    Request body:
        {
            "text": "文本内容...",
            "lang": "zh"
        }

    Response:
        {
            "code": 0,
            "data": {
                "processed": "处理后的文本"
            }
        }
    """
    try:
        data = request.get_json()

        if not data or "text" not in data:
            return jsonify({
                "code": 1,
                "message": "Missing required field: text"
            }), 400

        text = data["text"]
        lang = data.get("lang", "zh")

        model_map = {
            "zh": "zh_core_web_sm",
            "en": "en_core_web_sm"
        }
        model_name = model_map.get(lang, "zh_core_web_sm")

        nlp = get_nlp(model_name)
        processed = nlp.preprocess(text)

        return jsonify({
            "code": 0,
            "data": {
                "processed": processed
            }
        })

    except Exception as e:
        return jsonify({
            "code": 1,
            "message": str(e)
        }), 500


if __name__ == "__main__":
    print("Starting BGE-M3 Embedding Service on http://localhost:5000")
    print("Endpoints:")
    print("  GET  /health           - Health check")
    print("  POST /embed            - Generate embeddings")
    print("  GET  /embed/dimension  - Get embedding dimension")
    print("  POST /nlp/sentences    - Sentence segmentation (SpaCy)")
    print("  POST /nlp/entities     - Named entity recognition (SpaCy)")
    print("  POST /nlp/preprocess   - Text preprocessing (SpaCy)")
    app.run(host="0.0.0.0", port=5000, debug=False)
