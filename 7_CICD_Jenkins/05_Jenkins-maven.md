# 1. What is Apache Maven?

**Maven** is a **build automation and project management tool** mainly used for **Java projects**.

It helps developers **compile code, manage dependencies, run tests, and create deployable packages automatically**.

Before tools like Maven, developers had to:

* Download libraries manually
* Manage classpaths manually
* Write complex build scripts

Maven **automates all of this**.

## Simple Definition

> Maven is a tool that **builds your application and manages external libraries automatically**.

---

## 2. Why Maven is Used

Maven solves many problems in software development.

### 1️⃣ Dependency Management

Applications need many external libraries.

Example:

* Logging library
* JSON parser
* Database drivers

Instead of downloading them manually, Maven **downloads them automatically from repositories**.

Example dependency:

```xml
<dependency>
  <groupId>org.springframework</groupId>
  <artifactId>spring-core</artifactId>
  <version>5.3.30</version>
</dependency>
```

Maven will automatically download it from the **central repository**.

---

### 2️⃣ Standard Project Structure

Maven enforces a **standard directory structure**.

```bash
my-project
│
├── src
│   ├── main
│   │   ├── java
│   │   └── resources
│   │
│   └── test
│       └── java
│
├── pom.xml
└── target
```

Explanation:

| Folder             | Purpose                 |
| ------------------ | ----------------------- |
| src/main/java      | Application source code |
| src/test/java      | Test code               |
| src/main/resources | Config files            |
| target             | Compiled output         |

Because of this standard, **all Maven projects look similar**, which makes them easier to understand.

---

### 3️⃣ Build Automation

Maven automates tasks like:

* Compiling code
* Running tests
* Packaging application
* Creating JAR/WAR files
* Deploying artifacts

---

### 4️⃣ Dependency Version Control

Maven ensures **correct versions of libraries** are used.

It also resolves **dependency conflicts automatically**.

---

## 3. Maven Architecture

Main components of Maven:

```bash
Developer
   │
   ▼
pom.xml
   │
   ▼
Maven
   │
   ▼
Repositories
   │
   ▼
Dependencies Downloaded
   │
   ▼
Build Application
```

---

## 4. Maven Key Concepts

### 1️⃣ POM (Project Object Model)

The **heart of Maven** is the **pom.xml** file.

POM contains:

* Project information
* Dependencies
* Plugins
* Build configuration

Example:

```xml
<project>
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.company.app</groupId>
    <artifactId>my-app</artifactId>
    <version>1.0</version>

</project>
```

Explanation:

| Field      | Meaning           |
| ---------- | ----------------- |
| groupId    | Organization name |
| artifactId | Project name      |
| version    | Project version   |

Example artifact:

```bash
com.company.app:my-app:1.0
```

---

### 2️⃣ Maven Repositories

Repositories store **libraries and dependencies**.

Types:

#### Local Repository

Location:

```bash
~/.m2/repository
```

Dependencies are downloaded and stored locally.

---

#### Central Repository

The main public Maven repository:

Used automatically by Maven.

Example libraries stored there.

---

#### Remote Repository

Organizations may host private repositories.

Example:

* Nexus
* Artifactory

---

### 3️⃣ Dependencies

Dependencies are **external libraries used in a project**.

Example:

```xml
<dependencies>

  <dependency>
    <groupId>junit</groupId>
    <artifactId>junit</artifactId>
    <version>4.13</version>
  </dependency>

</dependencies>
```

Maven downloads it automatically.

---

## 5. Maven Build Lifecycle

Maven build runs through **phases**.

Main lifecycle:

```bash
Validate
Compile
Test
Package
Verify
Install
Deploy
```

### Important Phases

| Phase    | What it does                 |
| -------- | ---------------------------- |
| validate | Checks project structure     |
| compile  | Compiles source code         |
| test     | Runs unit tests              |
| package  | Creates JAR/WAR              |
| install  | Stores package in local repo |
| deploy   | Uploads to remote repo       |

Example command:

```bash
mvn package
```

This will:

1. Compile code
2. Run tests
3. Create JAR file

Output goes to:

```bash
target/
```

---

