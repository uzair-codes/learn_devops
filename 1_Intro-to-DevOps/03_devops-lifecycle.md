# Section 3: DevOps Life-cycle Stages and Common Tools

The **DevOps life-cycle** describes the continuous process used to **develop, build, test, release, deploy, operate, and monitor software**.

Unlike traditional development where work happens in large phases, DevOps uses a **continuous cycle**. This allows teams to deliver software **faster, more reliably, and with continuous improvements**.

The DevOps life-cycle is usually represented as an **infinite loop**, showing that development and operations continuously improve the system.

---

## Main Stages of the DevOps Life-cycle

### 1. Planning

This is the stage where teams **plan new features, improvements, and bug fixes**.

Activities in this stage:

* Understanding customer requirements
* Creating product roadmaps
* Breaking work into smaller tasks
* Managing project progress

Common tools:

* Jira
* Azure Boards
* Trello
* ClickUp
* GitHub Projects

Example:

A team plans a new feature for an e-commerce website such as **adding a payment gateway**.

---

### 2. Development

In this stage, developers **write the application code** based on the planned requirements.

Activities in this stage:

* Writing code
* Reviewing code
* Managing source code
* Collaborating with other developers

Common tools:

* Git
* GitHub
* GitLab
* Bitbucket

Example:

Developers write backend APIs, frontend components, and database logic.

---

### 3. Continuous Integration (CI) /Build

During the build stage, the application source code is **compiled and packaged** into a deployable format.

Activities in this stage:

* Compiling code
* Installing dependencies
* Creating build artifacts
* Creating Docker images

Common tools:

* Maven
* Gradle
* npm / yarn
* Docker

Example:

A Java application might be compiled into a **JAR file**, while a containerized application may be packaged into a **Docker image**.

---

### 4. Continuous Integration (CI) / Testing

In this stage, code changes are automatically **tested whenever developers push code to the repository**.

The goal is to detect bugs **early in the development process**.

Activities in this stage:

* Running automated tests
* Performing code quality checks
* Running security scans
* Validating builds

Common tools:

* Jenkins
* GitHub Actions
* GitLab CI/CD
* CircleCI
* SonarQube
* Selenium
* JUnit

Example:

Whenever code is pushed to GitHub, a CI pipeline automatically runs tests to ensure the application works correctly.

---

### 5. Continuous Integration (CI) /Release

In the release stage, the application is **prepared for deployment**.

Activities in this stage:

* Versioning the software
* Packaging artifacts
* Storing build artifacts
* Managing release versions

Common tools:

* Nexus
* JFrog Artifactory
* GitHub Packages

Example:

The application build artifacts are stored in an artifact repository before deployment.

---

### 6. Deployment (Continuous Delivery / Continuous Deployment)

In this stage, the application is **deployed to servers or cloud environments**.

Deployment can happen automatically or with manual approval.

Activities in this stage:

* Deploying applications to staging or production
* Managing environments
* Updating running systems

Common tools:

* Jenkins
* ArgoCD
* Spinnaker
* AWS CodeDeploy
* Kubernetes
* Helm

Example:

A Docker container is deployed to a **Kubernetes cluster**.

---

### 7. Operations

In this stage, the application is **running in production** and serving users.

Operations teams ensure that systems remain:

* Stable
* Secure
* Scalable

Activities in this stage:

* Managing infrastructure
* Scaling servers
* Ensuring system uptime
* Handling incidents

Common tools:

* Kubernetes
* Terraform
* Ansible
* AWS / Azure / GCP

---

### 8. Monitoring

Monitoring ensures that applications and infrastructure are **continuously observed for performance and issues**.

This helps teams quickly detect and resolve problems.

Activities in this stage:

* Monitoring system health
* Tracking application performance
* Analyzing logs
* Setting alerts

Common tools:

* Prometheus
* Grafana
* ELK Stack (Elasticsearch, Logstash, Kibana)
* Datadog
* New Relic

Example:

If CPU usage becomes very high, the monitoring system sends an **alert to engineers**.

---

## DevOps Life-cycle Summary

| Stage        | Purpose                       | Example Tools               |
| ------------ | ----------------------------- | --------------------------- |
| Planning     | Manage requirements and tasks | Jira, Trello                |
| Development  | Write and manage code         | Git, GitHub                 |
| CI /Build    | Compile and package software  | Maven, Gradle, Docker       |
| CI / Testing | Automatically test code       | Jenkins, GitHub Actions     |
| CI /Release  | Store and manage artifacts    | Nexus, Artifactory          |
| Deployment   | Deploy applications           | Jenkins, Kubernetes, ArgoCD |
| Operations   | Manage running systems        | Terraform, Ansible          |
| Monitoring   | Observe system health         | Prometheus, Grafana         |

---

## Key Idea

The DevOps life-cycle is **continuous**, meaning:

* Developers keep improving the software
* New code is continuously integrated
* Applications are frequently deployed
* Systems are continuously monitored

This continuous process enables **faster and more reliable software delivery**.
