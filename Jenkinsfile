pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
            }
        }
        stage('Integration') {
            steps {
                junit 'test-results.xml'
            }
        }
        stage('Ignored') {
            steps {
                withChecks('Integration Tests') {
                junit 'yet-more-test-results.xml'
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
