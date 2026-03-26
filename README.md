# DevOps Course Overview

## Course Structure

We follow a structured and progressive roadmap:

### 1. Introduction to DevOps

- What is DevOps?
- DevOps lifecycle
- CI/CD fundamentals
- DevOps culture
- Industry workflows

### 2. Linux OS and Shell Scripting

- Linux fundamentals
- File system
- Permissions
- Process management
- Shell scripting basics
- Automation using bash

### 3. Networking and AWS Concepts

- Networking fundamentals
- IP, DNS, HTTP, HTTPS
- Load balancers
- VPC concepts
- Core AWS services

### 4. Git and GitHub (Version Control)

- Git basics
- Branching
- Merging
- Pull Requests
- GitHub workflows
- Collaboration models

### 5. Infrastructure as Code (IaC)

#### Terraform (Provisioning)

- Infrastructure automation
- Providers
- Resources
- Variables
- State management
- Modules

#### Ansible (Configuration Management)

- Inventory
- Playbooks
- Roles
- Idempotency
- Remote configuration management

### 6. CI/CD

#### Jenkins

- Pipeline concepts
- Declarative pipelines
- Automated builds
- Deployment workflows

#### GitHub Actions

- Workflow files
- Runners
- Automation pipelines

### 7. Containerization (Docker)

- Docker architecture
- Images and containers
- Dockerfiles
- Docker Compose
- Multi-stage builds

### 8. Container Orchestration (Kubernetes)

- Pods
- Deployments
- Services
- ConfigMaps and Secrets
- Scaling and self-healing
- Production deployment patterns

### 9. Monitoring and Logging

- Monitoring fundamentals
- Metrics vs Logs
- Prometheus
- Grafana
- Centralized logging concepts

---

## How This Course Connects Everything

In real-world DevOps, tools are not used separately. They work together.

Typical DevOps workflow:

```bash
Developer
     ↓
Git (Version Control)
     ↓
CI Pipeline (Build + Test)
     ↓
Docker Image Creation
     ↓
Push to Container Registry
     ↓
Kubernetes Deployment
     ↓
Monitoring & Logging

```

---

## Tools Covered in This Course

| Category | Tools |
| ---------- | -------- |
| OS | Linux |
| Version Control | Git, GitHub |
| IaC | Terraform |
| Configuration | Ansible |
| CI/CD | Jenkins, GitHub Actions |
| Containerization | Docker |
| Orchestration | Kubernetes |
| Monitoring | Prometheus, Grafana |
