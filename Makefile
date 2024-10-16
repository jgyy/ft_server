NAME = ft_server
DOCKER = docker
OPENSSL = openssl

all: build

build:
	$(DOCKER) build -t $(NAME) .

run:
	$(DOCKER) run -d -p 80:80 -p 443:443 --name $(NAME) $(NAME)

stop:
	$(DOCKER) stop $(NAME)

clean:
	$(DOCKER) rm $(NAME)

fclean: clean
	$(DOCKER) rmi $(NAME)

re: fclean all

ssl:
	$(OPENSSL) req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout srcs/server.key \
		-out srcs/server.crt \
		-subj "/C=US/ST=State/L=City/O=Organization/OU=Unit/CN=localhost"

.PHONY: all build run stop clean fclean re ssl
