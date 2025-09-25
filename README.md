# Docker-scp-box

このリポジトリは、Docker 上で Ubuntu + OpenSSH サーバーを立ち上げ、  
SCP/SSH 経由で安全にファイル転送を行うための学習用環境です。

## 使い方

### 1. 公開鍵を用意する
ローカルで SSH 鍵を作成してください（まだ持っていない場合）。

```bash
ssh-keygen -t ed25519 -C "yourname@example.com"
```

これで ~/.ssh/id_ed25519.pub ができます。
このファイルの中身を authorized_keys を作成してそこにコピーしてください。

### 2. Docker イメージをビルド & 起動

```bash
docker build -t docker-scp-box .
docker run -d -p 2222:22 --name scpbox docker-scp-box
```

### 3. 接続

```bash
ssh -i ~/.ssh/id_ed25519 -p 2222 dev@localhost
```

### 4. ファイル転送

- アップロード（ローカル → コンテナ）:

```bash
scp -i ~/.ssh/id_ed25519 -P 2222 filepath dev@localhost:/home/dev/
```

- ダウンロード（コンテナ → ローカル）:

```bash
scp -i ~/.ssh/id_ed25519 -P 2222 dev@localhost:/home/dev/filename outputpath
```

## 注意事項

> - 秘密鍵（id_ed25519）は絶対に公開しないでください  
> - authorized_keys は各自で作成し、このリポジトリには含めないでください  
> - `.gitignore` で無視されるようになっています  