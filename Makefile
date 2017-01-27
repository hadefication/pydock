init:
	make project
	cp ./stubs/postgress.py ./src/settings.py
	ls -la
	make start
project:
	docker-compose run web django-admin.py startproject src .
app:
	docker exec pyweb mkdir /code/apps/$(name)
	docker exec pyweb python manage.py startapp $(name) /code/apps/$(name)
	cp ./stubs/urls.py ./apps/$(name)
	cp ./stubs/views.py ./apps/$(name)
start:
	docker-compose start
stop:
	docker-compose stop
connect:
	docker exec -it pyweb bash
migrate:
	docker exec pyweb python manage.py migrate
reset:
	rm -rf src
	rm manage.py
	make stop
	docker rmi pydock_web python:2.7
