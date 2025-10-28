# Ubuntu 22.04ベースのPyTorch GPU環境
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

# 環境変数の設定
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV CUDA_HOME=/usr/local/cuda

# 基本パッケージのインストール
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3-pip \
    python3-dev \
    git \
    wget \
    curl \
    vim \
    && rm -rf /var/lib/apt/lists/*

# pipのアップグレード
RUN pip3 install --upgrade pip

# 作業ディレクトリの設定
WORKDIR /workspace

# requirements.txtをコピーして依存関係をインストール
COPY requirements.txt /workspace/
RUN pip3 install -r requirements.txt

# PyTorch GPU版のインストール（CUDA 11.8対応）
RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

# コードをコピー
COPY . /workspace/

# Jupyter Notebookのインストール（オプション）
RUN pip3 install jupyter notebook ipywidgets

# ポート8888を公開（Jupyter用）
EXPOSE 8888

# デフォルトコマンド
CMD ["/bin/bash"]
