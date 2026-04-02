#  Cloud-Native Microservices Platform (ECS + Terraform + CI/CD)

## 📖 Overview

This project implements a production-ready cloud-native microservices architecture using AWS.  
Both frontend and backend services are containerized using Docker and deployed on Amazon ECS Fargate.  
Infrastructure is provisioned using Terraform, and CI/CD pipelines are implemented using GitHub Actions.

##  Architecture Diagram

##  Architecture Summary

- Fully containerized application (Frontend + Backend)
- Amazon ECS Fargate for serverless container orchestration
- Application Load Balancer for traffic routing
- Amazon RDS (PostgreSQL) for persistent storage
- Amazon ECR for container image storage
- Terraform for Infrastructure as Code
- GitHub Actions for CI/CD automation
- CloudWatch for logging and monitoring


## Tech Stack

- AWS (ECS, ALB, RDS, ECR, CloudWatch, VPC, IAM)
- Terraform
- Docker
- GitHub Actions
- FastAPI (Backend)
- React + Nginx (Frontend)
- PostgreSQL

##  CI/CD Pipeline

### Backend Pipeline
- Run tests
- Build Docker image
- Push image to Amazon ECR
- Deploy to ECS service

### Frontend Pipeline
- Build React application
- Package with Nginx
- Build Docker image
- Push image to ECR
- Deploy to ECS service

### Infrastructure Pipeline
- Terraform init, plan, and apply
- Manage infrastructure changes

## 🛠️ Deployment Instructions

### Prerequisites

- AWS CLI configured
- Terraform installed
- Docker installed
- GitHub repository with secrets configured

---

### Deploy Infrastructure

```bash
cd terraform
terraform init
terraform apply -auto-approve

### Build and Push Docker Images