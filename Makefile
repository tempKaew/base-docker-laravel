dc_conf=-f docker-compose.yml --env-file .env
project_name=-p $(shell basename $(CURDIR))

.PHONY: default
default: help

.PHONY: help
help: ## This help
	@echo 'Available "make" commands:'
	@grep -E '^[a-zA-Z_-]+:(.*?## .*)*$$' $(MAKEFILE_LIST) | sed -e 's/Makefile://' -e 's/:/##/g' | sort | awk 'BEGIN {FS = "##"}; {printf "\033[36m%-30s\033[0m %-30s %s\n", $$1, $$3,$$4}'
	@echo
	@echo 'Run "make help" to see this doc'
	@echo

.PHONY: init-project
init-project: ## Initialize the project
	cp .env.example .env
	docker compose $(dc_conf) $(project_name) up -d