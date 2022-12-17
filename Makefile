.PHONY: help run vet

.SILENT:

SHELL := bash -eou pipefail

ifeq ($(shell command -v docker-compose;),)
	COMPOSE := docker compose
else
	COMPOSE := docker-compose
endif

help:
	awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

run: ## Run the project using docker-compose
	$(COMPOSE) up --build

vet: ## Run linters, type-checking, auto-formaters, and other tools
	poetry run isort app/
	poetry run black app/
	poetry run flake8 app/
	poetry run mypy app/
	poetry run bandit -r app/