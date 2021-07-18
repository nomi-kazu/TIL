# Docker
build:
	docker-compose -f docker-compose.yaml build

up:
	docker-compose -f docker-compose.yaml up

down:
	docker-compose -f docker-compose.yaml down

dbset:
	docker-compose run api rails db:environment:set RAILS_ENV=development


# Vue
npminstall:
	docker-compose run front npm install

lint:
	docker-compose run front npm run lint
	

# Rails 
migrate:
	docker-compose run api rails db:migrate

rollback:
	docker-compose run api rails db:rollback

migratereset:
	docker-compose run api rails db:migrate:reset

seed:
	docker-compose run api rails db:seed

seedreset:
	docker-compose run api rails db:reset

bundleinstall:
	docker-compose run api bundle install
