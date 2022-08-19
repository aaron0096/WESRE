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
                echo 'Starting test 1'
                sh 'python3 --version'
                sh 'python3 FizzBuzz.py'
                sh 'flake8 --version'
                sh 'flake8 --statistics FizzBuzz.py'
            }
        }
        stage('Test 2'){
            steps {
                echo 'Starting test 2'
                sh "python3 'Py3 Exercises'/prime_numbers.py"
                sh "flake8 --statistics 'Py3 Exercises'/prime_numbers.py"
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying'
            }
        }
    }
}
