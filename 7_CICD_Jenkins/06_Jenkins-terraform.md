# Jenkins and Terraform Integration

**Jenkins + Terraform** is a very common combination used in **DevOps automation**.

* **Terraform** → Used to **create and manage infrastructure** (servers, networks, load balancers, etc.)
* **Jenkins** → Used to **automate the process** of running Terraform commands

Together they allow you to build **Infrastructure as Code (IaC) pipelines**.

Example:
When a developer pushes code → Jenkins automatically runs Terraform → Infrastructure is created or updated in cloud (AWS, Azure, GCP).

## 1. Basic Workflow of Jenkins + Terraform

A typical pipeline works like this:

```bash
Developer writes Terraform code
        │
        ▼
Push code to GitHub
        │
        ▼
Jenkins Pipeline Triggered
        │
        ▼
Terraform Init
        │
        ▼
Terraform Validate
        │
        ▼
Terraform Plan
        │
        ▼
Terraform Apply
        │
        ▼
Infrastructure Created in Cloud
```

---

## 2. Requirements for Jenkins–Terraform Integration

Before integration, ensure the following are installed.

### 1. Jenkins Server

Installed on:

* EC2
* VM
* Physical server

### 2. Terraform Installed

Install Terraform on Jenkins server.

Example (Linux):

```bash
wget https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip
unzip terraform_1.6.6_linux_amd64.zip
sudo mv terraform /usr/local/bin/
```

Verify:

```bash
terraform -v
```

### 3. Install terraform Plugin

In Jenkins:

```bash
Manage Jenkins
   → Plugins
   → Install "Terraform Plugin"
```

### 4. Cloud Credentials

Example for **AWS**

Create IAM user and configure credentials:

```bash
aws configure
```

Or use Jenkins credentials store.

### 5. Git Repository

Store Terraform code in GitHub.

Example structure:

```bash
terraform-project/
 ├── main.tf
 ├── variables.tf
 ├── outputs.tf
 └── terraform.tfvars
```

---

## 3. Jenkins Terraform Pipeline Stages

A typical Terraform pipeline contains **5 stages**.

### Stage 1 — Checkout Code

Jenkins pulls Terraform code from Git.

Example:

```groovy
stage('Checkout') {
    steps {
        git 'https://github.com/user/terraform-project.git'
    }
}
```

### Stage 2 — Terraform Init

`terraform init` initializes the Terraform project.

It:

* Downloads provider plugins
* Sets up backend
* Prepares working directory

Command:

```bash
terraform init
```

Pipeline:

```groovy
stage('Terraform Init') {
    steps {
        sh 'terraform init'
    }
}
```

### Stage 3 — Terraform Validate

Checks Terraform code syntax.

Command:

```bash
terraform validate
```

Pipeline:

```groovy
stage('Terraform Validate') {
    steps {
        sh 'terraform validate'
    }
}
```

### Stage 4 — Terraform Plan

Shows **what changes Terraform will make**.

Example output:

```bash
+ create EC2 instance
+ create security group
```

Command:

```bash
terraform plan
```

Pipeline:

```groovy
stage('Terraform Plan') {
    steps {
        sh 'terraform plan'
    }
}
```

### Stage 5 — Terraform Apply

Creates or updates infrastructure.

Command:

```bash
terraform apply -auto-approve
```

Pipeline:

```groovy
stage('Terraform Apply') {
    steps {
        sh 'terraform apply -auto-approve'
    }
}
```

---

## 4. Complete Jenkins Pipeline Example

Below is a **simple Jenkinsfile for Terraform**.

```groovy
pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                git 'https://github.com/user/terraform-project.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }

    }
}
```

This pipeline will:

1. Pull Terraform code
2. Initialize Terraform
3. Validate configuration
4. Show infrastructure changes
5. Create infrastructure

---

## 5. Best Practice: Manual Approval Before Apply

In real production pipelines, **terraform apply should not run automatically**.

Instead Jenkins waits for approval.

Example:

```groovy
stage('Approval') {
    steps {
        input "Do you want to apply Terraform changes?"
    }
}
```

Pipeline flow:

```bash
terraform init
terraform validate
terraform plan
manual approval
terraform apply
```

This prevents accidental infrastructure changes.

---

## 6. Advanced Terraform Jenkins Pipeline

Real pipelines often include:

### 1. Terraform Format Check

```bash
terraform fmt -check
```

### 2. Security Scanning

Tools:

* Checkov
* tfsec

### 3. Environment-Based Deployment

Example environments:

* dev
* staging
* production

Example:

```bash
terraform workspace select dev
```

### 4. Destroy Infrastructure

Sometimes pipeline includes:

```bash
terraform destroy
```

Used when infrastructure needs removal.

## 7. Real World Example Workflow

Example DevOps pipeline:

```bash
Developer updates Terraform code
        │
        ▼
Push to GitHub
        │
        ▼
Jenkins Triggered
        │
        ▼
Terraform Init
        │
        ▼
Terraform Validate
        │
        ▼
Terraform Plan
        │
        ▼
DevOps Engineer Reviews Plan
        │
        ▼
Approval
        │
        ▼
Terraform Apply
        │
        ▼
AWS Infrastructure Created
```
