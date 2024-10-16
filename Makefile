NAME = ft_server
DOCKER = docker

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

.PHONY: all build run stop clean fclean re
