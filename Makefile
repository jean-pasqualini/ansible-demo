SHELL := /usr/bin/env bash

help:
	$(info Configuration)
	$(info -------------)
	$(info - SYMFONY_ENV=(prod|dev|test))
	$(info - APP_NAME=(app-knp|app-symfony))
	$(info )
	@grep -E '^[a-zA-Z1-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN { FS = ":.*?## " }; { printf "\033[36m%-30s\033[0m %s\n", $$1, $$2 }'

get-ansible-vendor: ## Install ansible galaxy dependencies
	$(info --> Get Ansible vendors)
	ansible-galaxy install -r ansible/requirements-ansible.yml -p ansible/vendor/roles --force

deploy: ## Deploy code
	$(info --> Deploy app ${APP_NAME} on env ${SYMFONY_ENV})
	ansible-playbook ansible/playbook.yml -i ansible/hosts.ini -t deploy -e "symfony_env=${SYMFONY_ENV}" -l "${APP_NAME}"

composer: ## Install dependencies of app
	$(info --> Deploy app ${APP_NAME} on env ${SYMFONY_ENV})
	ansible-playbook ansible/playbook.yml -i ansible/hosts.ini -t composer -e "symfony_env=${SYMFONY_ENV}" -l "${APP_NAME}"

packer-build: ## Build image on gcloud
	$(info --> Deploy app app-symfony on env ...)
	./scripts/packer-build.sh

install-ansible: ## Install ansible via pip
	$(info --> Install ansible via `pip`)
	@if [[ "$$CI" -eq 1 ]]; then \
		pip install -q -r requirements.txt; \
	else \
		pip install -q --user -r requirements.txt; \
	fi