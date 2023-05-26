pipeline: format lint test

format:
	black server --check --diff
	isort server --check-only --diff

lint:
	pylint server/*
	mypy server/

test:
	poetry run python server/manage.py check

requirements:
	poetry export -f requirements.txt --output requirements.txt

dev:
	poetry run python server/manage.py migrate
	poetry run python server/manage.py runserver

build: requirements
	rm -f server/db.sqlit3
	docker build -t hello-world .

run:
	docker run --rm -d -p 8000:8000 --name hello-world hello-world

stop:
	docker stop hello-world
