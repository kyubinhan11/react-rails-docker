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

# Commands used to generate projects
# docker-compose run backend rails new . --force --no-deps  -T -a --database=postgresql
# create-react-app frontend

# Useful commands
# docker-compose run db sh
# docker-compose run backend sh
# docker-compose exec db psql -U postgres -W backend_development