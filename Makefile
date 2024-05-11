NAME = inception
ENV		=	srcs/.env
COMPOSE	=	srcs/docker-compose.yaml
LOGIN	=	rmiranda
DATA_PATH	=	$(HOME)/$(LOGIN)/data

ifeq ($(shell uname),Darwin)
VOLUMES_PATH	:= $(HOME)/data
endif

export $(DATA_PATH)

all: $(ENV) up

up: setup
	docker compose --file=$(COMPOSE) up --build --detach

setup: $(ENV)
	mkdir -p $(DATA_PATH)/wordpress
	mkdir -p $(DATA_PATH)/mariadb
	grep VOLUMES_PATH srcs/.env || echo "VOLUMES_PATH=$(DATA_PATH)" >> srcs/.env

$(ENV):
	@echo "missing .env in srcs directory"

down:
	cd srcs && docker compose down -v

vdown:
	cd srcs && docker compose down -v

clean: down

fclean: vdown

re: fclean all

.PHONY: all setup up down vdown clean fclean re
