# Jenkins

**Jenkins** is an **open-source Java based automation server** used to automate tasks in software development such as:

* Building applications
* Running tests
* Deploying applications
* Automating CI/CD pipelines

In simple words:

> **Jenkins automatically builds, tests, and deploys your application whenever code changes.**

Instead of manually doing these steps, Jenkins **runs them automatically through pipelines**.

---

## [Install Jenkins](https://www.jenkins.io/doc/book/installing/)

---

## Why Jenkins is Used

Before CI/CD tools, developers had to:

1. Manually build applications
2. Manually run tests
3. Manually deploy software

This process was:

* Slow
* Error-prone
* Hard to scale

Jenkins solves this problem by **automating the entire process**.

Example workflow:

```text
Developer pushes code → Jenkins detects change → Build → Test → Deploy
```

This is called a **CI/CD pipeline**.

---

### Example Scenario

Suppose you have a **React application** stored in GitHub.

Without Jenkins:

```text
Developer pushes code
        ↓
Engineer logs into server
        ↓
Runs npm install
        ↓
Runs npm run build
        ↓
Copies files to server
        ↓
Restarts application
```

With Jenkins:

```text
Developer pushes code
↓
Jenkins automatically:
    - pulls code
    - installs dependencies
    - builds application
    - deploys application
```

Everything happens **automatically**.

---

## What Jenkins Can Automate

Jenkins can automate many DevOps tasks.

Examples:

### Build Applications

Example:

```bash
mvn clean package
```

or

```bash
npm run build
```

---

### Run Tests

Example:

```bash
npm test
```

or

```bash
pytest
```

---

### Build Docker Images

Example:

```bash
docker build -t portfolio:v1 .
```

---

### Deploy Applications

Example:

```bash
kubectl apply -f deployment.yaml
```

or

```bash
docker run -d -p 80:80 portfolio:v1
```

---

## Key Features of Jenkins

### 1. Open Source

Jenkins is **free and open source**.

Anyone can use it and contribute to it.

Official website:

```bash
https://www.jenkins.io
```

---

### 2. Large Plugin Ecosystem

Jenkins supports **1800+ plugins**.

Plugins allow Jenkins to integrate with tools like:

| Tool       | Purpose           |
| ---------- | ----------------- |
| Git        | Source control    |
| Docker     | Container builds  |
| Kubernetes | Deployment        |
| SonarQube  | Code quality      |
| AWS        | Cloud integration |

Example:

```bash
Git Plugin
Docker Plugin
Kubernetes Plugin
Slack Notification Plugin
```

---

### 3. Pipeline as Code

Jenkins pipelines can be written as **code** using a file called:

```bash
Jenkinsfile
```

Example:

```groovy
pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'npm install'
                sh 'npm run build'
            }
        }
    }
}
```

This allows CI/CD pipelines to be **version controlled in Git**.

---

### 4. Distributed Builds

Jenkins supports **Master-Agent architecture**.

This means builds can run on multiple machines.

Example:

```text
Jenkins Controller
     │
 ┌───┴────┐
Agent 1  Agent 2
```

Benefits:

* Faster builds
* Better scalability

---

### 5. Easy Integration with DevOps Tools

Jenkins integrates with many DevOps tools.

Example stack:

```text
GitHub → Jenkins → Docker → Kubernetes → AWS
```

This makes Jenkins a **central automation hub**.

---

## Where Jenkins Fits in DevOps

In a typical DevOps architecture:

```text
Developer (Code)
   │
   ▼
Git Repository (GitHub/GitLab)
   │
   ▼
Jenkins (CI/CD Automation)
   │
   ├── Build Application
   ├── Run Tests
   ├── Build Docker Image
   └── Deploy Application
   │
   ▼
Production Server / Kubernetes
```

Jenkins sits **between the code repository and deployment environment**.

---

## Real DevOps Example (Using Jenkins)

Example: Deploying a **NodeJS application**

Workflow:

```text
1. Developer pushes code to GitHub
2. GitHub webhook triggers Jenkins
3. Jenkins checks out code
4. Jenkins installs dependencies
5. Jenkins builds code
6. Jenkins runs tests
7. Jenkins builds Docker image
8. Jenkins pushes image to DockerHub
9. Jenkins deploys application to Kubernetes
```

