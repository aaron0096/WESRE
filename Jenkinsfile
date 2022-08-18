pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
            }
        }
        stage('Integration') {
              junit 'test-results.xml'
        }

        junit 'more-test-results.xml'

        stage('Ignored') {
              withChecks('Integration Tests') {
                junit 'yet-more-test-results.xml'
              }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
