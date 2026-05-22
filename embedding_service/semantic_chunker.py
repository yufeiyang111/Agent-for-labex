"""
Semantic Chunker - 基于向量相似度的语义切割

工作流程:
1. 使用spaCy将文本分割为句子
2. 使用BGE-M3生成每个句子的向量
3. 计算相邻句子的余弦相似度
4. 在相似度低于阈值的位置进行切割
5. 将相邻的句子合并为语义完整的块
"""
import numpy as np
from typing import List, Dict, Any, Optional
from sklearn.metrics.pairwise import cosine_similarity


class SemanticChunker:
    def __init__(self, embedding_model, nlp_model=None):
        """
        Args:
            embedding_model: BGE_M3_Model instance for generating embeddings
            nlp_model: SpacyNLP instance for sentence segmentation
        """
        self.embedding_model = embedding_model
        self.nlp_model = nlp_model

    def chunk_text(
        self,
        text: str,
        similarity_threshold: float = 0.5,
        min_chunk_size: int = 1,
        max_chunk_size: int = 10,
        lang: str = "zh"
    ) -> Dict[str, Any]:
        """
        对文本进行语义切割

        Args:
            text: 输入文本
            similarity_threshold: 相似度阈值，低于此值则切割 (0-1)
            min_chunk_size: 最小块的句子数
            max_chunk_size: 最大块的句子数
            lang: 语言 (zh/en)

        Returns:
            {
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
                "threshold_used": 0.5
            }
        """
        from spacy_nlp import get_nlp

        # 获取NLP模型
        if self.nlp_model is None:
            model_map = {"zh": "zh_core_web_sm", "en": "en_core_web_sm"}
            self.nlp_model = get_nlp(model_map.get(lang, "zh_core_web_sm"))

        # 1. 分句
        sentences = self.nlp_model.sent_segment(text)
        if not sentences:
            return {
                "chunks": [],
                "total_chunks": 0,
                "total_sentences": 0,
                "threshold_used": similarity_threshold
            }

        # 2. 生成向量
        embeddings = self.embedding_model.encode(sentences, normalize=True)
        embeddings_array = np.array(embeddings)

        # 3. 计算相邻句子相似度
        similarities = []
        for i in range(len(sentences) - 1):
            sim = cosine_similarity(
                embeddings_array[i:i+1],
                embeddings_array[i+1:i+2]
            )[0][0]
            similarities.append(sim)

        # 4. 确定切割点
        split_points = [0]
        for i, sim in enumerate(similarities):
            if sim < similarity_threshold:
                # 检查当前块大小是否满足最小要求
                current_chunk_size = i + 1 - split_points[-1]
                if current_chunk_size >= min_chunk_size:
                    split_points.append(i + 1)

        # 5. 合并为块
        chunks = []
        for i in range(len(split_points)):
            start = split_points[i]
            end = split_points[i + 1] if i + 1 < len(split_points) else len(sentences)

            # 限制最大块大小
            if end - start > max_chunk_size:
                end = start + max_chunk_size

            chunk_sentences = sentences[start:end]
            chunk_text = " ".join(chunk_sentences)
            chunk_embedding = np.mean(embeddings_array[start:end], axis=0).tolist()

            chunks.append({
                "text": chunk_text,
                "sentences": chunk_sentences,
                "start_idx": start,
                "end_idx": end,
                "embedding": chunk_embedding
            })

        # 处理最后剩余的句子
        last_end = split_points[-1] if split_points else 0
        if last_end < len(sentences):
            remaining = sentences[last_end:]
            if len(remaining) <= max_chunk_size:
                if chunks and len(chunks[-1]["sentences"]) + len(remaining) <= max_chunk_size:
                    # 合并到最后一块
                    chunks[-1]["sentences"].extend(remaining)
                    chunks[-1]["text"] = " ".join(chunks[-1]["sentences"])
                    chunks[-1]["end_idx"] = len(sentences)
                    chunks[-1]["embedding"] = np.mean(
                        embeddings_array[chunks[-1]["start_idx"]:len(sentences)],
                        axis=0
                    ).tolist()
                else:
                    # 创建新块
                    chunk_embedding = np.mean(embeddings_array[last_end:], axis=0).tolist()
                    chunks.append({
                        "text": " ".join(remaining),
                        "sentences": remaining,
                        "start_idx": last_end,
                        "end_idx": len(sentences),
                        "embedding": chunk_embedding
                    })

        return {
            "chunks": chunks,
            "total_chunks": len(chunks),
            "total_sentences": len(sentences),
            "threshold_used": similarity_threshold,
            "similarities": similarities
        }

    def chunk_by_paragraph(
        self,
        text: str,
        lang: str = "zh"
    ) -> Dict[str, Any]:
        """
        按段落分割并生成向量

        Args:
            text: 输入文本
            lang: 语言

        Returns:
            段落块列表
        """
        # 按换行符分割段落
        paragraphs = [p.strip() for p in text.split("\n") if p.strip()]

        if not paragraphs:
            return {"chunks": [], "total_chunks": 0}

        # 生成向量
        embeddings = self.embedding_model.encode(paragraphs, normalize=True)

        chunks = []
        for i, (para, emb) in enumerate(zip(paragraphs, embeddings)):
            chunks.append({
                "text": para,
                "paragraph_idx": i,
                "embedding": emb
            })

        return {
            "chunks": chunks,
            "total_chunks": len(chunks)
        }

    def find_similar_chunks(
        self,
        query: str,
        chunks: List[Dict[str, Any]],
        top_k: int = 3
    ) -> List[Dict[str, Any]]:
        """
        根据查询找到最相似的块

        Args:
            query: 查询文本
            chunks: 块列表
            top_k: 返回前k个结果

        Returns:
            相似块列表（带分数）
        """
        # 生成查询向量
        query_embedding = np.array(self.embedding_model.encode([query], normalize=True))

        # 提取块向量
        chunk_embeddings = np.array([c["embedding"] for c in chunks])

        # 计算相似度
        similarities = cosine_similarity(query_embedding, chunk_embeddings)[0]

        # 排序并返回top_k
        indexed_sims = sorted(
            enumerate(similarities),
            key=lambda x: x[1],
            reverse=True
        )[:top_k]

        results = []
        for idx, score in indexed_sims:
            result = chunks[idx].copy()
            result["similarity_score"] = float(score)
            results.append(result)

        return results
