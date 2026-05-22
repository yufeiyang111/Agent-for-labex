"""
配置文件 - HuggingFace镜像和环境设置
"""
import os

# 设置HuggingFace镜像，解决国内无法访问huggingface.co的问题
os.environ["HF_ENDPOINT"] = "https://hf-mirror.com"
os.environ["HF_HUB_DISABLE_SYMLINKS"] = "1"

# 绕过系统代理，直连镜像站
os.environ["NO_PROXY"] = "*"
os.environ["no_proxy"] = "*"


def setup_hf_mirror():
    """确认HuggingFace镜像环境变量已设置"""
    print(f"[Config] HF_ENDPOINT={os.environ.get('HF_ENDPOINT', 'Not set')}")
    print("[Config] NO_PROXY=* set to bypass system proxy")


# 模型配置
MODEL_CONFIG = {
    "embedding_model": "BAAI/bge-m3",
    "spacy_models": {
        "zh": "zh_core_web_sm",
        "en": "en_core_web_sm"
    },
    "auto_load_on_startup": True  # 启动时自动加载模型
}

# 语义切割默认配置
CHUNK_CONFIG = {
    "similarity_threshold": 0.5,  # 相似度阈值
    "min_chunk_size": 1,          # 最小块句子数
    "max_chunk_size": 10,         # 最大块句子数
    "default_lang": "zh"          # 默认语言
}

# 服务配置
SERVICE_CONFIG = {
    "host": "0.0.0.0",
    "port": 5000,
    "debug": False
}
