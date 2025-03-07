# Trip Share Project

Bienvenue dans Trip Share ! Ce projet est une application web full-stack containerisée avec Docker, utilisant Symfony pour l'API backend, Vue.js pour le frontend, et PostgreSQL pour la base de données. Le Makefile inclus simplifie le lancement du projet et les actions de maintenance courantes.

### Prérequis :

 - installer Docker : https://docs.docker.com/engine/install/
 - installer Docker Compose : https://docs.docker.com/compose/install/

### Optionnel :
 - installler Make pour exécuter les commandes définies dans le Makefile : https://www.gnu.org/software/make/
 - installer python3 pour avoir acces au venv

### Installation :

Via ssh (recommander):
```
git clone git@github.com:Antony35/trip-share.git
```

Via html :
```
git clone https://github.com/Antony35/trip-share.git 
```
Se rendre dans le dossier :
```
cd trip-share
```

### Lancer les conteneurs Docker :

Pour démarrer le projet avec les conteneurs Docker et appliquer les migrations et les fixtures de test :

```
 make start-dev 
```

### Install requirements

python(3) -m venv .venv
.venv\Scripts\activate (windows avec powershell)

pip install -r requirements.txt

#### Details des commandes du make File

- make build : Construit tous les conteneurs définis dans le fichier docker-compose, en téléchargeant les images et en préparant les conteneurs pour l'exécution.
- make start : Démarre les conteneurs en mode détaché (en arrière-plan).
- make down : Arrête et supprime tous les conteneurs du projet.
- make logs : Affiche les logs de tous les conteneurs en temps réel pour aider au suivi des processus.
- make migrate : Exécute les migrations dans le conteneur backend pour mettre à jour le schéma de la base de données.
- make fixtures : Charge les fixtures (données de test) dans la base de données.
- make clean : Arrête et supprime tous les conteneurs ainsi que les volumes pour un nettoyage complet du projet.
- make install-frontend : Installe les dépendances npm du frontend dans le conteneur frontend.
- make start-frontend : Démarre le serveur de développement pour l'application frontend (Vue.js).

` Note : Lors du premier démarrage, la construction des conteneurs peut prendre quelques minutes.`

#### Accéder à l'Application :
- Frontend (Vue.js) : http://localhost:8080
- Backend API (Symfony) : http://localhost:8000/api

### Si vous préférez exécuter les commandes Docker manuellement, voici quelques commandes utiles :

Exécuter une commande dans le conteneur backend :

```
docker exec -it trip-share-backend-1 php bin/console doctrine:migrations:migrate
```

Exécuter une commande dans le conteneur frontend :

```
docker exec -it trip-share-frontend-1 sh
```
#### Notes pour les Collaborateurs

- Migrations : Assurez-vous de toujours appliquer les migrations après avoir récupéré une mise à jour contenant des modifications des entités. pour verifier dans le container back lancer php bin/console do:mi:li 
- Fixtures : Les données de test sont chargées automatiquement avec make start-dev, mais vous pouvez aussi les recharger avec make fixtures à tout moment.
- Dependence : lors des mises à jour, vérifier les dépendances (`composer install` pour Symfony et `npm install` pour Vue.js) dans les conteneurs respectifs.
- Authentification par jwt : Générer les paires clés/phrase pour générer des jetons JWT : php bin/console lexik:jwt:generate-keypair


#### Voilà ! Avec ce fichier README.md, toute ton équipe aura un guide complet pour lancer et maintenir le projet. 🎉