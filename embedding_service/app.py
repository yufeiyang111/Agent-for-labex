"""
Flask HTTP Service for BGE-M3 Embeddings and Semantic Chunking
Run independently: python app.py
"""
import sys
import os

# 设置HuggingFace镜像（必须在导入其他库之前）
from config import setup_hf_mirror, MODEL_CONFIG, CHUNK_CONFIG, SERVICE_CONFIG
setup_hf_mirror()

from flask import Flask, request, jsonify
from bge_m3_model import BGE_M3_Model
from spacy_nlp import get_nlp
from semantic_chunker import SemanticChunker
import numpy as np

app = Flask(__name__)

# 全局模型实例
model = None
chunker = None


def get_model():
    """Get or initialize the embedding model"""
    global model
    if model is None:
        model = BGE_M3_Model()
        model.load_model()
    return model


def get_chunker():
    """Get or initialize the semantic chunker"""
    global chunker
    if chunker is None:
        chunker = SemanticChunker(get_model())
    return chunker


@app.before_request
def ensure_models_loaded():
    """确保模型已加载（首次请求时触发）"""
    pass


@app.route("/health", methods=["GET"])
def health_check():
    """Health check endpoint"""
    return jsonify({
        "status": "ok",
        "model": MODEL_CONFIG["embedding_model"],
        "models_loaded": {
            "embedding": model is not None,
            "chunker": chunker is not None
        }
    })


@app.route("/embed", methods=["POST"])
def embed():
    """
    Generate embeddings for text(s)

    Request body:
        {
            "texts": ["text1", "text2", ...],
            "normalize": true/false
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
    """Get embedding dimension"""
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
            "lang": "zh"
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

        model_map = MODEL_CONFIG["spacy_models"]
        model_name = model_map.get(lang, model_map["zh"])

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

        model_map = MODEL_CONFIG["spacy_models"]
        model_name = model_map.get(lang, model_map["zh"])

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

        model_map = MODEL_CONFIG["spacy_models"]
        model_name = model_map.get(lang, model_map["zh"])

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


@app.route("/chunk/semantic", methods=["POST"])
def semantic_chunk():
    """
    语义切割 - 基于向量相似度将文本分割成语义完整的块

    Request body:
        {
            "text": "长文本内容...",
            "similarity_threshold": 0.5,  // 可选，相似度阈值
            "min_chunk_size": 1,          // 可选，最小块句子数
            "max_chunk_size": 10,         // 可选，最大块句子数
            "lang": "zh"                  // 可选，语言
        }

    Response:
        {
            "code": 0,
            "data": {
                "chunks": [
                    {
                        "text": "块文本",
                        "sentences": ["句子1", "句子2"],
                        "start_idx": 0,
                        "end_idx": 2,
                        "embedding": [0.1, 0.2, ...]
                    }
                ],
                "total_chunks": 3,
                "total_sentences": 10,
                "threshold_used": 0.5,
                "similarities": [0.8, 0.3, ...]
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
        similarity_threshold = data.get(
            "similarity_threshold",
            CHUNK_CONFIG["similarity_threshold"]
        )
        min_chunk_size = data.get("min_chunk_size", CHUNK_CONFIG["min_chunk_size"])
        max_chunk_size = data.get("max_chunk_size", CHUNK_CONFIG["max_chunk_size"])
        lang = data.get("lang", CHUNK_CONFIG["default_lang"])

        semantic_chunker = get_chunker()
        result = semantic_chunker.chunk_text(
            text=text,
            similarity_threshold=similarity_threshold,
            min_chunk_size=min_chunk_size,
            max_chunk_size=max_chunk_size,
            lang=lang
        )

        return jsonify({
            "code": 0,
            "data": result
        })

    except Exception as e:
        return jsonify({
            "code": 1,
            "message": str(e)
        }), 500


@app.route("/chunk/paragraph", methods=["POST"])
def paragraph_chunk():
    """
    段落切割 - 按段落分割文本并生成向量

    Request body:
        {
            "text": "段落1\n\n段落2\n\n段落3",
            "lang": "zh"
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

        semantic_chunker = get_chunker()
        result = semantic_chunker.chunk_by_paragraph(text=text, lang=lang)

        return jsonify({
            "code": 0,
            "data": result
        })

    except Exception as e:
        return jsonify({
            "code": 1,
            "message": str(e)
        }), 500


@app.route("/chunk/search", methods=["POST"])
def chunk_search():
    """
    语义搜索 - 根据查询在块中查找最相关的内容

    Request body:
        {
            "query": "查询文本",
            "chunks": [
                {"text": "块1", "embedding": [...]},
                {"text": "块2", "embedding": [...]}
            ],
            "top_k": 3
        }
    """
    try:
        data = request.get_json()

        if not data or "query" not in data or "chunks" not in data:
            return jsonify({
                "code": 1,
                "message": "Missing required fields: query, chunks"
            }), 400

        query = data["query"]
        chunks = data["chunks"]
        top_k = data.get("top_k", 3)

        semantic_chunker = get_chunker()
        results = semantic_chunker.find_similar_chunks(
            query=query,
            chunks=chunks,
            top_k=top_k
        )

        return jsonify({
            "code": 0,
            "data": {
                "results": results,
                "total_results": len(results)
            }
        })

    except Exception as e:
        return jsonify({
            "code": 1,
            "message": str(e)
        }), 500


def preload_models():
    """预加载所有模型"""
    print("=" * 50)
    print("Preloading models...")
    print("=" * 50)

    # 加载Embedding模型
    print(f"\n[1/2] Loading embedding model: {MODEL_CONFIG['embedding_model']}")
    get_model()

    # 初始化语义切割器
    print("\n[2/2] Initializing semantic chunker...")
    get_chunker()

    print("\n" + "=" * 50)
    print("All models loaded successfully!")
    print("=" * 50)


if __name__ == "__main__":
    print("\n" + "=" * 50)
    print("BGE-M3 Embedding & Semantic Chunking Service")
    print("=" * 50)
    print(f"\nHF_ENDPOINT: {os.environ.get('HF_ENDPOINT', 'Not set')}")
    print(f"Embedding Model: {MODEL_CONFIG['embedding_model']}")
    print(f"\nEndpoints:")
    print("  GET  /health           - Health check")
    print("  POST /embed            - Generate embeddings")
    print("  GET  /embed/dimension  - Get embedding dimension")
    print("  POST /nlp/sentences    - Sentence segmentation")
    print("  POST /nlp/entities     - Named entity recognition")
    print("  POST /nlp/preprocess   - Text preprocessing")
    print("  POST /chunk/semantic   - Semantic chunking")
    print("  POST /chunk/paragraph  - Paragraph chunking")
    print("  POST /chunk/search     - Semantic search")
    print("=" * 50)

    # 预加载模型
    if MODEL_CONFIG.get("auto_load_on_startup", True):
        preload_models()

    print(f"\nStarting server on http://{SERVICE_CONFIG['host']}:{SERVICE_CONFIG['port']}")
    app.run(
        host=SERVICE_CONFIG["host"],
        port=SERVICE_CONFIG["port"],
        debug=SERVICE_CONFIG["debug"]
    )
