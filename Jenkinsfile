pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building'
            }
        }
        stage('Test'){
            steps {
                echo 'Testing'
                sh 'python3 --version'
                sh 'python3 FizzBuzz.py'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying'
            }
        }
    }
}
