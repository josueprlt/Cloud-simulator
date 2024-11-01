# Makefile pour le projet Trip Share

# Variables
COMPOSE=docker-compose
EXEC_BACKEND=$(COMPOSE) exec backend
EXEC_FRONTEND=$(COMPOSE) exec frontend

# Commandes de base
up:
	$(COMPOSE) up -d --build

down:
	$(COMPOSE) down

logs:
	$(COMPOSE) logs -f

# Commandes pour le backend
migrate:
	$(EXEC_BACKEND) php bin/console doctrine:migrations:migrate --no-interaction

fixtures:
	$(EXEC_BACKEND) php bin/console doctrine:fixtures:load --no-interaction

# Commandes pour le frontend
install-frontend:
	$(EXEC_FRONTEND) npm install

# Commande de démarrage rapide pour le développement
start-dev: up migrate fixtures

