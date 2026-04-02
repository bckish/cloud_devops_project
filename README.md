# :rocket: Cloud-Native Microservices Platform (ECS + Terraform + CI/CD)

## :book:Overview

This project implements a production-ready cloud-native microservices architecture using AWS.  
Both frontend and backend services are containerized using Docker and deployed on Amazon ECS Fargate.  
Infrastructure is provisioned using Terraform, and CI/CD pipelines are implemented using GitHub Actions.

## :jigsaw: Architecture Diagram

<p align="center">
  <img src="./images/cicd_aws_deployment.png" width="900"/>
</p>

## :building_construction: Architecture Summary

- Fully containerized application (Frontend + Backend)
- Amazon ECS Fargate for serverless container orchestration
- Application Load Balancer for traffic routing
- Amazon RDS (PostgreSQL) for persistent storage
- Amazon ECR for container image storage
- Terraform for Infrastructure as Code
- GitHub Actions for CI/CD automation
- CloudWatch for logging and monitoring


## :gear:Tech Stack

- AWS (ECS, ALB, RDS, ECR, CloudWatch, VPC, IAM)
- Terraform
- Docker
- GitHub Actions
- FastAPI (Backend)
- React + Nginx (Frontend)
- PostgreSQL

## :rocket: CI/CD Pipeline

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

## :hammer_and_wrench: Deployment Instructions

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
terraform plan
terraform apply -auto-approve
```

## Build and Push Docker Images
### Backend
```bash
cd backend
docker build -t backend .
docker tag backend <ECR_BACKEND_REPO>
docker push <ECR_BACKEND_REPO>
```

### Frontend
```bash
cd frontend
docker build -t frontend .
docker tag frontend <ECR_FRONTEND_REPO>
docker push <ECR_FRONTEND_REPO>
```
### :rocket: Application Deployment
- ECS services pull images from Amazon ECR
- Services are updated automatically via CI/CD pipelines
- ALB routes traffic to frontend and backend services

### :lock: Security Best Practices
- IAM roles follow least privilege principle
- ECS tasks use task execution roles
- RDS deployed in private subnets (no public access)
- Security groups restrict traffic between services
- Secrets managed via AWS Secrets Manager or GitHub Secrets
- HTTPS enforced via Application Load Balancer

### :bar_chart: Observability
- Amazon CloudWatch Logs for application logging
- ECS task-level logging enabled
- ALB access logs configured
- CloudWatch metrics and alarms for monitoring
- 
### :zap: Scalability & Availability
- ECS Service Auto Scaling enabled
- Application Load Balancer distributes traffic
- Multi-AZ deployment for ECS and RDS
- Stateless container design for horizontal scaling
- 
### :balance_scale: Design Decisions
- ECS Fargate used for simplified container management
- Terraform used for reproducible infrastructure
- Docker ensures environment consistency
- ALB used as a single entry point with routing capabilities

### :arrows_clockwise: Trade-offs
- ECS chosen over Kubernetes for simplicity
- Containerized frontend instead of S3 hosting for consistency
- RDS used instead of NoSQL for relational data requirements
- 
## :test_tube: Application Details
### Backend
- FastAPI-based REST API
- PostgreSQL integration
- Dockerized service
### Frontend
- React single-page application
- Served via Nginx inside Docker container
  
### :chart_with_upwards_trend: Future Improvements
- Blue/Green deployments using AWS CodeDeploy
- Multi-environment setup (dev, staging, production)
- Redis caching layer
- Service mesh integration
- Migration to Kubernetes (EKS)

  
### :man_technologist: Author

Kishore
