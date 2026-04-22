# Creating a Kubernetes Cluster

## 🔹 Introduction

Before deploying applications, you need a **Kubernetes Cluster**.

A cluster consists of:

* **Control Plane (manages the cluster)**
* **Worker Nodes (run applications)**

There are two main ways to create a cluster:

1. **Manual Setup** (learning purpose)
2. **Automated Tools / Managed Services** (real-world usage)

👉 Regardless of the method, the **core steps remain the same**

---

## ⚙️ General Steps to Create a Kubernetes Cluster

### ✅ 1. Infrastructure Setup

First, you create the **underlying infrastructure**.

#### 🔸 What you need

* Virtual machines / servers
* Networking setup
* Security configurations

#### 🔸 Example (Cloud like Amazon Web Services)

* VPC (Virtual Private Cloud)
* Subnets
* Security Groups
* IAM Roles

#### 🔸 Goal

👉 Prepare the environment where Kubernetes will run

---

### ✅ 2. Control Plane Setup

Now you set up the **brain of Kubernetes**

#### 🔸 Components Installed

* API Server
* etcd (database)
* Scheduler
* Controller Manager

#### 🔸 What Happens

* Control Plane starts managing the cluster
* Provides API for communication

#### 🔸 Note

👉 In production, Control Plane is usually:

* Highly available (multiple nodes)

---

### ✅ 3. Worker Node Setup

Next, you add machines that will run your applications

#### 🔸 Components Installed

* Kubelet (node agent)
* Kube-Proxy (networking)
* Container Runtime (e.g., containerd)

#### 🔸 What Happens

* Worker nodes join the cluster
* They connect to Control Plane

#### 🔸 Result

👉 Cluster becomes ready to run workloads

---

### ✅ 4. Cluster Networking Setup (CNI)

Kubernetes needs networking to allow communication between Pods

#### 🔸 What you install

👉 **CNI (Container Network Interface)** plugin

Examples:

* Flannel
* Calico

#### 🔸 What it does

* Assigns IPs to Pods
* Enables Pod-to-Pod communication

#### 🔸 Result

👉 All Pods can talk to each other across nodes

---

### ✅ 5. Authentication & kubectl Configuration

Now you configure access to the cluster

#### 🔸 Tool Used

👉 `kubectl` (Kubernetes CLI)

#### 🔸 What you do

* Set up **kubeconfig file**
* Define cluster credentials

#### 🔸 Example Command

```bash
kubectl get nodes
```

👉 Confirms connection to cluster

---

### ✅ 6. Deploy Workloads

Now your cluster is ready 🎉

#### 🔸 What you do

* Deploy Pods, Deployments, Services

#### 🔸 Example

```bash
kubectl apply -f deployment.yaml
```

#### 🔸 Result

👉 Applications start running inside the cluster

---

### ✅ 7. Manage Cluster Lifecycle

After setup, you continuously manage the cluster

#### 🔸 Common Tasks

* Scaling nodes
* Upgrading Kubernetes version
* Monitoring health
* Deleting resources

#### 🔸 Common Commands

```bash
kubectl get pods
kubectl describe pod <name>
kubectl delete pod <name>
```

---

## 🔹 Important Real-World Note ❗

* 👉 In real-world DevOps, we rarely “manually install everything” anymore
* 👉 Instead, we use tools that automate these steps (like managed services or bootstrap tools)
* 👉 All Kubernetes tools follow the same **fundamental process**, but they **automate different parts** of cluster creation and management.

---

## 🔹 Popular Tools for Cluster Creation

### 🔸 Local / Learning

* Minikube
* Kind

### 🔸 Production / Cloud

* Kops (AWS)
* Amazon EKS
* Google Kubernetes Engine
* Azure Kubernetes Service

### 🔸 Bootstrap Tools

* kubeadm

---

## 🔁 Simple Flow (Easy to Remember)

```text
Infrastructure → Control Plane → Worker Nodes → Networking → Access → Deploy Apps → Manage
```

---

# Creating a Kubernetes Cluster using Minikube

> Minikube is a single node local Kubernets cluester

## 1. Install Requirements

### ✅ Install Hypervisor (choose one)

* VirtualBox (recommended for beginners) → Oracle VM VirtualBox
* OR use Docker → Docker

👉 If your system supports Docker → use Docker (faster)

---

### ✅ Install kubectl (Kubernetes CLI)

