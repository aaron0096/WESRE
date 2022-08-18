pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building'
                echo 'Python 3 generally does not require building? According to online.'
                echo 'Step is skipped to go straight to testing.'
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
