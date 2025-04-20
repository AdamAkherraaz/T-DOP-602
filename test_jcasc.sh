#!/bin/bash

# Script pour tester la configuration JCasC

# Vérifiez que tous les fichiers nécessaires existent
echo "Checking required files..."
files_to_check=("Dockerfile" "configuration.yml" "job_dsl.groovy" "docker-compose.yml")
exit_code=0

for file in "${files_to_check[@]}"; do
  if [ -f "$file" ]; then
    echo "✓ $file exists"
  else
    echo "✗ $file does not exist"
    exit_code=1
  fi
done

if [ $exit_code -ne 0 ]; then
  echo "Some required files are missing. Exiting..."
  exit $exit_code
fi

# Vérifier que la configuration YAML est valide
echo "Validating YAML configuration..."
if command -v yamllint &> /dev/null; then
  yamllint -d relaxed configuration.yml
  if [ $? -ne 0 ]; then
    echo "YAML configuration is invalid. Please fix the issues and try again."
    exit 1
  else
    echo "✓ YAML configuration is valid"
  fi
else
  echo "yamllint not found. Skipping YAML validation."
fi

# Vérifier que le fichier groovy est valide
echo "Validating Groovy script..."
if command -v groovy &> /dev/null; then
  groovy -e "new GroovyShell().parse(new File('job_dsl.groovy')); println '✓ Groovy script is valid'"
  if [ $? -ne 0 ]; then
    echo "Groovy script is invalid. Please fix the issues and try again."
    exit 1
  fi
else
  echo "groovy not found. Skipping Groovy validation."
fi

echo "All tests passed. Configuration is ready to use."
exit 0 