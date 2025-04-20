// Job 1: "Disk Space Check" - Freestyle job qui exécute la commande df
freeStyleJob('Disk Space Check') {
    description('A job that checks disk space usage')
    
    steps {
        shell('df')
    }
}

// Job 2: "Daily Dose of Satisfaction" - Freestyle job avec paramètre et étapes shell
freeStyleJob('Daily Dose of Satisfaction') {
    description('A job to comfort you when needed')
    
    parameters {
        stringParam('NAME', '', 'Your name')
    }
    
    steps {
        // Étape 1: Affiche "Hello dear [NAME]!"
        shell('echo "Hello dear ${NAME}!"')
        
        // Étape 2: Exécute la commande date
        shell('date')
        
        // Étape 3: Affiche "This is your DDoS number [BUILD_NUMBER]."
        shell('echo "This is your DDoS number ${BUILD_NUMBER}."')
    }
} 