## 6. Maven Plugins

Maven uses **plugins** to perform tasks.

Examples:

| Plugin                | Purpose           |
| --------------------- | ----------------- |
| maven-compiler-plugin | Compile Java code |
| maven-surefire-plugin | Run tests         |
| maven-jar-plugin      | Create JAR file   |

Example:

```xml
<build>
  <plugins>

    <plugin>
      <artifactId>maven-compiler-plugin</artifactId>
      <version>3.10.1</version>
    </plugin>

  </plugins>
</build>
```

---

## 7. Important Maven Commands

| Command     | Purpose               |
| ----------- | --------------------- |
| mvn compile | Compile project       |
| mvn test    | Run tests             |
| mvn package | Create JAR/WAR        |
| mvn clean   | Delete target folder  |
| mvn install | Install to local repo |
| mvn deploy  | Deploy to remote repo |

Example:

```bash
mvn clean install
```

Steps:

1. Remove old build
2. Compile code
3. Run tests
4. Create package
5. Install locally

---

## 8. Output of Maven Build

Example result:

```bash
target/my-app-1.0.jar
```

This **JAR file** can be deployed to servers.

---

## 9. Jenkins – Maven Integration

Now let's see how **Maven works with**
Jenkins.

In CI/CD pipelines, Jenkins automatically **builds projects using Maven**.

---

## 10. Why Integrate Jenkins with Maven

Jenkins + Maven helps automate:

* Code build
* Dependency download
* Running tests
* Creating artifacts
* Deployment

Example workflow:

```bash
Developer pushes code
        │
        ▼
GitHub
        │
        ▼
Jenkins Job Triggered
        │
        ▼
Maven Build
        │
        ▼
Artifact Generated
```

---

## 11. Jenkins + Maven Complete Steps

### Step 1 — Install Maven on Jenkins Server

On Linux server:

```bash
sudo apt install maven
```

Verify:

```bash
mvn -version
```

---

### Step 2 — Configure Maven in Jenkins

Open Jenkins:

```bash
Manage Jenkins
   ↓
Global Tool Configuration
   ↓
Maven
```

Add Maven:

```bash
Name: Maven-3
Install Automatically: ✓
Version: Maven 3.x
```

Save configuration.

---

### Step 3 — Create Jenkins Job

Go to Jenkins Dashboard:

```bash
New Item
```

Choose:

```bash
Freestyle Project
```

Example name:

```bash
java-app-build
```

---

### Step 4 — Configure Source Code

Under:

```bash
Source Code Management
```

Select:

```bash
Git
```

Provide repository URL:

```bash
https://github.com/example/java-app.git
```

---

### Step 5 — Add Build Step

Go to:

```bash
Build
   ↓
Add Build Step
   ↓
Invoke top-level Maven targets
```

Set:

```bash
Goals: clean package
```

This runs:

```bash
mvn clean package
```

---

### Step 6 — Run the Job

Click:

```bash
Build Now
```

Jenkins will:

1. Pull code from Git
2. Run Maven build
3. Download dependencies
4. Run tests
5. Generate JAR/WAR

Output example:

```bash
target/myapp.jar
```

---

## 12. Example Jenkins Pipeline with Maven

Instead of Freestyle jobs, modern CI uses **pipeline**.

Example:

```groovy
pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                git 'https://github.com/example/java-app.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

    }
}
```

---

## 13. Full CI/CD Flow (Jenkins + Maven)

```bash
Developer
   │
   ▼
Git Push
   │
   ▼
Jenkins Trigger
   │
   ▼
Maven Build
   │
   ▼
Run Tests
   │
   ▼
Generate JAR/WAR
   │
   ▼
Deploy Application
```

---

## 14. Why Jenkins + Maven is Powerful

Benefits:

✔ Automated builds
✔ Faster development
✔ Consistent builds
✔ Automatic dependency management
✔ Easy CI/CD pipelines

---

✅ **Simple Summary**

| Tool            | Purpose                         |
| --------------- | ------------------------------- |
| Maven           | Build and dependency management |
| Jenkins         | CI/CD automation                |
| Jenkins + Maven | Automated application builds    |

---
