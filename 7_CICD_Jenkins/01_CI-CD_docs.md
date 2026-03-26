# What is CI/CD?

The process of **Streamlining or automating** all the steps involved b/w **Developer Writing and pushing the code to a SCM** and **Customer using the app** is called **CI/CD**

**CI/CD** is a **software development practice** used to **automatically build, test, and deploy applications** whenever developers make changes to the code.

Instead of manually building and deploying software, CI/CD **automates the entire process**. This makes software delivery **faster, more reliable, and less error-prone**.

CI/CD mainly consists of two parts:

## 1️⃣ Continuous Integration (CI)

**Continuous Integration** means developers **frequently merge their code changes into a shared repository** (usually Git).

Whenever new code is pushed to GitHub.

```bash
git push origin feature-login
```

The CI system automatically:

* Pulls the latest code
* Builds the application
* Runs unit tests
* Checks if the code works correctly

If tests fail → the build fails.

If something breaks, the team is notified immediately. This helps developers **detect problems early**.

---

### 2️⃣ Continuous Delivery / Continuous Deployment (CD)

After CI successfully builds and tests the application, **CD handles deployment**.

There are two types:

#### Continuous Delivery

The application is **automatically prepared for deployment**, but **manual approval is required** to deploy to production.

Example flow:

```bash
Build → Test → Package → Ready for Production
```

A DevOps engineer clicks **Deploy** when ready.

---

#### Continuous Deployment

The application is **automatically deployed to production** after passing tests.

Example flow:

```bash
Build → Test → Deploy to Production
```

No manual step required.

---

### Why CI/CD is Important

CI/CD helps teams:

* Deliver software **faster**
* **Reduce manual work**
* Detect bugs **early**
* Improve **code quality**
* Make deployments **reliable**

---

### Popular CI/CD Tools

Common tools used for CI/CD:

| Tool           | Purpose               |
| -------------- | --------------------- |
| Jenkins        | CI/CD automation      |
| GitHub Actions | CI/CD inside GitHub   |
| GitLab CI      | CI/CD inside GitLab   |
| CircleCI       | Cloud CI/CD           |
| ArgoCD         | Kubernetes deployment |

In this section we will mainly use **Jenkins**.

---

## What is a CI/CD Pipeline?

A **CI/CD pipeline** is a **series of automated steps** that move code from **development to production**.

It defines **how code changes are built, tested, and deployed**.

The goal is to **deliver software quickly, safely, and reliably**.

### CI/CD Pipeline – Complete Workflow

A typical CI/CD pipeline consists of the following stages:

```bash
1. Code
2. Build
3. Test
4. Package
5. Store Artifact
6. Deploy
7. Verify / Monitor
```

#### 1. Code Stage

This is where **developers write application code**.

The code is stored in a **Version Control System (VCS)** such as:

* GitHub
* GitLab
* Bitbucket

Developers usually work in **feature branches**.

Example:

```bash
main
│
├── feature-login
├── feature-payment
└── bugfix-navbar
```

After development, the developer pushes code:

```bash
git add .
git commit -m "Add login feature"
git push origin feature-login
```

Then a **Pull Request / Merge Request** is created.

Once merged into `main`, the **CI/CD pipeline is triggered automatically**.

---

#### 2. Pipeline Trigger

The CI/CD pipeline usually starts when:

* Manual trigger
* Scheduled build runs
* Code is pushed to repository
* Pull request is created
* Code is merged to main branch

---

#### 3. Checkout Stage

After the pipeline is triggered, the first step is to **fetch the latest code from the Git repository**.

This process is called **Checkout**. The CI/CD tool (e.g., Jenkins) downloads the source code so it can build and test the application.

After checkout, the application source code is available in the **pipeline workspace**.

---

#### 4. Install Dependencies Stage

Most applications rely on **external libraries or packages** to run.
These required packages are called **dependencies**.

In this stage, the pipeline installs all dependencies needed to build and run the application.

Dependencies are usually defined in files like:

| Technology    | Dependency File    |      Example                          |
| ------------- | ------------------ |---------------------------------------|
| NodeJS        | `package.json`     | ```npm install```                     |
| Python        | `requirements.txt` | ```pip install -r requirements.txt``` |
| Java (Maven)  | `pom.xml`          | ```mvn dependency:resolve```          |

---

#### 5. Build Stage

In this stage the system **compiles or builds the application**.

The goal is to convert **source code into runnable software**.

Examples:

##### Java Application

```bash
mvn clean package
```

##### NodeJS Application

```bash
npm install
npm run build
```

##### React Application

```bash
npm install
npm run build
```

##### Python Application

```bash
pip install -r requirements.txt
```

