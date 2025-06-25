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

provisioning: ## Provisioning the execution environment
	$(info --> Deploy app ${APP_NAME})
	ansible-playbook ansible/playbook.yml -i ansible/hosts.ini -t provisioning -l "${APP_NAME}"

deploy: ## Deploy code
	$(info --> Deploy app ${APP_NAME} on env ${SYMFONY_ENV})
	ansible-playbook ansible/playbook.yml -i ansible/hosts.ini -t deploy -e "symfony_env=${SYMFONY_ENV}" -l "${APP_NAME}"

packer-build: ## Build image on gcloud
	$(info --> Deploy app app-symfony on env ...)
	PACKER_FILE=gcloud ./scripts/packer-build.sh

packer-deploy-virtualbox: ## Deploy image on vm virtualbox (sudo escalade without password is required)
	$(info --> Deploy app ${APP_NAME} on env ${SYMFONY_ENV} on virtualbox...)
	PACKER_FILE=local ANSIBLE_GROUPS=${APP_NAME} SYMFONY_ENV=${SYMFONY_ENV:prod} ./scripts/packer-build.sh

install-ansible: ## Install ansible via pip
	$(info --> Install ansible via `pip`)
	@if [ "$$VENV" = "1" ]; then \
		pip install -q -r requirements.txt; \
	else \
		pip install -q --user -r requirements.txt; \
	fi

install-python:
	brew install python@3.12
	/opt/homebrew/opt/python@3.12/bin/python3.12 -m venv ~/.venvs/ansible

check-playbook:
	@ansible-playbook ansible/playbook.yml --syntax-check -i ansible/hosts.ini
	
lint:
	@ansible-lint ansible/playbook.yml
