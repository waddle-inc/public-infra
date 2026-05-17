# ソフトウェア構成 - Waddle Inc. インフラリポジトリ

このファイルでは、主要なソフトウェア構成をまとめています。

## 目次

<!-- toc -->

- [ソフトウェア一覧](#%E3%82%BD%E3%83%95%E3%83%88%E3%82%A6%E3%82%A7%E3%82%A2%E4%B8%80%E8%A6%A7)
- [永続化対象](#%E6%B0%B8%E7%B6%9A%E5%8C%96%E5%AF%BE%E8%B1%A1)
- [更新時の確認ポイント](#%E6%9B%B4%E6%96%B0%E6%99%82%E3%81%AE%E7%A2%BA%E8%AA%8D%E3%83%9D%E3%82%A4%E3%83%B3%E3%83%88)

<!-- tocstop -->

## ソフトウェア一覧

| ソフトウェア            | 用途                       | 主な定義・設定場所                                                                                              |
| ----------------------- | -------------------------- | --------------------------------------------------------------------------------------------------------------- |
| Docker / Compose        | コンテナ実行基盤           | [docker-compose.yml](../docker-compose.yml), [deploy.sh](../deploy.sh)                                          |
| nginx-proxy-manager     | リバースプロキシ・SSL 終端 | [docker-compose.yml](../docker-compose.yml), [docs/deploy.md](deploy.md)                                        |
| PostgreSQL              | データベース               | [docker-compose.yml](../docker-compose.yml), [docs/environment.md](environment.md)                              |
| Postfix（boky/postfix） | SMTP メール送信・DKIM 署名 | [docker-compose.yml](../docker-compose.yml), [docs/deploy.md](deploy.md), [docs/environment.md](environment.md) |

## 永続化対象

- PostgreSQL のデータは Docker ボリュームで永続化されます。
- Postfix の DKIM 鍵は Docker ボリュームで永続化されます。
- nginx-proxy-manager の設定データと証明書は Docker ボリュームで永続化されます。

## 更新時の確認ポイント

- Docker / Compose の更新時は、Compose 仕様互換性と `docker compose config` の結果を確認してください。
- nginx-proxy-manager の更新時は、HTTPS ルーティングと証明書状態、管理 UI へのアクセス可否を確認してください。
- PostgreSQL の更新時は、データ互換性、起動可否、接続先アプリの動作を確認してください。
- Postfix の更新時は、SMTP 送信・DKIM 署名の動作を確認してください。
