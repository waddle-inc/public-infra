# 環境変数 - Waddle Inc. インフラリポジトリ

このファイルでは、Docker Compose で利用する環境変数をまとめています。

`.env` ファイルには、以下すべての変数を**必ず**設定してください（全て必須）。`.env.example` を参考に作成してください。

## 目次

<!-- toc -->

- [PostgreSQL](#postgresql)
- [Postfix（内部SMTPサーバー）](#postfix%E5%86%85%E9%83%A8smtp%E3%82%B5%E3%83%BC%E3%83%90%E3%83%BC)
- [auth-api](#auth-api)
- [auth-web](#auth-web)
- [tools-api](#tools-api)
- [tools-web](#tools-web)

<!-- tocstop -->

## PostgreSQL

PostgreSQL コンテナの接続情報です。

| 変数名              | 説明                      |
| ------------------- | ------------------------- |
| `POSTGRES_USER`     | PostgreSQL ユーザー名     |
| `POSTGRES_PASSWORD` | PostgreSQL パスワード     |
| `POSTGRES_DB`       | PostgreSQL データベース名 |

## Postfix（内部SMTPサーバー）

Postfix コンテナのメール送信設定です。

| 変数名                           | 説明                                                                                     |
| -------------------------------- | ---------------------------------------------------------------------------------------- |
| `POSTFIX_HOSTNAME`               | Postfix の HELO/EHLO ホスト名（例: `mail.waddle-inc.com`）                               |
| `POSTFIX_ALLOWED_SENDER_DOMAINS` | 送信を許可するドメイン（スペース区切りで複数指定可。例: `"waddle-inc.com example.com"`） |

## auth-api

認証システム API 用の設定です。

| 変数名                         | 説明                                                                    |
| ------------------------------ | ----------------------------------------------------------------------- |
| `AUTH_API_EMAIL_LINK_BASE_URL` | メール本文中のリンク生成に使うベース URL（認証システム WEB のオリジン） |
| `AUTH_API_CORS_ORIGIN`         | CORS の許可するオリジン                                                 |
| `AUTH_API_ALLOWED_CLIENTS`     | SSO の許可クライアント                                                  |
| `AUTH_API_JWT_ACCESS_SECRET`   | JWT のアクセストークンのシークレット                                    |
| `AUTH_API_JWT_REFRESH_SECRET`  | JWT のリフレッシュトークンのシークレット                                |
| `AUTH_API_SMTP_FROM`           | SMTP の送信元メールアドレス                                             |

## auth-web

認証システム WEB 用の設定です。

| 変数名                     | 説明                                                 |
| -------------------------- | ---------------------------------------------------- |
| `AUTH_WEB_API_URL`         | 認証システム API のベース URL（末尾 `/` なし）       |
| `AUTH_WEB_ALLOWED_ORIGINS` | `/logout` の `redirect` 許可オリジン（カンマ区切り） |

## tools-api

ツール API 用の設定です。

| 変数名                         | 説明                                                                                           |
| ------------------------------ | ---------------------------------------------------------------------------------------------- |
| `TOOLS_API_AUTH_API_URL`       | 認証システム API（auth-api）の URL（例: `http://auth-api:8000`）                               |
| `TOOLS_API_JWT_AUDIENCE`       | ツールサービス向けアクセストークンの `aud`（例: `tools`）                                      |
| `TOOLS_API_GEMINI_API_KEY`     | Google Gemini API のキー。Docker Compose が tools-api へ **`GEMINI_API_KEY`** として渡します。 |
| `TOOLS_API_CORS_ALLOW_ORIGINS` | CORS で許可するオリジン（例: `https://tools.waddle-inc.com`）                                  |

tools-api コンテナの `JWT_SECRET` は Docker Compose が **`AUTH_API_JWT_ACCESS_SECRET`** と同じ値を渡します。auth-api が発行したアクセストークンを検証するため、署名鍵は auth-api のアクセストークン用シークレットと一致している必要があります。

## tools-web

ツール WEB フロントエンド用の設定です。

| 変数名                   | 説明                                                                                                                                                              |
| ------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `TOOLS_WEB_API_URL`      | ブラウザから参照するツール API の公開 URL（例: `https://api.tools.waddle-inc.com`）。Docker Compose が tools-web コンテナへ `VITE_API_URL` として渡します。       |
| `TOOLS_WEB_AUTH_WEB_URL` | ブラウザから参照する認証システム WEB の公開 URL（例: `https://auth.waddle-inc.com`）。Docker Compose が tools-web コンテナへ `VITE_AUTH_WEB_URL` として渡します。 |
