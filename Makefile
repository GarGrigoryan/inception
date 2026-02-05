# Variables
LOGIN = mmosoyan
DATA_PATH = /home/$(LOGIN)/data

# Rules
all: up

up: setup
	@docker compose -f srcs/docker-compose.yml up --build -d

setup:
	@mkdir -p $(DATA_PATH)/mariadb
	@mkdir -p $(DATA_PATH)/wordpress

down:
	@docker compose -f srcs/docker-compose.yml down

stop:
	@docker compose -f srcs/docker-compose.yml stop

start:
	@docker compose -f srcs/docker-compose.yml start

# Thorough cleaning for the evaluation
clean: down
	@docker system prune -a --force

fclean: clean
	@sudo rm -rf $(DATA_PATH)
	@docker volume rm srcs_mariadb_data srcs_wordpress_data 2>/dev/null || true

re: fclean all

.PHONY: all up setup down stop start clean fclean re