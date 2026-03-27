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

* J**ava (required)
* **Check Java**: `java -version`
* If Java is not installed:
  * Ubuntu: `sudo apt update && sudo apt install openjdk-21-jdk -y`

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

*Install Java on this machine.*

### Step 2 — Add New Node in Jenkins

Open Jenkins dashboard.

* Manage Jenkins
* Click: Nodes
* Then click: New Node
* Enter:
  * Node name: agent-1
  * Type: Permanent Agent
* Click **Create**

### Step 3 — Configure Agent

Fill the following fields.

* **Number of Executors**: 2
  * Meaning: Agent can run **2 builds at the same time**
* **Remote Root Directory** Directory where Jenkins stores files
  * Example: `/home/ubuntu/jenkins`
  * Create it on agent machine: `mkdir -p /home/ubuntu/jenkins`
* **Labels**
  * Optional but useful.
  * Example: agent-1, linux, docker
  * This allows jobs to run on specific agents.
  * Example pipeline:
    * agent { label 'docker' }
* **Usage**
  * Choose: Use this node as much as possible
* **Launch Method**
  * Select: Launch agent by connecting it to the controller
* Click **Save**

### Step 4 — Connect Agent to Jenkins

After saving Jenkins will show a page with **commands to run on the agent machine**.

#### **Commands to Run on agent server:**

```bash
mkdir -p /home/ubuntu/jenkins
curl -O http://<jenkins-controller-ip>:8080/jnlpJars/agent.jar
java -jar agent.jar \
  -url http://<jenkins-controller-ip>:8080/ \
  -secret XXXXX \
  -name "agent-1" \
  -workDir "/home/ubuntu/jenkins"
```

#### Examples

```bash
curl -sO http://13.201.35.46:8080/jnlpJars/agent.jar
java -jar agent.jar \
  -url http://13.201.35.46:8080/ \
  -secret 4f2e0fc7f7cef26f377281177a2eea530afce821d36d3a4c83494f8faae15ee1 \
  -name "agent-1" \
  -webSocket \
  -workDir "/home/ubuntu/jenkins"
```

If successful you will see:

```bash
INFO: Connected
```

Now Jenkins agent is **online**.

### Step 5 — Verify Agent

* Go to: **Manage Jenkins → Nodes**
* You should **see: agent-1  (online)**

Now Jenkins can run jobs on this machine.

### Setp 6 👉 Right now your agent is running in the **foreground (manual session)**

So when you close the browser/terminal → the process stops → agent goes **offline**. In current setup you need to run Step 4 commands every time, Because this is running like a normal process (not persistent)

#### ✅ Proper Solution (Production Way)

You should run the agent as a **background service (systemd)**
So it:

* ✔ Starts automatically on boot
* ✔ Stays running even if you close terminal
* ✔ Auto-reconnects to Jenkins

#### 🚀 Step-by-Step Fix (Recommended)

##### 1. Move agent files

```bash
mkdir -p /home/ubuntu/jenkins
cd /home/ubuntu/jenkins

curl -O http://<jenkins-controller-ip>:8080/jnlpJars/agent.jar
```

##### 2. Create systemd service

```bash
sudo vim /etc/systemd/system/jenkins-agent.service
```

Paste this 👇

```ini
[Unit]
Description=Jenkins Agent
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/home/ubuntu/jenkins
ExecStart=/usr/bin/java -jar /home/ubuntu/jenkins/agent.jar \
  -url http://<jenkins-controller-ip>/ \
  -secret 4f2e0fc7f7cef26f377281177a2eea530afce821d36d3a4c83494f8faae15ee1 \
  -name "agent-1" \
  -webSocket \
  -workDir "/home/ubuntu/jenkins"
Restart=always

[Install]
WantedBy=multi-user.target
```

##### 3. Reload systemd

```bash
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
```

##### 4. Start agent

```bash
sudo systemctl start jenkins-agent
```

##### 5. Enable auto-start (VERY IMPORTANT)

```bash
sudo systemctl enable jenkins-agent
```

##### 6. Check status

```bash
sudo systemctl status jenkins-agent
```

##### ✅ Now What Happens?

✔ Agent will stay **online permanently**
✔ Even if:

* You close browser ❌
* You logout ❌
* Server restarts ❌

✔ Jenkins will reconnect automatically

---

## Method 2 — Configure Docker as Jenkins Agent

Docker agents are **very common in modern CI/CD**.

Benefits:

* Clean environment
* Easy scaling
* Fast builds
* No dependency conflicts

### Step 1 — Install Docker on Jenkins Server

```bash
sudo apt update && sudo apt install docker.io -y
sudo systemctl start docker && sudo systemctl enable docker
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

* Manage Jenkins
* Click: Manage Plugins
* Install:
  * Docker
  * Docker Pipeline
  * Docker API
  * Docker Commons

---

### Step 3 — Configure Docker Cloud

Go to:

* Manage Jenkins → Clouds → Add New Cloud
* Name cloud
* Select: Docker

---

### Step 4 — Configure Docker Cloud details

* This tells Jennkins: 👉 “Where is Docker running?”
* If You installed Docker on the same Server as Jenkins, use:

* **Docker Host URI:** `unix:///var/run/docker.sock`
  * Click: `Test Connection`
  * If test fails ❌
    * Run this:
      * `sudo usermod -aG docker jenkins`
      * `sudo systemctl restart jenkins`

👉 Without this, Jenkins cannot access Docker socket

---

### Step 5 — Add Docker Agent Template

