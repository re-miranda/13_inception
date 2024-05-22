NAME	=	inception
ENV		=	srcs/.env
COMPOSE	=	srcs/docker-compose.yaml
LOGIN	=	rmiranda
VOLUMES_PATH	=	$(HOME)/$(LOGIN)/data

ifeq ($(shell uname),Darwin)
VOLUMES_PATH	= $(HOME)/data
endif

export $(VOLUMES_PATH)

all: $(ENV) up hosts

hosts:
	-@if ! grep "rmiranda.42.fr" /etc/hosts; then \
	sudo sed -i '2i\127.0.0.1\trmiranda.42.fr' /etc/hosts; \
	fi

up: setup
	cd srcs && docker compose up -d

setup: $(ENV)
	mkdir -p $(VOLUMES_PATH)/wordpress
	mkdir -p $(VOLUMES_PATH)/mariadb
	grep VOLUMES_PATH srcs/.env || echo "VOLUMES_PATH=$(VOLUMES_PATH)" >> srcs/.env

$(ENV):
	@echo "missing .env in srcs directory"

down:
	cd srcs && docker compose down

vdown:
	cd srcs && docker compose down -v

clean: down

fclean: vdown
	rm -rf $(VOLUMES_PATH)/wordpress
	rm -rf $(VOLUMES_PATH)/mariadb

re: fclean all

.PHONY: all setup up down vdown clean fclean re hosts
