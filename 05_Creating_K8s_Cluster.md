# General Steps to Create a Kubernetes Cluster

## 1. Infarstructure Setup

Create Resources your cluser need like in AWS - VPC, Subnets, Security Groups, IAM Roles, etc.

## 2. Control Plane Setup

Install and configure the Kubernetes control plane components (API server, etcd, controller manager, scheduler) on the master node(s).

## 3. Worker Node Setup

Launch worker Nodes and install the necessary Kubernetes components (kubelet, kube-proxy, container runtime) on each worker node.

Connect Worker Nodes to the Control Plane.

## 4. Cluster Networking Setup

Setup pod netowrk (CNI), so pods can talk to each other.

## 5. Authentication and Kubectl configuration

Configur kubctl to connect to new cluser using a kubeconfig file.

## 6. Deploy Workload - (kubectl apply)

Use (kubectl apply) to run you app, services etc.

## 7. Manage lifecycle of the cluster

Scale, upgrade or deletee cluser safely - (kubectl get, describe, delete, etc.)

There are many tools for managing Kubernetes lifecycle. Basically all tools follow same steps, but automate different parts of the same process.

---

---

## Creating a Kubernetes Cluster using Minikube

> Minikube is a single node loacl Kubernets cluester

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