If the build fails → **pipeline stops**.

---

#### 6. Test Stage

After building the application, **automated tests are executed**.

Purpose:

* Detect bugs early
* Ensure new changes don't break existing code

Common test types:

| Test Type         | Purpose                             |
| ----------------- | ----------------------------------- |
| Unit Tests        | Test small pieces of code           |
| Integration Tests | Test interaction between components |
| API Tests         | Test APIs                           |
| UI Tests          | Test frontend                       |

Example:

```bash
npm test
```

or

```bash
pytest
```

If tests fail:

```bash
Pipeline stops
Developer fixes the issue
```

---

#### 7. Code Quality & Security Checks (Optional but Common)

Static Code Analysis: *Reviewing Source code without actually running it to **find bugs, security vulnerabilites and check code quality** early in SDLC*.

Many pipelines include **static analysis tools**.

These check:

* Code quality
* Code smells
* Security vulnerabilities

Example tools:

| Tool      | Purpose                          |
| --------- | -------------------------------- |
| SonarQube | Code quality                     |
| Snyk      | Security scanning                |
| Trivy     | Container vulnerability scanning |

Example:

```bash
Code → SonarQube Scan → Quality Gate
```

If quality gate fails → pipeline fails.

---

#### 8. Package Stage

Once the code passes tests, the application is **packaged for deployment**.

Packaging depends on the application type.

Examples:

##### Docker Image

```bash
docker build -t portfolio-app:v1 .
```

##### Java JAR file

```bash
target/app.jar
```

##### NodeJS build folder

```bash
dist/
build/
```

Most modern pipelines package applications as **Docker containers**.

Example:

```bash
portfolio-app:v1
```

---

#### 9. Store Artifact

The built application is stored in an **Artifact Repository**.

Examples:

| Artifact        | Storage          |
| --------------- | ---------------- |
| Docker Images   | Docker Hub / ECR |
| JAR files       | Nexus            |
| Build artifacts | Artifactory      |

Example pushing Docker image:

```bash
docker push dockerhub/portfolio-app:v1
```

Now the application version is safely stored.

---

#### 10. Deploy Stage

After packaging, the application is **deployed to an environment**.

**Deployment environments** usually follow this order:

```bash
Dev → Staging → Production
```

##### Example Deployment Flow

```bash
Build → Test → Deploy to Dev → Test → Deploy to Staging → Approval → Deploy to Production
```

##### Example Deployment to Server

Using SSH:

```bash
docker pull dockerhub/portfolio-app:v1
docker run -d -p 80:80 portfolio-app:v1
```

##### Example Deployment to Kubernetes

```bash
kubectl apply -f deployment.yaml
```

Kubernetes pulls the new Docker image and updates the application.

---

#### 11. Post Deployment Verification

After deployment, the system checks if the application is **running correctly**.

Common checks:

* Health checks
* Smoke tests
* API checks
* Load balancer checks

Example health check:

```bash
GET /health
Response: 200 OK
```

If something fails:

```bash
Rollback deployment
```

---

#### 12. Monitoring & Feedback

After deployment the system is continuously monitored.

Tools used:

| Tool       | Purpose               |
| ---------- | --------------------- |
| Prometheus | Metrics               |
| Grafana    | Monitoring dashboards |
| ELK Stack  | Logs                  |
| CloudWatch | AWS monitoring        |

Example metrics monitored:

* CPU usage
* Memory usage
* Response time
* Error rate

If problems occur:

```bash
Alert → DevOps team → Fix issue
```

---

### Complete CI/CD Pipeline Example (Real DevOps Flow)

Example: **React Application deployed to AWS**

```bash
Developer pushes code → GitHub
           │
           ▼
GitHub Webhook triggers Jenkins
           │
           ▼
Jenkins Checkout Code from SCM
           │
           ▼
Install dependencies
npm install
           │
           ▼
Build application
npm run build
           │
           ▼
Run tests
npm test
           │
           ▼
Build Docker image
docker build -t portfolio:v1 .
           │
           ▼
Push image to DockerHub
docker push portfolio:v1
           │
           ▼
Deploy to Kubernetes / EC2
           │
           ▼
Load balancer serves traffic
```

---

### Visual Workflow

```bash
Developer
   │
   ▼
Git Push
   │
   ▼
CI Pipeline
   ├── Build
   ├── Test
   └── Security Scan
   │
   ▼
Package
(Docker Image)
   │
   ▼
Artifact Registry
(DockerHub/ECR)
   │
   ▼
CD Pipeline
   ├── Deploy to Dev
   ├── Deploy to Staging
   └── Deploy to Production
   │
   ▼
Monitoring & Feedback
```
