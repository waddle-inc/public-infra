# 運用手順 - Waddle Inc. インフラリポジトリ

このファイルでは、本番 VPS での運用手順をまとめています。

## 目次

<!-- toc -->

- [デプロイ](#%E3%83%87%E3%83%97%E3%83%AD%E3%82%A4)
- [サービス状態確認](#%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E7%8A%B6%E6%85%8B%E7%A2%BA%E8%AA%8D)
- [ログ確認](#%E3%83%AD%E3%82%B0%E7%A2%BA%E8%AA%8D)
- [コンテナ再起動](#%E3%82%B3%E3%83%B3%E3%83%86%E3%83%8A%E5%86%8D%E8%B5%B7%E5%8B%95)
- [サービス停止](#%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E5%81%9C%E6%AD%A2)
- [DB データの削除](#db-%E3%83%87%E3%83%BC%E3%82%BF%E3%81%AE%E5%89%8A%E9%99%A4)
- [依存パッケージの自動更新](#%E4%BE%9D%E5%AD%98%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8%E3%81%AE%E8%87%AA%E5%8B%95%E6%9B%B4%E6%96%B0)

<!-- tocstop -->

## デプロイ

他リポジトリの最新コードを取得し、コンテナをビルドして起動します。`deploy.sh` を実行してください。

## サービス状態確認

各コンテナの起動状態を確認します。

```bash
docker compose ps
```

## ログ確認

全サービスのログをリアルタイムで確認します。

```bash
docker compose logs -f
```

特定サービスのログのみ確認する場合はサービス名を指定します。

```bash
docker compose logs -f auth-api
```

ログは JSON ファイルドライバでローテーションされます（最大 10MB × 3 ファイル）。

## コンテナ再起動

特定サービスのコンテナを再起動します。

```bash
docker compose restart <サービス名>
```

## サービス停止

全コンテナを停止します。

```bash
docker compose down
```

## DB データの削除

PostgreSQL のデータボリュームを削除して初期化します。

> **注意:** この操作は取り消せません。実行前にバックアップを取ってください。

```bash
# ボリューム名を確認
docker volume ls | grep postgres

docker compose down
docker volume rm <上記で確認したボリューム名>
docker compose up -d
```

## 依存パッケージの自動更新

Dependabot が `docker-compose.yml` に記載されたベースイメージの更新を月次で検出し、自動で PR を作成します。

対象イメージは次のとおりです。

- `postgres`
- `jc21/nginx-proxy-manager`
- `boky/postfix`

作成される PR にはラベル `dependencies` と `docker-compose` が付与されます。`docker-compose` ラベルがリポジトリに存在しない場合、Dependabot が PR 作成時に自動生成します。
