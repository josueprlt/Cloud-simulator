# Trip Share Project

Bienvenue dans Trip Share ! Ce projet est une application web full-stack containerisée avec Docker, utilisant Symfony pour l'API backend, Vue.js pour le frontend, et PostgreSQL pour la base de données. Le Makefile inclus simplifie le lancement du projet et les actions de maintenance courantes.

### Prérequis :

 - installer Docker : https://docs.docker.com/engine/install/
 - installer Docker Compose : https://docs.docker.com/compose/install/

### Optionnel :
 - installler Make pour exécuter les commandes définies dans le Makefile : https://www.gnu.org/software/make/

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

#### Details des commandes du make File
        
- make up : Cette commande lance tous les conteneurs en mode détaché et construit les images Docker si nécessaire.
- make down : Arrête et supprime les conteneurs
- make migrate : Exécute les migrations dans le conteneur backend pour s'assurer que le schéma de la base de données est à jour.
- make fixtures : Charge les données de test définies dans les fixtures pour faciliter le développement.
- make logs : Afficher les logs en temps réel
- make install-frontend : Installation des dépendances du frontend

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


#### Voilà ! Avec ce fichier README.md, toute ton équipe aura un guide complet pour lancer et maintenir le projet. 🎉