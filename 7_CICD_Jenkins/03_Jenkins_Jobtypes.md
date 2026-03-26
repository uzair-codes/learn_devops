# Jenkins Dashboard

When Jenkins is installed it runs as a service.

```bash

sudo systemctl status jenkins

```bash
Jenkins by default it listens at port 8080.
You can access Jenkins **Web Interface** by pasing your IPv4 address followed by **:8080**
```

Example

```bash
172.19.10.191:8080
```

The Jenkins Dashboard is the main interface where you manage everything in Jenkins such as:

* Creating jobs (pipelines)
* Viewing build history
* Monitoring build queue
* Managing nodes and configuration
* Accessing system settings

When you log in to Jenkins, the Home Dashboard is the first page you see.

## 1. Jenkins Home Dashboard

![Image](https://kodekloud.com/kk-media/image/upload/v1752879552/notes-assets/images/Jenkins-For-Beginners-Jenkins-User-Interface-Overview/jenkins-dashboard-job-setup.jpg)

### Left Sidebar Menu

The **left panel** contains the main navigation options.

#### 1. New Item

Used to **create a new Jenkins job**.

Jobs can be:

* Pipeline
* Freestyle project
* Multibranch pipeline
* Folder

#### 2. Build History

Displays **all previous builds from all jobs**.

You can click a build to see:

* Logs
* Execution steps
* Errors

#### 3. Build Queue

Shows jobs **waiting to run**.

Example:

```bash
Build #105 – Waiting
Build #106 – Waiting
```

This happens when:

* All executors are busy
* Jenkins is processing other builds

Once an executor becomes free, Jenkins will start the next job.

---

#### 4. Build Executor Status

This section shows **running builds on executors**.

Example:

```bash
Executor #1 → Running Build #34
Executor #2 → Idle
```

---

### Main Dashboard Area

The center of the screen displays **job-related actions**.

#### Create a Job

This button allows you to create your **first Jenkins job**.

#### Set up an Agent

Used to add **Jenkins agents (worker nodes)**.

Agents help run builds on **multiple machines**.

#### Configure a Cloud

Used to integrate Jenkins with **cloud providers**.

Examples:

* AWS EC2
* Kubernetes
* Google Cloud

Jenkins can automatically create **dynamic agents in the cloud**.

Example:

```bash
Jenkins → Launch EC2 agent → Run build → Terminate agent
```

---

## 2. Jenkins Job Types

When creating a new job, Jenkins shows different **job types**.

![Image](https://miro.medium.com/v2/resize%3Afit%3A1400/1%2AJyLh6C-9sxQeJLI3Qq4Ulw.png)

![Image](https://toolsqa.com/gallery/Jenkins/1.Projects%20Jobs%20in%20Jenkins.jpg)

These job types define **how Jenkins will run the automation**.

### 1.  Freestyle Project

A **Freestyle Project** is the **classic Jenkins job type** used to automate tasks such as building code, running tests, or deploying applications.

It works like **form filling**. You configure the job by selecting options and adding steps in the Jenkins UI.

> Freestyle jobs are simple and good for small automation tasks, but large CI/CD pipelines usually use **Pipeline jobs with Jenkinsfile**.

#### Creating a Freestyle Job

Steps:

```text
Jenkins Dashboard → New Item → Enter Job Name → Select "Freestyle Project" → OK
```

After clicking **OK**, Jenkins opens the **job configuration page**.

The left sidebar shows:

```text
Configure
```

Inside the configuration page you will see these main sections:

```text
1. General
2. Source Code Management
3. Triggers
4. Environment
5. Build Steps
6. Post-build Actions
```

We will explain each section.

---

#### 1. General

The **General section** contains basic job configuration settings.

##### Description

Used to describe the job.

Example:

```bash
This job builds and deploys the portfolio web application.
```

This helps other engineers understand what the job does.

##### Discard Old Builds

```bash
Discard old builds
```

Automatically deletes old builds to save disk space.

Example configuration:

```bash
Keep last 10 builds
Delete builds older than 30 days
```

Useful for servers with limited storage.

##### GitHub Project

```bash
GitHub project
```

Links the Jenkins job to a GitHub repository.

Example:

```bash
https://github.com/username/react-app
```

This allows Jenkins to show **GitHub links in build details**.

##### This Project is Parameterized

Allows users to **pass parameters to a build**.

Example parameters:

```bash
ENVIRONMENT = dev / staging / prod
VERSION = v1.2
```

Example usage:

```bash
Deploy application to staging environment
```

##### Throttle Builds

Limits how many builds can run at the same time.

Example:

```bash
Maximum builds: 2
```

Prevents Jenkins servers from being overloaded.

##### Execute Concurrent Builds if Necessary

Allows **multiple builds of the same job** to run simultaneously.

Example:

```bash
Build #10 running
Build #11 starts before #10 finishes
```

If disabled:

```bash
Build #11 waits until #10 finishes
```

##### Advanced Settings

###### Quiet Period

Defines how long Jenkins waits before starting a build after it is triggered.

Example:

```bash
Quiet period = 10 seconds
```

Useful when many commits happen quickly.

###### Retry Count

If a build fails due to temporary issues, Jenkins can retry it.

Example:

```bash
Retry build 2 times
```

###### Block Build When Upstream Project is Building

Prevents this job from running if the **upstream job** is currently building.

Example:

```bash
Build-App → Deploy-App
```

If **Build-App** is running, **Deploy-App** will wait.

###### Block Build When Downstream Project is Building

Prevents running a job if its **dependent job** is already running.

###### Use Custom Workspace

Allows you to define a **custom directory** where the job will run.

Example:

```bash
/opt/builds/react-app
```

Normally Jenkins uses:

```bash
/var/lib/jenkins/workspace/job-name
```

###### Display Name

Allows you to set a **custom name for the job**.

Example:

```bash
React App Production Build
```

Instead of:

```bash
react-app-build
```

---

###### Keep the Build Logs of Dependencies

Keeps logs from dependent builds.

Example:

```bash
Build-App → Deploy-App
```

Logs from both builds are preserved.

---

#### 2. Source Code Management (SCM)

This section connects Jenkins to the **code repository**.

Options:

```bash
None
Git
```

Most projects use **Git**.

##### Git Configuration

Example configuration:

```bash
Repository URL: https://github.com/user/react-app.git
Branch: main
Credentials: GitHub token
```

Workflow:

```text
Jenkins → Connects to Git → Downloads latest code → Runs build
```

Example command Jenkins internally runs:

```bash
git clone https://github.com/user/react-app.git
```

---

#### 3. Triggers

Triggers define **when Jenkins should start a build**.

##### Trigger Builds Remotely

Allows builds to be triggered using an API call.

Example:

```bash
http://jenkins-server/job/build-app/build?token=abc123
```

Useful for automation scripts.

##### Build After Other Projects Are Built

Creates **job dependencies**.

Example:

```bash
Job A → Job B
```

When **Job A finishes**, Jenkins automatically starts **Job B**.

##### Build Periodically

Schedules builds using **cron syntax**.

Example:

```bash
H 2 * * *
```

Meaning:

```bash
Run build every day at 2 AM
```

##### GitHub Hook Trigger

Allows GitHub to trigger Jenkins using **webhooks**.

This is the **most common trigger in CI/CD**.

##### Poll SCM

Jenkins checks the repository for changes periodically.

Example:

```bash
Check every 5 minutes
```

If new commits are detected:

```bash
Start build
```

However, **webhooks are better than polling**.

---

#### 4. Environment

This section configures **environment settings for the build**.

##### Delete Workspace Before Build Starts

Deletes old files before running a new build.

Example:

```bash
Old build files removed
Fresh build environment created
```

Prevents build conflicts.

---

##### Use Secret Text or Files

Used to add **secure credentials**.

Example:

```bash
API keys
Passwords
SSH keys
```

Stored safely inside Jenkins credentials.

---

##### Add Timestamps to Console Output

Adds timestamps to build logs.

Example:

```bash
[12:01:10] Build started
[12:01:12] Running npm install
```

Useful for debugging.

---

##### Terminate a Build if it's Stuck

Stops builds that run too long.

Example:

```bash
Stop build if running longer than 60 minutes
```

Prevents resource waste.

---

#### 5. Build Steps

This is the **core part of a freestyle job**.

Build steps define **what commands Jenkins should run**.

Example build steps:

```bash
Compile code
Install dependencies
Run tests
Build Docker image
Deploy application
```

##### Common Build Step Types

###### Execute Shell (Linux)

Runs shell commands.

Example:

```bash
npm install
npm run build
docker build -t app:v1 .
```

---

###### Execute Windows Batch Command

Used on Windows systems.

Example:

```bat
npm install
npm run build
```

---

###### Invoke Maven Targets

Used for Java projects.

Example:

```bash
mvn clean package
```

---

###### Invoke Gradle Script

Used for Gradle-based Java builds.

Example:

```bash
gradle build
```

---

###### Example Build Steps (Real Scenario)

Example **NodeJS application build**:

```bash
npm install
npm test
npm run build
```

Example **Docker build**:

```bash
docker build -t portfolio:v1 .
```

---

#### 6. Post-build Actions

These actions run **after the build completes**.

Example:

```bash
Send notifications
Archive build files
Trigger another job
Publish reports
```

##### Archive Artifacts

Stores build files in Jenkins.

Example artifacts:

```bash
build/
app.jar
docker-image
```

##### Build Other Projects

Triggers another Jenkins job.

Example pipeline:

```bash
Build-App → Deploy-App
```

##### Publish JUnit Test Results

Shows **test results in Jenkins dashboard**.

Example output:

```bash
Tests: 100
Passed: 95
Failed: 5
```

##### Email Notification

Sends build results via email.

Example:

```bash
Build SUCCESS → Email DevOps team
Build FAILED → Email developers
```

##### Git Publisher

Allows Jenkins to push code or tags back to Git.

Example:

```bash
Push release tag after successful build
```

##### Delete Workspace When Build is Done

Cleans up workspace after build completion.

Useful for saving disk space.

#### Limitations of Freestyle Jobs

Freestyle jobs have some limitations:

* Hard to manage large pipelines
* No version control for pipeline steps
* Complex pipelines become messy

Because of this:

> Modern DevOps teams prefer **Pipeline jobs using Jenkinsfile**.

---

### 2. Pipeline

The **Pipeline job** is the **most modern and recommended way** to create Jenkins jobs.

It allows you to define the entire CI/CD pipeline using **code**.

This code is stored in a file called:

```bash
Jenkinsfile
```

---;

#### Why Jenkins Pipelines are Used

Freestyle jobs become difficult to manage when pipelines grow larger.
In a freestyle job, you configure each step manually in the UI.
Also freestyle job configuration lives in jenkins internal system, if jenkins server crashes you loos you pipeline configuration.

But **pipeline jobs**, are written as code in a **Jenkinsfile**, so they can be:

* Stored in **Git**
* Reviewed by team members
* Version controlled
* Roll back
* Easily maintained

This concept is called **Pipeline as Code**.

Jenkins reads **Jenkinsfile** and executes the pipeline automatically.

---

#### Creating a Jenkins Pipeline Job

Steps:

```text
Jenkins Dashboard → New Item → Enter Job Name → Select Pipeline → OK
```

After clicking **OK**, Jenkins opens the **pipeline configuration page**.

You will see sections similar to freestyle jobs:

```text
General
Triggers
Pipeline
```

The most important section is **Pipeline**.

##### Pipeline Section

The pipeline section defines **where Jenkins should get the pipeline code from**.

Two options are commonly used:

###### 1. Pipeline Script

In this option, you write the pipeline **directly inside Jenkins UI**.

This method is useful for:

* Testing pipelines
* Small demos

But it is **not recommended for production systems**.

###### 2. Pipeline Script from SCM

This is the **best and most common approach**.

The Jenkinsfile is stored in the **Git repository**.

This allows pipelines to be **version controlled with the application code**.

---

#### Structure of a Jenkins Pipeline

A Jenkins pipeline has a clear structure.

Basic structure:

```groovy
pipeline {

    agent any

    stages {

        stage('Stage Name') {

            steps {

                commands

            }

        }

    }

}
```

##### Important Jenkinsfile Blocks

###### 1. pipeline Block

The **pipeline block** is the **top-level structure** of the Jenkinsfile.

Example:

```groovy
pipeline {
    agent any
    stages { }
}
```

Everything inside the pipeline block defines the **CI/CD workflow**.

###### 2. agent

The **agent** defines **where the pipeline runs**.

Example:

```groovy
agent any
```

Meaning:

```text
Run pipeline on any available Jenkins agent
```

**Example using specific agent:**

```groovy
agent { label 'docker-server' }
```

Meaning:

```text
Run pipeline on node labeled docker-server
```

**Example using Docker:**

```groovy
agent {
    docker {
        image 'node:18'
    }
}
```

Meaning:

```text
Run pipeline inside a NodeJS Docker container
```

###### 3. stages

The **stages block** contains all pipeline stages.

Example:

```groovy
stages {

    stage('Build') { }

    stage('Test') { }

    stage('Deploy') { }

}
```

Each stage represents **one phase of the CI/CD pipeline**.

Example pipeline flow:

```text
Checkout
Install Dependencies
Build
Test
Deploy
```

###### 4. stage Block

Each **stage** defines a specific step in the pipeline.

Example:

```groovy
stage('Build') {
    steps {
        sh 'npm run build'
    }
}
```

Jenkins displays each stage visually in the pipeline UI.

Example visualization:

```text
Checkout ✔
Build ✔
Test ✖
Deploy skipped
```

###### 5. steps

The **steps block** contains commands executed during the stage.

Example:

```groovy
steps {
    sh 'npm install'
}
```

Common commands:

```bash
sh 'npm install'
sh 'mvn package'
sh 'docker build -t app:v1 .'
sh 'kubectl apply -f deployment.yaml'
```

###### 6. environment Variables

The **environment block** defines environment variables used in the pipeline.

Example:

```groovy
environment {
    APP_ENV = "production"
    VERSION = "1.0"
}
```

Usage example:

```groovy
stage('Print Variables') {
    steps {
        sh 'echo $APP_ENV'
        sh 'echo $VERSION'
    }
}
```

Output:

```text
production
1.0
```

###### 7. options

The **options block** defines pipeline behavior settings.

Example:

```groovy
options {
    timeout(time: 30, unit: 'MINUTES')
}
```

Meaning:

```text
Pipeline will stop if it runs longer than 30 minutes
```

Another example:

```groovy
options {
    buildDiscarder(logRotator(numToKeepStr: '10'))
}
```

Meaning:

```text
Keep only last 10 builds
```

###### 8. parameters

Parameters allow **user input when running the pipeline**.

Example:

```groovy
parameters {
    string(name: 'ENVIRONMENT', defaultValue: 'dev', description: 'Deployment Environment')
}
```

When running the job, Jenkins asks:

```text
ENVIRONMENT = dev / staging / production
```

Usage example:

```groovy
steps {
    sh "echo Deploying to ${params.ENVIRONMENT}"
}
```

###### 9. post Block

The **post block** defines actions that run **after pipeline execution**.

Example:

```groovy
post {

    success {
        echo 'Pipeline completed successfully'
    }

    failure {
        echo 'Pipeline failed'
    }

}
```

Other options:

```text
always
success
failure
unstable
changed
```

Example:

```groovy
post {
    always {
        cleanWs()
    }
}
```

Meaning:

```text
Clean workspace after build
```

#### Example Jenkins Pipeline

Example pipeline for a **NodeJS application**.

```groovy
pipeline {

    agent any

    stages {

        stage('Checkout') {
            steps {
                git 'https://github.com/user/node-app.git'
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

Pipeline flow:

```text
Checkout → Install Dependencies → Build → Test
```

---

#### Example Pipeline with Docker

Example pipeline building a Docker image.

```groovy
pipeline {

    agent any

    stages {

        stage('Checkout') {
            steps {
                git 'https://github.com/user/app.git'
            }
        }

        stage('Build Image') {
            steps {
                sh 'docker build -t app:v1 .'
            }
        }

        stage('Push Image') {
            steps {
                sh 'docker push app:v1'
            }
        }

    }

}
```

---

#### Pipeline Visualization in Jenkins

Jenkins displays pipelines visually.

Example:

```text
Checkout  ✔
Install   ✔
Build     ✔
Test      ✖
Deploy    skipped
```

If one stage fails:

```text
Pipeline stops
```

This helps engineers quickly identify problems.

---

#### Advantages of Pipeline Jobs

Pipeline jobs provide many advantages:

##### Version Control

Pipeline stored in Git.

```text
Jenkinsfile in repository
```

##### Reproducibility

Same pipeline runs consistently across builds.

##### Scalability

Supports large CI/CD workflows.

##### Complex Workflows

Pipelines support:

* Parallel builds
* Conditional steps
* Multiple agents

---

#### Example Real DevOps Pipeline Workflow

Example workflow for a **React application**.

```text
Developer pushes code
        │
        ▼
Jenkins pipeline starts
        │
        ▼
Checkout Code
        │
        ▼
Install Dependencies
        │
        ▼
Run Tests
        │
        ▼
Build React App
        │
        ▼
Build Docker Image
        │
        ▼
Push Image to DockerHub
        │
        ▼
Deploy to Kubernetes
```

Everything happens **automatically**.

---

### 3. Multi-Configuration Project

This job type is used when you need to test **multiple configurations of the same project**.

Example scenarios:

Testing application on different:

* Operating systems
* Java versions
* Browser versions

Example:

```bash
OS: Linux
OS: Windows
OS: Mac
```

Jenkins runs builds for **each configuration automatically**.

Example matrix:

```bash
Java 8 + Linux
Java 11 + Linux
Java 17 + Linux
```

This is useful for **compatibility testing**.

---

### 4. Folder

A **Folder** is used to **organize Jenkins jobs**.

Large companies may have hundreds of jobs.

Folders help structure them.

Example:

```bash
DevOps-Jobs
   │
   ├── Build-Pipeline
   ├── Deploy-Pipeline
   └── Monitoring-Pipeline
```

This keeps Jenkins **clean and organized**.

---

### 5. Multibranch Pipeline

A **Multibranch Pipeline** automatically creates pipelines for **each branch in a repository**.

Example Git repository:

```bash
main
develop
feature-login
feature-payment
```

Jenkins will automatically create pipelines for each branch.

Example:

```bash
Pipeline-main
Pipeline-develop
Pipeline-feature-login
```

Advantages:

* Automatically builds new branches
* Perfect for Git workflows

---

### 6. Organization Folder

An **Organization Folder** scans **entire GitHub organizations**.

Example GitHub organization:

```bash
company-devops
```

Repositories inside the organization:

```bash
app-frontend
app-backend
infra-terraform
```

Jenkins automatically creates pipelines for all repositories.

This is useful for **large teams with many repositories**.

---

### Summary of Jenkins Job Types

| Job Type             | Purpose                                 |
| -------------------- | --------------------------------------- |
| Freestyle Project    | Classic Jenkins job                     |
| Pipeline             | Modern CI/CD pipeline using Jenkinsfile |
| Multi-Configuration  | Test across multiple environments       |
| Folder               | Organize jobs                           |
| Multibranch Pipeline | Pipeline per Git branch                 |
| Organization Folder  | Manage multiple repositories            |
