NAME = inception
ENV		=	srcs/.env
COMPOSE	=	srcs/docker-compose.yaml
LOGIN	=	rmiranda
DATA_PATH	=	$(HOME)/$(LOGIN)/data

export $(DATA_PATH)

all: $(ENV) up

setup: $(ENV)
	mkdir -p $(DATA_PATH)/wordpress
	mkdir -p $(DATA_PATH)/mariadb
	grep VOLUMES_PATH srcs/.env || echo "VOLUMES_PATH=$(DATA_PATH)" >> srcs/.env

up: setup
	docker compose --file=$(COMPOSE) up --build --detach

down:
	docker compose down

$(ENV):
	@echo "missing .env in srcs directory"

clean:

fclen:

re:

.PHONY: all setup up down clean fclean re
