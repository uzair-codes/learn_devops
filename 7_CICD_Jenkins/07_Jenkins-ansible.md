# Jenkins + Ansible

Below are the **best and most common ways to integrate Jenkins with Ansible**, explained simply and in detail.

## 1️⃣ Jenkins Runs Ansible Playbooks Directly (Most Common & Beginner Friendly)

This is the **simplest and most common integration**.

Jenkins executes the command:

```bash
ansible-playbook playbook.yml
```

### Example Jenkins Freestyle Job

#### Step 1 — Install Ansible Plugin

In Jenkins:

```bash
Manage Jenkins
   → Plugins
   → Install "Ansible Plugin"
```

---

#### Step 2 — Create Jenkins Job

```bash
New Item
   → Freestyle Project
```

---

#### Step 3 — Configure Source Code

```bash
Source Code Management
   → Git
```

Example repo:

```bash
https://github.com/company/devops-project
```

---

#### Step 4 — Build Step

```bash
Build
   → Invoke Ansible Playbook
```

Example configuration:

```bash
Playbook Path:
ansible/deploy.yml

Inventory:
ansible/inventory.ini
```

---

#### What Happens Internally

Jenkins runs:

```bash
ansible-playbook ansible/deploy.yml -i ansible/inventory.ini
```

---

## 2️⃣ Jenkins Triggers Ansible via SSH (Controller Architecture)

In larger systems, Jenkins **does not run Ansible itself**.

Instead it **connects to an Ansible control node**.

### Jenkins Step

In Jenkins:

```bash
Build
   → Execute Shell
```

Command:

```bash
ssh ansible@ansible-server \
"ansible-playbook /opt/playbooks/deploy.yml"
```

---

### What Happens

1. Jenkins connects to the **Ansible server**.
2. That server runs the playbook.
3. The playbook deploys to target machines.

---

## 3️⃣ Jenkins Pipeline + Ansible (Most Professional Method)

Instead of **Freestyle Jobs**, modern DevOps uses **Pipeline Jobs**.

Pipelines are defined using a **Jenkinsfile** stored in Git.

### Architecture

```bash
Git Repository
     │
     ├── Jenkinsfile
     └── ansible/
          └── deploy.yml
```

### Example Jenkins Pipeline Job

#### Step 1 — Install Required Plugins

#### Step 2 — Create Pipeline Job

#### Step 3 — Configure Git Repository

- **Pipeline Script**
- **Pipeline Script from SCM**

#### Step 4 — Create Jenkinsfile

Now create a Jenkinsfile in your Git repository.

Example:

```groovy
pipeline {

    agent any

    stages {

        stage('Clone Repository') {
            steps {
                git 'https://github.com/company/devops-project'
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                ansiblePlaybook(
                    playbook: 'ansible/deploy.yml',
                    inventory: 'ansible/inventory.ini'
                )
            }
        }

    }

}
```

#### Example Jenkinsfile

```groovy
pipeline {
    agent any

    stages {

        stage('Checkout Code') {
            steps {
                git 'https://github.com/company/project'
            }
        }

        stage('Run Ansible') {
            steps {
                sh 'ansible-playbook ansible/deploy.yml'
            }
        }

    }
}
```

---

## 5️⃣ Jenkins + Ansible + Terraform

In many DevOps systems:

- **Terraform** creates infrastructure
- **Ansible** configures servers
- **Jenkins** orchestrates the pipeline

### Complete DevOps Pipeline

```bash
Git Push
   ↓
Jenkins Pipeline
   ↓
Terraform → Create Infrastructure
   ↓
Ansible → Configure Servers
   ↓
Application Deployment
```

### Example Pipeline Flow

Stage 1

```bash
Terraform Apply
```

Creates:

- EC2
- Load Balancer
- Networking

---

Stage 2

```bash
Ansible Playbook
```

Configures:

- Nginx
- Docker
- Application
