.PHONY: all build setup-db run stop

all: build setup-db

build:
	@echo "+\n++ Make: Building the app...\n+"
	@npm install --prefix ./frontend
	@docker-compose build

setup-db:
	@echo "+\n++ Make: Setting up the database...\n+"
	@docker-compose up -d db
	@docker-compose run backend rake db:create
	@docker-compose run backend rake db:migrate
	@docker-compose run backend rake db:seed

run:
	@echo "+\n++ Make: Running the app...\n+"
	@docker-compose up

stop:
	@echo "+\n++ Make: Stopping the app...\n+"
	@docker-compose down
