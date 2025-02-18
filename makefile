dc          = docker-compose$(1)$(2)
dc-run-rm   = $(call dc, run --rm web$(1)$(2))
dc-run-test = $(call dc, run --rm test$(1)$(2))
args        = $(shell arg="$(filter-out $@,$(MAKECMDGOALS))" && echo $${arg:-${1}})

.ONESHELL:
.DEFAULT_GOAL := usage

usage:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
  | column -t  -s '##'

# Setup with DB
setup: ## Initiates everything (builds images, installs gems, creats and migrats db)
	make build
	make db-prepare

build: ## Builds the image
	make rm-app-volumes
	docker build --ssh default -t community_app:0.0.1 .
	make bundle
	make yarn

# docker-compose
up: ## Builds and runs the development server or runs service given via argument
	$(call dc, up -d $(if $(args),$(args),web) )
rebuild: ## Rebuilds and restarts the development server (alias for 'make build up')
	make build
	make up
sh: ## Fires a shell inside a service that was passed via argument (default: web)
	$(call dc, run --rm $(if $(args),$(args),web), sh)
restart: ## Restarts a service that was passed via argument (default: development server)
	$(call dc, restart $(if $(args),$(args),web webpacker))
rm-app-volumes: ## Stops the development server and removes bundle and node modules data volumes
	make stop
	$(call dc, rm -f web webpacker)
	docker volume rm -f community-app_bundle_data community-app_node_modules_data
stop: ## Stops all services given via argument (default: development server)
	$(call dc, stop $(if $(args),$(args),web webpacker))
down: ## Removes all containers and tears down the setup
	$(call dc, down --remove-orphans)

# Rails
bundle: ## Installs missing gems or deal with gem given via argument
	$(call dc-run-rm, bundle, $(args))
yarn: ## Installs missing node modules or deal with module given via argument
	$(call dc-run-rm, yarn, $(args))
rails: ## Runs rails command (with arguments, default: --tasks)
	$(call dc-run-rm, bundle exec rails, $(if $(args),$(args),--tasks))
console: ## Runs rails console (add 'sandbox' as an argument to start it in sandbox mode)
	$(call dc-run-rm, bundle exec rails console, --$(args))
rails-cache-clear: ## Runs rails command and cleans rails cache
	$(call dc-run-rm, bundle exec rails r 'Rails.cache.clear')
rake: ## Runs rake task (with arguments, default: --tasks)
	$(call dc-run-rm, bundle exec rake, $(if $(args),$(args),--tasks))
tmp-clear: ## Clear all files from tmp
	$(call dc-run-rm, bundle exec rails tmp:clear)

# Database
db-prepare: ## Prepares the database: create, seed and migrate
	$(call dc-run-rm, bundle exec rails db:prepare)
db-create: ## Creates the dev and test database
	$(call dc-run-rm, bundle exec rails db:create)
db-migrate: ## Runs the migrations for dev database
	$(call dc-run-rm, bundle exec db:migrate)

# logs
logs: ## Displays logs of all services or service given via argument
	$(call dc, logs -tf --tail=20, $(args))
logs-clear: ## Truncates all *.log files in log/ to zero bytes
	$(call dc-run-rm, bundle exec rails log:clear)

# Tests
.PHONY: test
test: ## Runs all tests or tests given via argument
	$(call dc-run-test, bundle exec rails test, $(args))
test-coverage: ## Runs all tests with coverage
	$(call dc-run-test, bundle exec rails test COVERAGE=true)
