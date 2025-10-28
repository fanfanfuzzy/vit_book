# Vision Transformer 入門 - GPU環境セットアップ

このリポジトリは「Vision Transformer入門」のサンプルコードをUbuntu 22.04 + A6000 GPU環境で実行するためのセットアップガイドです。

## 元のリポジトリ

- オリジナル: https://github.com/ghmagazine/vit_book
- 書籍情報: [Vision Transformer入門](https://gihyo.jp/book/2022/978-4-297-13058-9)

## 必要な環境

- Ubuntu 22.04
- NVIDIA GPU (A6000推奨)
- Docker & Docker Compose
- nvidia-docker2 (NVIDIA Container Toolkit)

## セットアップ手順

### 1. リポジトリのクローン

```bash
git clone https://github.com/fanfanfuzzy/vit_book.git
cd vit_book
```

### 2. Docker環境の構築

```bash
# Dockerイメージのビルド
docker-compose build

# コンテナの起動
docker-compose up -d

# コンテナに入る
docker exec -it vit_book_gpu bash
```

### 3. GPU動作確認

コンテナ内で以下のコマンドを実行してGPUが認識されているか確認:

```bash
python3 -c "import torch; print(f'CUDA available: {torch.cuda.is_available()}'); print(f'GPU count: {torch.cuda.device_count()}'); print(f'GPU name: {torch.cuda.get_device_name(0) if torch.cuda.is_available() else \"N/A\"}')"
```

### 4. サンプルコードの実行

#### 第2章のサンプル

```bash
cd /workspace/ch2

# example.pyの実行
python3 example.py

# vit.pyの実行（Vision Transformerの実装）
python3 vit.py
```

## ディレクトリ構成

```
vit_book/
├── README.md              # オリジナルのREADME
├── README_SETUP.md        # このファイル（セットアップガイド）
├── Dockerfile             # Docker環境定義
├── docker-compose.yaml    # Docker Compose設定
├── requirements.txt       # Python依存パッケージ
├── ch2/                   # 第2章のサンプルコード
│   ├── example.py        # 基本的なMLP実装
│   └── vit.py            # Vision Transformer実装
└── ch3/                   # 第3章の画像
    └── position_embedding.png
```

## 依存パッケージ

- PyTorch 2.0.0以上（CUDA 11.8対応）
- torchvision 0.15.0以上
- numpy 1.24.0以上
- matplotlib 3.7.0以上
- pillow 9.5.0以上

## Jupyter Notebookの使用

コンテナ内でJupyter Notebookを起動する場合:

```bash
jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root
```

ブラウザで `http://localhost:8888` にアクセスしてください。

## トラブルシューティング

### GPUが認識されない場合

1. nvidia-docker2がインストールされているか確認:
```bash
docker run --rm --gpus all nvidia/cuda:11.8.0-base-ubuntu22.04 nvidia-smi
```

2. NVIDIA Container Toolkitの再起動:
```bash
sudo systemctl restart docker
```

### メモリ不足エラーが出る場合

docker-compose.yamlの`shm_size`を増やしてください:
```yaml
shm_size: '16gb'  # デフォルトは8gb
```

## ライセンス

オリジナルのサンプルコードはMIT Licenseで公開されています。

## 書籍情報

* 片岡裕雄　監修，山本晋太郎，徳永匡臣，箕浦大晃，邱玥（QIU YUE），品川政太朗　著
* 「Vision Transformer入門」（技術評論社）
* [書籍ページ](https://gihyo.jp/book/2022/978-4-297-13058-9)
* [サポートページ](https://gihyo.jp/book/2022/978-4-297-13058-9/support)
