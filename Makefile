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

# Vérifier que la base de données est prête
wait-for-database:
	@echo "Waiting for database to be ready..."
	@until $(COMPOSE) exec -T database pg_isready -U postgres; do \
		echo "Database is not ready. Retrying in 2 seconds..."; \
		sleep 2; \
	done
	@echo "Database is ready!"

# Installer les dépendances backend
install-backend:
	$(EXEC_BACKEND) composer install

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
	$(COMPOSE) run --rm frontend npm install

# Commande pour redémarrer le conteneur frontend si nécessaire
restart-frontend:
	$(COMPOSE) up -d frontend

# Lancer le serveur de développement pour le frontend
start-frontend: restart-frontend
	$(EXEC_FRONTEND) npm run serve

# Commande de démarrage rapide pour le développement
start-dev: build start wait-for-database install-backend migrate fixtures install-frontend start-frontend
