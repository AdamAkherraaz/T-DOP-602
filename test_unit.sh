#!/bin/bash

# Script de tests unitaires pour MY_MARVIN

echo "Exécution des tests unitaires pour MY_MARVIN"
echo "==========================================="

# Fonction pour les tests
run_test() {
  local test_name=$1
  local test_cmd=$2
  local expected_exit_code=${3:-0}
  
  echo -n "Test: $test_name ... "
  eval "$test_cmd" > /tmp/test_output 2>&1
  local exit_code=$?
  
  if [ $exit_code -eq $expected_exit_code ]; then
    echo "OK"
    return 0
  else
    echo "ÉCHEC (code: $exit_code, attendu: $expected_exit_code)"
    echo "Sortie:"
    cat /tmp/test_output
    return 1
  fi
}

# Initialisation
failed_tests=0
total_tests=0

# Test 1: Vérifier la présence des fichiers requis
run_test "Présence des fichiers requis" "[ -f Dockerfile ] && [ -f configuration.yml ] && [ -f job_dsl.groovy ] && [ -f docker-compose.yml ]"
if [ $? -ne 0 ]; then
  failed_tests=$((failed_tests + 1))
fi
total_tests=$((total_tests + 1))

# Test 2: Vérifier la syntaxe du Dockerfile
run_test "Syntaxe du Dockerfile" "docker run --rm -i hadolint/hadolint < Dockerfile || true"
if [ $? -ne 0 ]; then
  failed_tests=$((failed_tests + 1))
fi
total_tests=$((total_tests + 1))

# Test 3: Vérifier que le fichier YAML a la structure attendue
run_test "Structure YAML" "grep -q 'systemMessage' configuration.yml && grep -q 'jigglypuff' configuration.yml"
if [ $? -ne 0 ]; then
  failed_tests=$((failed_tests + 1))
fi
total_tests=$((total_tests + 1))

# Test 4: Vérifier que les jobs sont définis dans le fichier DSL
run_test "Définition des jobs DSL" "grep -q 'Disk Space Check' job_dsl.groovy && grep -q 'Daily Dose of Satisfaction' job_dsl.groovy"
if [ $? -ne 0 ]; then
  failed_tests=$((failed_tests + 1))
fi
total_tests=$((total_tests + 1))

# Test 5: Vérifier que le script shell existe
run_test "Présence du script de test" "[ -f test_jcasc.sh ] && [ -x test_jcasc.sh ]"
if [ $? -ne 0 ]; then
  failed_tests=$((failed_tests + 1))
fi
total_tests=$((total_tests + 1))

# Résumé des tests
echo ""
echo "Résultats des tests: $((total_tests - failed_tests))/$total_tests tests réussis"

if [ $failed_tests -eq 0 ]; then
  echo "Tous les tests ont réussi!"
  exit 0
else
  echo "$failed_tests tests ont échoué."
  exit 1
fi 