* Click: Add Docker Template

#### ✅ **`1. Basic Fields`**

| Field        | Value                   | Why                  |
| ------------ | ----------------------- | -------------------- |
| Labels       | `docker-agent`          | Used in pipeline     |
| Enabled      | ✅ Checked              | Must be enabled      |
| Name         | `docker-agent`          | Optional but cleaner |
| Docker Image | `jenkins/inbound-agent` | Official agent       |

##### **Docker Image**

Example: **👉 Official Jenkins agent image**

* `jenkins/inbound-agent`
  * 👉 `jenkins/inbound-agent` image is minimal, It DOES NOT have: `terraform`, `ansible`, `aws cli` etc.
    * So `terraform` and ansible `commands` will fail in container
    * Best solution: Create Your own Docker Image

###### Creat and Push docker image on docker hub

Example: `Dockerfile`

```Dockerfile
FROM jenkins/inbound-agent

USER root

RUN apt update && apt install -y \
    ansible \
    curl \
    unzip \
    python3-pip

# Install Terraform
RUN curl -fsSL https://releases.hashicorp.com/terraform/1.5.0/terraform_1.5.0_linux_amd64.zip -o terraform.zip \
    && unzip terraform.zip \
    && mv terraform /usr/local/bin/ \
    && rm terraform.zip
```

✅ **`Step-by-Step: Push Docker Image to Docker Hub`**

✅ **Step 1: Go to your project folder**

Make sure your `Dockerfile` is in your current directory:

```bash
cd /path/to/your/dockerfile
```

Check:

```bash
ls
```

You should see:

```txt
Dockerfile
```

✅ **Step 2: Build Docker Image**

Run this command to build your image:

```bash
docker build -t docker_username/image_name .
docker build -t docker_username/jenkins-agent-ansible-terraform .
```

Explanation:

* `docker build` → builds image
* `-t` → tag (name of image)
* `docker_username/...` → **must match your Docker Hub username**
* `.` → current directory

✅ **Step 3: Check Image is Created**

```bash
docker images
```

You should see something like:

```txt
REPOSITORY                          TAG       IMAGE ID
docker_username/jenkins-agent-ansible-terraform   latest    abc123
```

✅ **Step 4: Login to Docker Hub**

```bash
docker login
```

Enter:

* Username: `docker_user_name`
* Password: (your Docker Hub password or access token)

✅ **Step 5: Create Repository on Docker Hub**

Go to: [https://hub.docker.com/](https://hub.docker.com/)

1. Click **Create Repository**
2. Name: `jenkins-agent-ansible-terraform`
3. Keep it **Public** (or Private if you want)
4. Click **Create**

✅ **Step 6: Push Image to Docker Hub**

```bash
docker push docker_username/jenkins-agent-ansible-terraform
```

⏳ It will take some time depending on image size.

✅ Step 7: Verify on Docker Hub

Go to your repo:

👉 [https://hub.docker.com/repositories](https://hub.docker.com/repositories)

You should see your image there 🎉

💡 **`Pro Tips`**

* **`Reduce Image Size`**
  * Your image installs many tools → it will be large
  * Later you can optimize using:
    * `--no-install-recommends`
    * multi-stage builds
* **`Use .dockerignore`**
  * Create `.dockerignore` file:
    * .git
    * node_modules
    * *.log
* **`Test Image Before Push`**
  * `docker run -it docker_username/jenkins-agent-ansible-terraform bash`
  * Check:
    * `ansible --version`
    * `terraform version`

---

#### ⚠️ **`2. Container Settings`**

##### 🔑 Docker Command

👉 **Leave Docker Command EMPTY**

Because:

> If empty, Jenkins uses default command for inbound-agent

##### 🔑 User

👉 Leave EMPTY (recommended)

OR:

```bash
root
```

✔ Use root if you face permission issues later

##### 🔑 Mounts

In **Mounts field**, add:

```bash
type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock
```

👉 This allows:

* Docker inside container
* Future CI/CD builds
* Without this:
  * ❌ Docker commands inside pipeline will fail

#### 🧩 **`3. Instance Settings`**

| Field             | Value                             |
| ----------------- | --------------------------------- |
| Instance Capacity | 5                                 |
| Remote FS Root    | `/home/jenkins`                   |
| Usage             | Use this node as much as possible |
| Idle Timeout      | 10                                |

#### 🧩 **`4. Connect Method`**

* **Select:** `Connect with JNLP`
* **Jenkins URL** `http://<jenkins_controller_ip>:8080`
* **EntryPoint Arguments**
  * 👉 Leave EMPTY
  * Because: `If empty → Jenkins automatically uses correct arguments for inbound-agent`

#### 🧩 **`5. Advanced Settings`**

| Field          | Value                      |
| -------------- | -------------------------- |
| Stop timeout   | 10                         |
| Remove volumes | ✅ Checked                 |
| Pull strategy  | Pull all images every time |
| Pull timeout   | 300                        |

✔ Your values are good

#### 🧩 6. **`Node Properties`**

👉 Leave empty for now

* Click **Save**

#### ❗ **`Expected Behavior`**

When you run pipeline:

👉 Jenkins will:

1. Pull image
2. Start container
3. Connect via JNLP
4. Run job
5. Destroy container

---

### Step 6 — Use Docker Agent in Pipeline

Example:

```groovy
agent {
    label 'docker-agent'
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

### 3. Use Docker Agents for CI/CD

Advantages:

* Clean environment every build
* No dependency conflicts
* Faster pipelines

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