Everything happens **automatically**.

---

## How Jenkins work

Jenkins works by **automatically running a series of steps (pipeline stages)** whenever there is a change in the code or when a job is triggered.

In simple terms:

> **Jenkins takes the latest code from a repository, runs automated tasks like build and tests, and deploys the application.**

It acts as the **automation engine of the CI/CD pipeline**.

---

### Step-by-Step Jenkins Workflow

#### 1. Developer Pushes Code

The process starts when a **developer pushes code to the repository**.

Example:

```bash
git add .
git commit -m "Add login feature"
git push origin main
```

The code is pushed to a **Git repository** such as:

* GitHub
* GitLab
* Bitbucket

---

#### 2. Repository Triggers Jenkins

When code is pushed, the repository sends a **webhook event** to Jenkins.

A **webhook** is a notification sent to Jenkins saying:

> "New code has been pushed. Start the pipeline."

Example:

```text
GitHub Webhook → Jenkins → Trigger Pipeline
```

The Jenkins job or pipeline starts automatically.

Pipelines can also be triggered by:

* Manual trigger
* Scheduled builds
* Pull requests
* API calls

---

#### 3. Jenkins Creates a Build

After the pipeline is triggered, Jenkins creates a **build**.

A **build** is simply **one execution of a pipeline**.

Example:

```bash
Build #1
Build #2
Build #3
```

Each build represents **one pipeline run**.

---

#### 4. Jenkins Allocates a Workspace

Before executing the pipeline, Jenkins creates a **workspace**.

A workspace is a **directory on the Jenkins machine where the pipeline runs**.

Example path:

```bash
/var/lib/jenkins/workspace/react-app-pipeline
```

Inside this workspace Jenkins will:

* download source code
* build application
* run scripts
* generate artifacts

---

#### 5. Jenkins Executes Pipeline Stages

The pipeline is divided into **stages**.

Each stage performs a specific task.

Example pipeline stages:

```text
Stage 1 → Checkout
Stage 2 → Install Dependencies
Stage 3 → Build
Stage 4 → Test
Stage 5 → Package
Stage 6 → Deploy
```

Jenkins executes these stages **one by one**.

---

### Example Jenkins Pipeline

Example pipeline for a **NodeJS application**:

```text
Stage 1: Checkout Code
git clone https://github.com/user/app.git

Stage 2: Install Dependencies
npm install

Stage 3: Build Application
npm run build

Stage 4: Run Tests
npm test

Stage 5: Build Docker Image
docker build -t portfolio:v1 .

Stage 6: Deploy Application
docker run -d -p 80:80 portfolio:v1
```

All steps are executed **automatically by Jenkins**.

---

### Jenkinsfile (Pipeline as Code)

Most Jenkins pipelines are defined in a file called **Jenkinsfile**.

This file is stored in the **Git repository**.

It is written using **Groovy Language**.

Example Jenkinsfile:

```groovy
pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                git 'https://github.com/user/app.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Build') {
            steps {
                sh 'npm run build'
            }
        }

        stage('Test') {
            steps {
                sh 'npm test'
            }
        }
    }
}
```

Jenkins reads this file and executes the pipeline stages.

---

### What Happens if a Step Fails?

If any stage fails, Jenkins **stops the pipeline**.

Example:

```text
Build → Success
Test → Failed
Deploy → Not executed
```

The developer is notified so the issue can be fixed.

Common notification methods:

* Email
* Slack
* Microsoft Teams

---

## Jenkins Architecture

Jenkins uses a **distributed architecture** that allows it to run builds on **multiple machines**.
This makes Jenkins **scalable, faster, and more efficient** for large CI/CD pipelines.

The main components of Jenkins architecture are:

```text
1. Jenkins Controller (Master)
2. Jenkins Agent (Worker Node)
3. Executors
4. Build Queue
5. Workspace
```

High-level architecture:

```text
                Jenkins Controller
                       │
        ┌──────────────┼──────────────┐
        │              │              │
     Agent 1        Agent 2        Agent 3
    (Builds)        (Tests)       (Deploy)
```

The **controller manages the system**, while **agents execute the actual jobs**.

