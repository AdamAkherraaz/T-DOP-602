# MY_MARVIN - Jenkins Configuration as Code

Ce projet est une implémentation du projet T-DOP-602 de configuration automatisée d'une instance Jenkins. 

## Contenu du projet

- `Dockerfile` - Pour construire une image Jenkins personnalisée
- `configuration.yml` - Configuration JCasC (Jenkins Configuration as Code)
- `job_dsl.groovy` - Définition des jobs Jenkins en utilisant Job DSL
- `docker-compose.yml` - Pour faciliter le déploiement
- `test_jcasc.sh` - Script de test pour vérifier la configuration

## Prérequis

- Docker
- Docker Compose

## Installation et démarrage

1. Clonez ce dépôt
2. Exécutez les commandes suivantes:

```bash
# Rendre le script de test exécutable
chmod +x test_jcasc.sh

# Tester la configuration (optionnel)
./test_jcasc.sh

# Démarrer Jenkins
docker-compose up -d

# Vérifier que Jenkins est en cours d'exécution
docker-compose ps
```

3. Accédez à Jenkins via http://localhost:8080

## Fonctionnalités implémentées

1. **Message système personnalisé**: "Hello! Welcome to my Jenkins instance :)"
2. **Utilisateur prédéfini**: 
   - ID: `jigglypuff`
   - Mot de passe: `password`
3. **Jobs préconfigurés**:
   - **Disk Space Check** - Un job qui affiche l'utilisation de l'espace disque
   - **Daily Dose of Satisfaction** - Un job paramétré qui affiche un message personnalisé

## Automatisation de la configuration

La configuration complète de Jenkins est automatisée grâce à:
- **JCasC (Jenkins Configuration as Code)**: Permet de définir la configuration complète de Jenkins dans un fichier YAML
- **Job DSL**: Permet de définir les jobs Jenkins en utilisant un langage de script Groovy

## Notes

- L'instance Jenkins est configurée pour sauter l'assistant de configuration initiale
- Les volumes Docker sont utilisés pour persister les données de Jenkins 