pipeline {
    agent any

    tools {
        nodejs "node16"
    }

    stages {

        stage("checkout") {
            steps {
                git 'https://github.com/yojan1226/Node-js-pipeline.git'
            }
        }

        stage("NPM install") {
            steps {
                sh 'npm install'
            }
        }

        stage("NPM test") {
            steps {
                sh 'npm test'
            }
        }

        stage("NPM build") {
            steps {
                sh 'npm run build'
            }
        }

        stage('Docker Build & Push') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-creds') {
                        def customImage = docker.build("honey120ar/carrental:latest")
                        customImage.push()
                    }
                }
            }
        }





    }//stages
}//pipeline