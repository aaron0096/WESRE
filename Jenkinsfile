pipeline {
    agent any

    stages {
        stage('Build environment') {
            steps {
                sh '''
                echo 'Building environment'
                sudo docker pull python
                '''
            }
        }
        stage('Test'){
            steps {
                echo 'Starting test 1'
            }
        }
        stage('Test 2'){
            steps {
                echo 'Starting test 2'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying'
                echo 'Placeholder code for deployment to ??? server'
            }
        }
    }
}
