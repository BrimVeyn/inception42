# Variables
DOCKER_COMPOSE_FILE = srcs/docker-compose.yml
DOCKER_COMPOSE = sudo docker-compose -f $(DOCKER_COMPOSE_FILE)
ENV_FILE = srcs/.env

# Couleurs
GREEN = \033[0;32m
YELLOW = \033[0;33m
RED = \033[0;31m
BLUE = \033[0;34m
NC = \033[0m

# Cibles
.PHONY: all build up down start stop restart logs clean rebuild

# Construire tous les services
build:
	@printf "$(BLUE)Building all services...$(NC)\n"
	@$(DOCKER_COMPOSE) --env-file $(ENV_FILE) build

# Démarrer tous les services
up:
	@printf "$(GREEN)Starting all services...$(NC)\n"
	@$(DOCKER_COMPOSE) --env-file $(ENV_FILE) up -d

# Arrêter tous les services
down:
	@printf "$(RED)Stopping all services...$(NC)\n"
	@$(DOCKER_COMPOSE) --env-file $(ENV_FILE) down

# Démarrer les services (sans les construire)
start:
	@printf "$(GREEN)Starting services...$(NC)\n"
	@$(DOCKER_COMPOSE) --env-file $(ENV_FILE) start

# Arrêter les services
stop:
	@printf "$(RED)Stopping services...$(NC)\n"
	@$(DOCKER_COMPOSE) --env-file $(ENV_FILE) stop

# Redémarrer les services
restart:
	@printf "$(YELLOW)Restarting services...$(NC)\n"
	@$(DOCKER_COMPOSE) --env-file $(ENV_FILE) restart

# Afficher les logs des services
logs:
	@printf "$(BLUE)Displaying logs...$(NC)\n"
	@$(DOCKER_COMPOSE) --env-file $(ENV_FILE) logs -f

# Nettoyer les conteneurs, les réseaux et les volumes
clean:
	@printf "$(RED)Cleaning up...$(NC)\n"
	@$(DOCKER_COMPOSE) --env-file $(ENV_FILE) down -v --rmi all --remove-orphans

# Reconstruire et redémarrer tous les services
rebuild: clean build up

# Par défaut, construire et démarrer les services
all: build up
