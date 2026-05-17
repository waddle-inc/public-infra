.PHONY: help setup setup-no-mise toc format lint check
.DEFAULT_GOAL := help

help: ## 使用可能なコマンドを表示
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-16s\033[0m %s\n", $$1, $$2}'

setup: ## 環境構築（mise導入前提）
	mise install
	pnpm install
	@if [ -f .env ]; then \
		echo ".envは既に存在するためスキップします。"; \
	else \
		cp .env.example .env && echo ".envを作成しました。"; \
	fi

setup-no-mise: ## 環境構築（mise未導入前提）
	pnpm install
	@if [ -f .env ]; then \
		echo ".envは既に存在するためスキップします。"; \
	else \
		cp .env.example .env && echo ".envを作成しました。"; \
	fi

toc: ## 目次自動生成
	pnpm toc

format: ## フォーマット整形
	pnpm format

lint: ## 静的解析
	pnpm lint

check: ## 目次自動生成・フォーマット整形・静的解析
	$(MAKE) toc
	$(MAKE) format
	$(MAKE) lint