* Download from → kubectl
* Linux:

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
```

Verify:

```bash
kubectl version --client
```

---

### ✅ Install Minikube

* Download from → Minikube

Linux:

```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```

Verify:

```bash
minikube version
```

---

## 2. Start Kubernetes Cluster

### ▶️ Start Minikube

If using Docker:

```bash
minikube start --driver=docker
```

If using VirtualBox:

```bash
minikube start --driver=virtualbox
```

👉 This will:

* Create VM/container
* Install Kubernetes
* Start cluster

---

## ✅ Check Cluster Status

```bash
minikube status
```

---

## ✅ Check Nodes

```bash
kubectl get nodes
```

Expected:

```text
NAME       STATUS   ROLES    AGE   VERSION
minikube   Ready    control-plane   ...
```

---

## 3. Basic Cluster Operations

## 📦 Create a Deployment

```bash
kubectl create deployment nginx --image=nginx
```

---

## 📊 Check Pods

```bash
kubectl get pods
```

---

## 🌐 Expose Deployment (Service)

```bash
kubectl expose deployment nginx --type=NodePort --port=80
```

---

## 🔗 Access Service

```bash
minikube service nginx
```

👉 Opens browser with app

---

## 4. Useful Minikube Commands

## Open Dashboard

```bash
minikube dashboard
```

---

## SSH into Minikube

```bash
minikube ssh
```

---

## Stop Cluster

```bash
minikube stop
```

---

## Delete Cluster

```bash
minikube delete
```

---

## 5. Enable Add-ons (Important)

```bash
minikube addons enable ingress
minikube addons enable metrics-server
```

---

## 6. Troubleshooting

### If Minikube fails

```bash
minikube delete
minikube start --driver=docker
```

### Check logs

```bash
minikube logs
```

---

## How DevOps Engineers Create Kubernetes Clusters in Real Production Engiornment?

Minikube is a local single node Kubernetes cluster, it's good for learning and using in  development enviornment. But in production, we need a multi-node highly available cluster. So we use tools like:

* Kubeadm (manual setup, more control)
* Kops (AWS)
* EKS (AWS managed)
* GKE (Google managed)
* AKS (Azure managed)

---

## Creating Kubernetes Cluster using Kops

### 🚀 1. What is KOPS

* KOPS is a tool used for creating/managing **production-grade Kubernetes clusters on cloud**
* Works mainly with → Amazon Web Services

---

### ⚙️ 2. Prerequisites

#### ✅ Install Tools

* kubectl
* KOPS
* AWS CLI

#### ✅ AWS Setup

* Create AWS account
* Configure CLI:

```bash
aws configure
```

#### ✅ Create S3 Bucket (for cluster state)

* Stores:
  * Cluster configuration (infra config)
  * Secrets (certs, keys)
* Used by:
  * KOPS (not Kubernetes itself)

```bash
aws s3api create-bucket \
  --bucket my-kops-state-store \
  --region ap-south-1
```

Set env variable:

```bash
export KOPS_STATE_STORE=s3://my-kops-state-store
```

#### Create IAM user

* Create an AWS IAM user for Kops with required permissions (AmazonEC2FullAccess, AmazonS3FullAccess, etc.)

---

### 🌐 3. Create Cluster

While creating K8s cluster using KOPS, we have 2 options:

* Create a gossip cluster (no domain required, uses internal DNS)
  * Example: cluster.k8s.local
  * `.k8s.local` is a special domain for gossip cluster, so it must end with `.k8s.local`
* Create a cluster with a custom domain (requires domain and DNS setup)

#### Step 1: Create Cluster Config

```bash
kops create cluster \
  --name=cluster.k8s.local \
  --zones=ap-south-1a \
  --node-count=2 \
  --node-size=t2.micro \
  --master-size=t2.micro \
  --dns-zone=<your-domain>
```

👉 If no domain:

> meaning when you are creating a gossip cluster, you can add:

```bash
--dns private
```

#### Step 2: Review Config

```bash
kops get cluster
```

#### Step 3: Create Cluster (Apply)

```bash
kops update cluster cluster.k8s.local --yes --admin
```

#### Step 4: Wait & Validate

```bash
kops validate cluster
```

---

### 🔍 4. Verify Cluster

```bash
kubectl get nodes
```

```bash
kubectl get pods -A
```

---

### 📦 5. Deploy Test App

```bash
kubectl create deployment nginx --image=nginx
kubectl expose deployment nginx --type=LoadBalancer --port=80
```

Check:

```bash
kubectl get svc
```

---

### 🧹 6. Delete Cluster

```bash
kops delete cluster cluster.k8s.local --yes
```

---

### 🧠 Important Notes

* KOPS = **Production clusters**
* Requires:

  * AWS account
  * S3 bucket
  * IAM permissions
* Not free (AWS charges)

---

### ⚡ KOPS vs Minikube (Quick)

| Feature  | Minikube    | KOPS       |
| -------- | ----------- | ---------- |
| Use      | Local       | Cloud      |
| Cost     | Free        | Paid       |
| Scale    | Single node | Multi-node |
| Use case | Learning    | Production |

---