---

### 1. Jenkins Controller (Master)

The server on which Jenkins is installed.

The **Jenkins Controller** is the **main server that manages Jenkins**.

It controls the entire Jenkins system.

Responsibilities of the Jenkins Controller:

* Manages Jenkins configuration
* Schedules jobs
* Assigns jobs to agents
* Stores build history
* Manages plugins
* Provides the Jenkins web interface

Example:

```text
Developer pushes code
        │
        ▼
Jenkins Controller receives trigger
        │
        ▼
Controller assigns job to an agent
```

The controller usually runs on a **dedicated server**.

Example location of Jenkins data on Linux:

```bash
/var/lib/jenkins
```

This directory stores:

```text
jobs/
workspace/
plugins/
build history/
logs/
```

---

### 2. Jenkins Agent (Worker Node)

A **Jenkins Agent** is a machine that **executes the actual pipeline jobs**.

Agents can be:

* Physical servers (Resource Wastage, Not Cost Effective, A dedicated agent my not receive a job for whole week, and sit idle, but you have to pay for it)
* Virtual machines
* Cloud instances
* Docker containers (Cost Effective, Docker Containers are ephemeral, exits only for the time the job runs)

Example responsibilities of agents:

* Build applications
* Run tests
* Build Docker images
* Deploy applications

Example scenario:

```text
Agent 1 → Build Java application
Agent 2 → Run automated tests
Agent 3 → Deploy to Kubernetes
```

This allows Jenkins to run **multiple jobs in parallel**.

---

#### Why Agents are Important

If Jenkins runs everything on the controller:

```text
Controller → Build → Test → Deploy
```

* The server can become **overloaded** - Single server can't handle load of muultiple departments or projects.
* **Dependencies conflict** may occure - "Different projects may require different version of same software".

With agents:

```text
Controller → Assign jobs
Agents → Execute jobs
```

Benefits:

* Faster builds
* Parallel execution
* Better scalability
* Isolation of workloads

---

### 3. Executors

An **Executor** is a **worker slot or a specific thread inside a node (controller or agent)** that runs a job.
Each executor can run **one build at a time**. The number of executors on a node determines how many jobs or pipeline stages that node can run simultaneously. If a machine has **4 executors**, it can run **4 jobs simultaneously**.

---

### 4. Build Queue

The **Build Queue** stores jobs that are **waiting to be executed**.
If all executors are busy, Jenkins places new jobs in the queue.
Once an executor becomes available Jenkins picks job from queue → Build starts
This ensures jobs are executed **in an organized order**.

---

### 5. Workspace

A **Workspace** is a directory where Jenkins performs the build.

Inside the workspace Jenkins will:

* download source code
* install dependencies
* run build commands
* generate artifacts

Example workspace path:

```bash
/var/lib/jenkins/workspace/react-app
```

Example contents:

```text
workspace/
  │
 react-app
    ├── source code
    ├── node_modules
    ├── build/
    ├── Dockerfile
    └── artifacts
```

Each pipeline job gets its **own workspace**.

---

### Complete Jenkins Architecture Flow

Example workflow:

```text
Developer pushes code
        │
        ▼
GitHub sends webhook
        │
        ▼
Jenkins Controller receives trigger
        │
        ▼
Job added to Build Queue
        │
        ▼
Controller assigns job to available Agent
        │
        ▼
Agent executor starts build
        │
        ▼
Job runs inside Workspace
        │
        ▼
Build/Test/Deploy completed
```

---

### Real DevOps Example

Example architecture for a company:

```text
                Jenkins Controller
                      │
        ┌─────────────┼─────────────┐
        │             │             │
   Build Agent    Test Agent    Deploy Agent
   (Docker)        (QA)         (Kubernetes)
```

Pipeline flow:

```text
Build Agent → Compile code
Test Agent → Run automated tests
Deploy Agent → Deploy to Kubernetes
```

This setup makes pipelines **faster and scalable**.

---

### Short Interview Explanation

Jenkins Architecture

> Jenkins uses a controller-agent architecture where the controller manages the system and schedules jobs, while agents execute builds using executors. Jobs run inside workspaces, and if executors are busy, they wait in the build queue.
