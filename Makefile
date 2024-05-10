NAME = inception
ENV		=	srcs/.env

all: $(ENV)

$(ENV):
	@echo "missing .env in srcs directory"

clean:

fclen:

re:

.PHONY: all clean fclean re
