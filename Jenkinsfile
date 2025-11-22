pipeline {
    agent any

    tools {
        nodejs "node16"
    }

    environment {
        AWS_CREDS = credentials('aws-creds')
        AWS_ACCESS_KEY_ID     = "${AWS_CREDS_USR}"
        AWS_SECRET_ACCESS_KEY = "${AWS_CREDS_PSW}"
    }

    stages {

        stage("Checkout") {
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

        stage("Docker Build & Push") {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-creds') {
                        def customImage = docker.build("honey120ar/carrental:latest")
                        customImage.push()
                    }
                }
            }
        }

        stage("Terraform Init, Validate & Apply") {
            steps {
                sh """
                    cd terraform
                    terraform init
                    terraform validate
                    terraform apply -auto-approve
                """
            }
        }

        stage('Get Terraform Outputs') {
            steps {
                script {
                    def public_ip = sh(
                        script: "cd terraform && terraform output -raw ec2_public_ip",
                        returnStdout: true
                    ).trim()

                    env.EC2_PUBLIC_IP = public_ip
                    echo "EC2 Public IP = ${env.EC2_PUBLIC_IP}"
                }
            }
        }

        stage('Create Dynamic Inventory') {
            steps {
                withCredentials([
                    sshUserPrivateKey(credentialsId: 'ec2-minikube-key', keyFileVariable: 'SSH_KEY')
                ]) {
                    sh """
                        cd ansible
                        echo "[server]" > inventory.ini
                        echo "${EC2_PUBLIC_IP} ansible_user=ec2-user ansible_ssh_private_key_file=${SSH_KEY}" >> inventory.ini
                        cat inventory.ini
                    """
                }
            }
        }

        stage('Run Ansible') {
            steps {
                withCredentials([
                    sshUserPrivateKey(credentialsId: 'ec2-minikube-key', keyFileVariable: 'SSH_KEY')
                ]) {
                    sh """
                        cd ansible
                        ansible-playbook -i inventory.ini docker-minikube.yml --private-key ${SSH_KEY}
                    """
                }
            }
        }

        stage('Deploying on EC2 Minikube Cluster') {
            steps {
                script {
                    env.MINIKUBE_IP = env.EC2_PUBLIC_IP
                }

                withCredentials([
                    sshUserPrivateKey(credentialsId: 'ec2-minikube-key', keyFileVariable: 'SSH_KEY')
                ]) {
                    sh """
                        cd k8s-manifest

                        echo "Copying deployment file..."
                        scp -i ${SSH_KEY} -o StrictHostKeyChecking=no deployment.yaml ec2-user@${MINIKUBE_IP}:/home/ec2-user/

                        echo "Deleting old deployment..."
                        ssh -i ${SSH_KEY} -o StrictHostKeyChecking=no ec2-user@${MINIKUBE_IP} "kubectl delete -f /home/ec2-user/deployment.yaml --ignore-not-found=true"

                        echo "Applying new deployment..."
                        ssh -i ${SSH_KEY} -o StrictHostKeyChecking=no ec2-user@${MINIKUBE_IP} "kubectl apply -f /home/ec2-user/deployment.yaml"
                    """
                }
            }
        }

    } // stages
} // pipeline
