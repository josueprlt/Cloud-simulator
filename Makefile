# Makefile pour le projet Trip Share

# Variables
COMPOSE=docker-compose
EXEC_BACKEND=$(COMPOSE) exec backend
EXEC_FRONTEND=$(COMPOSE) exec frontend

# Commandes de base

# Construire les conteneurs
build:
	$(COMPOSE) build

# Démarrer les conteneurs
start:
	$(COMPOSE) up -d

# Arrêter les conteneurs
down:
	$(COMPOSE) down

# Afficher les logs en temps réel
logs:
	$(COMPOSE) logs -f

# Appliquer les migrations de la base de données
migrate:
	$(EXEC_BACKEND) php bin/console doctrine:migrations:migrate --no-interaction

# Charger les fixtures de test
fixtures:
	$(EXEC_BACKEND) php bin/console doctrine:fixtures:load --no-interaction

# Nettoyer les conteneurs et les volumes pour repartir à zéro
clean:
	$(COMPOSE) down -v

# Commandes pour le frontend

# Installer les dépendances frontend
install-frontend:
	$(EXEC_FRONTEND) npm install

# Lancer le serveur de développement pour le frontend
start-frontend:
	$(EXEC_FRONTEND) npm run serve

# Commande de démarrage rapide pour le développement
start-dev: build start migrate fixtures install-frontend start-frontend
