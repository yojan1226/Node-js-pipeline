# Node.js CI/CD Project with Automated Infrastructure

This project demonstrates a complete **CI/CD pipeline for a Node.js application**, including automated infrastructure provisioning, containerization, and deployment on Kubernetes (Minikube) using **Jenkins, Terraform, Docker, Ansible, and Kubernetes**.

---

## Overview

The pipeline automates the full lifecycle of the Node.js application:

1. Pulls code from GitHub.
2. Installs dependencies, runs tests, and builds the application.
3. Packages the application into a Docker container and pushes it to a registry.
4. Provisions infrastructure on AWS using Terraform.
5. Configures EC2 instances with Docker and Minikube via Ansible.
6. Deploys the application to a Minikube Kubernetes cluster.

This setup ensures that infrastructure provisioning, application deployment, and testing are **fully automated**.

---

## Tools Used

- **Node.js** – Application runtime  
- **Jenkins** – CI/CD automation  
- **Docker** – Containerization  
- **Terraform** – Infrastructure as Code (IaC)  
- **Ansible** – Configuration management  
- **Kubernetes (Minikube)** – Local cluster deployment  
- **AWS** – Cloud infrastructure  
- **GitHub** – Source code management  

---

## How It Works

1. **Developer pushes code to GitHub**.
2. **Jenkins fetches the repository**.
3. **Jenkins pipeline executes the following stages**:

| Stage | Description |
|-------|------------|
| Checkout | Pull latest code from GitHub |
| NPM Install | Install project dependencies (`npm install`) |
| Test | Run unit tests (`npm test`) |
| Build | Build the Node.js application (`npm run build`) |
| Docker Build | Build Docker image (`docker build -t <image>:<tag> .`) |
| Docker Push | Push image to container registry (`docker push <image>:<tag>`) |
| Terraform Init | Initialize Terraform (`terraform init`) |
| Terraform Validate | Validate Terraform configuration (`terraform validate`) |
| Terraform Apply | Provision infrastructure (`terraform apply -auto-approve`) |
| Ansible | Install Docker, Minikube, and kubectl on EC2 |
| Kubernetes Deploy | Deploy application on Minikube (`kubectl apply -f k8s/`) |

---

## Credentials

- Store **AWS credentials** in Jenkins (Credentials ID: `aws-creds`) for Terraform operations.
- Configure Docker registry credentials if pushing to a private registry.

---

## Running the Pipeline

1. Commit your **Node.js code, Terraform, and Jenkinsfile** to GitHub.
2. Trigger the Jenkins pipeline manually or automatically on commit.
3. Monitor progress via **Jenkins Stage View**.
4. Application will be deployed on **Minikube** automatically once all stages complete.

---



