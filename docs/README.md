# 設計・運用ドキュメント - Waddle Inc. インフラリポジトリ

このディレクトリでは、インフラの設計・仕様・運用手順に関するドキュメントを管理します。

## ドキュメント一覧

| ドキュメント                       | 説明                                                                                 |
| ---------------------------------- | ------------------------------------------------------------------------------------ |
| [architecture.md](architecture.md) | アーキテクチャ（ディレクトリ構成・ポート・サービス・ルーティング・ネットワーク構成） |
| [environment.md](environment.md)   | Docker Compose で利用する環境変数（`.env.example` など）                             |
| [deploy.md](deploy.md)             | 本番 VPS でのデプロイ手順（`deploy.sh` の運用を含む）                                |
| [operations.md](operations.md)     | 本番サーバーでの運用手順                                                             |
| [platform.md](platform.md)         | 外部サービス・サービス間インタラクション・運用前提ポリシー・依存関係                 |
| [software.md](software.md)         | 主要なソフトウェア構成                                                               |
