.PHONY: help vet

.SILENT:

SHELL := bash -eou pipefail

help:
	awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

vet: ## Run linters, type-checking, auto-formaters, and other tools
	poetry run isort app/
	poetry run black app/
	poetry run flake8 app/
	poetry run mypy app/
	poetry run bandit -r app/