LOGIN = mmosoyan
DATA_PATH = /home/$(LOGIN)/data

all: up

up: setup
	@docker compose -f srcs/docker-compose.yml up --build -d

setup:
	@sudo mkdir -p $(DATA_PATH)/mariadb
	@sudo mkdir -p $(DATA_PATH)/wordpress
	@sudo mkdir -p $(DATA_PATH)/static_site
	@sudo chown -R $(USER):$(USER) $(DATA_PATH)

down:
	@docker compose -f srcs/docker-compose.yml down

stop:
	@docker compose -f srcs/docker-compose.yml stop

start:
	@docker compose -f srcs/docker-compose.yml start

clean:
	@docker compose -f srcs/docker-compose.yml down --rmi all -v

fclean: clean
	@sudo rm -rf $(DATA_PATH)
	@docker system prune -a --force

re: fclean all

.PHONY: all up setup down stop start clean fclean re