#!/bin/bash

# Script d'installation et de démarrage pour MY_MARVIN

echo "MY_MARVIN - Jenkins Configuration as Code"
echo "=========================================="

# Vérification de Docker
if ! command -v docker &> /dev/null; then
    echo "Docker n'est pas installé. Veuillez l'installer avant de continuer."
    exit 1
fi

# Vérification de Docker Compose
if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose n'est pas installé. Veuillez l'installer avant de continuer."
    exit 1
fi

# Rendre les scripts exécutables
chmod +x test_jcasc.sh

# Tester la configuration
echo "Test de la configuration..."
./test_jcasc.sh
if [ $? -ne 0 ]; then
    echo "Le test de configuration a échoué. Vérifiez les erreurs ci-dessus."
    exit 1
fi

# Arrêter l'instance Jenkins si elle est en cours d'exécution
echo "Arrêt de l'instance Jenkins si elle est en cours d'exécution..."
docker-compose down

# Construire et démarrer l'instance Jenkins
echo "Construction et démarrage de l'instance Jenkins..."
docker-compose up --build -d

# Vérifier que Jenkins est en cours d'exécution
echo "Vérification de l'état de Jenkins..."
sleep 5
docker-compose ps

# Afficher l'URL d'accès
echo ""
echo "Jenkins est accessible à l'adresse: http://localhost:8080"
echo "Utilisateur: jigglypuff"
echo "Mot de passe: password"
echo ""
echo "Installation terminée!" 