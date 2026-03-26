# Jenkins Agents Configuration

Jenkins supports **Distributed Builds Architecture**.
This means Jenkins can run jobs on **multiple machines (agents)** instead of running everything on the **main Jenkins server (controller)**.

This helps to:

* Run builds **faster**
* Run **multiple jobs in parallel**
* Use **different environments** (Linux, Windows, Docker, etc.)
* Reduce load on the **Jenkins controller**

Below is a **simple beginner-friendly step-by-step guide** to configure Jenkins agents.

---

## 1. Jenkins Distributed Architecture

### Components

**1. Jenkins Controller (Master)**
Main Jenkins server that:

* Manages jobs
* Schedules builds
* Stores configuration
* Assigns builds to agents

**2. Jenkins Agent (Worker Node)**
Machines that **execute build jobs**.

Agents can be:

* Physical servers
* Virtual machines
* Cloud instances (EC2)
* Docker containers
* Kubernetes pods

---

## 2. Requirements Before Adding an Agent

Before configuring an agent, ensure:

### On Agent Machine

Install:

```bash
Java (required)
Git
Docker (optional)
Build tools (maven, node, etc.)
```

Check Java:

```bash
java -version
```

If Java is not installed:

Ubuntu

```bash
sudo apt update
sudo apt install openjdk-21-jdk -y
```

---

## Method 1 — Configure a Dedicated Server as Jenkins Agent

Example:
Using **EC2 instance or physical Linux server**

### Step 1 — Create Agent Server

Create a new machine.

Examples:

* AWS EC2
* Virtual machine
* Physical server

Example configuration:

```bash
OS: Ubuntu 22.04
RAM: 2GB+
CPU: 2 cores
```

Install Java on this machine.

---

### Step 2 — Add New Node in Jenkins

Open Jenkins dashboard.

```bash
Manage Jenkins
```

Click:

```bash
Nodes
```

Then click:

```bash
New Node
```

Enter:

```bash
Node name: agent-1
Type: Permanent Agent
```

Click **Create**

---

### Step 3 — Configure Agent

Fill the following fields.

#### Number of Executors

2

Meaning:
Agent can run **2 builds at the same time**

---

#### Remote Root Directory

Directory where Jenkins stores files.

Example:

```bash
/home/ubuntu/jenkins
```

Create it on agent machine:

```bash
mkdir -p /home/ubuntu/jenkins
```

---

#### Labels

Optional but useful.

Example:

```bash
linux docker build
```

This allows jobs to run on specific agents.

Example pipeline:

```bash
agent { label 'docker' }
```

---

#### Usage

Choose:

```bash
Use this node as much as possible
```

---

#### Launch Method

Select:

```bash
Launch agent by connecting it to the controller
```

Click **Save**

---

### Step 4 — Connect Agent to Jenkins

After saving Jenkins will show a page with **commands to run on the agent machine**.

Example command:

```bash
curl -O http://<jenkins-ip>:8080/jnlpJars/agent.jar
```

Run on agent server:

```bash
curl -O http://JENKINS_IP:8080/jnlpJars/agent.jar
```

---

### Step 5 — Start Jenkins Agent

Jenkins will show a command like:

```bash
java -jar agent.jar \
  -url http://JENKINS_IP:8080/ \
  -secret XXXXX \
  -name "agent-1" \
  -workDir "/home/ubuntu/jenkins"
```

Run it on the agent machine.

If successful you will see:

```bash
INFO: Connected
```

Now Jenkins agent is **online**.

---

### Step 6 — Verify Agent

Go to:

```bash
Manage Jenkins → Nodes
```

You should see:

```bash
agent-1  (online)
```

Now Jenkins can run jobs on this machine.

---

## Method 2 — Configure Docker as Jenkins Agent

Docker agents are **very common in modern CI/CD**.

Benefits:

* Clean environment
* Easy scaling
* Fast builds
* No dependency conflicts

---

### Step 1 — Install Docker on Jenkins Server

```bash
sudo apt update
sudo apt install docker.io -y
```

Start Docker:

```bash
sudo systemctl start docker
sudo systemctl enable docker
```

Add Jenkins user to docker group:

```bash
sudo usermod -aG docker jenkins
```

Restart Jenkins:

```bash
sudo systemctl restart jenkins
```

---

### Step 2 — Install Docker Plugin

Open Jenkins:

```bash
Manage Jenkins
```

Click:

```bash
Manage Plugins
```

Install:

```bash
Docker
Docker Pipeline
Docker API
Docker Commons
```

---

### Step 3 — Configure Docker Cloud

Go to:

```bash
Manage Jenkins
→ Clouds
→ Add New Cloud
```

Select:

```bash
Docker
```

---

### Step 4 — Configure Docker Host

Example:

```bash
Docker Host URI
```

```bash
unix:///var/run/docker.sock
```

Test connection.

---

### Step 5 — Add Docker Agent Template

Click:

```bash
Add Docker Template
```

Fill:

#### Label

```bash
docker-agent
```

#### Docker Image

Example:

```bash
jenkins/inbound-agent
```

Or

```bash
node:18
maven:3.9
```

---

#### Remote File System Root

```bash
/home/jenkins
```

---

#### Instance Capacity

Example: 5

Meaning Jenkins can run **5 containers simultaneously**

Click **Save**

---

### Step 6 — Use Docker Agent in Pipeline

Example Jenkins pipeline:

```groovy
pipeline {
    agent {
        label 'docker-agent'
    }

    stages {
        stage('Build') {
            steps {
                sh 'echo Building application'
            }
        }

        stage('Test') {
            steps {
                sh 'echo Running tests'
            }
        }
    }
}
```

Jenkins will:

1. Start Docker container
2. Run build
3. Destroy container after job

---

## Best Practices for Jenkins Agents

### 1. Keep Controller Lightweight

Controller should only:

* Manage jobs
* Store configs

Builds should run on **agents**.

---

### 2. Use Labels

Example:

```bash
linux
docker
maven
node
gpu
```

This helps run builds on the right environment.

---

### 3. Use Docker Agents for CI/CD

Advantages:

* Clean environment every build
* No dependency conflicts
* Faster pipelines

---

### 4. Use Auto-scaling Agents (Advanced)

Examples:

* AWS EC2 agents
* Kubernetes agents
* Docker dynamic agents

These **create agents automatically when builds start**.

---

## Simple Architecture Example

```bash
                Jenkins Controller
                       │
        ┌──────────────┼──────────────┐
        │              │              │
     Agent-1        Agent-2      Docker Agents
    (EC2 Linux)   (VM Server)    (Containers)
        │              │              │
     Build Jobs     Test Jobs     CI/CD Jobs
```
