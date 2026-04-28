# Services (How Users Access Your Application)

Good move — this is where Kubernetes becomes **practically usable**.

Right now:

* Pods are running ✅
* Deployments are managing them ✅
* But users still **cannot access your app** ❌

👉 That’s exactly what **Services** solve.

## 🔹 Why Do We Need Services?

Let’s start with the problem 👇

### ⚠️ Problem with Pods

Pods are:

* Temporary (can die anytime)
* Dynamic (IP keeps changing)

### 🔸 Example Problem

You have a Pod:

```id="s4h4lg"
Pod IP: 10.244.1.5
```

If the Pod restarts:

```id="u9d1cc"
New IP: 10.244.2.8
```

👉 Now your application breaks ❌

---

## 🔹 What is a Service?

A **Service** in **Kubernetes** is:

> 👉 A stable way to access a group of Pods

### 🔸 Simple Definition

> Service = A fixed entry point to access Pods

### 🔸 Key Idea

Instead of connecting to Pods directly connect to a Service:

❌ Pod IP (changes)
✅ Service (stable)

---

## 🔹 What Does a Service Do?

A Service provides:

### ✅ 1. Stable IP Address

* Service gets a fixed IP
* Does NOT change

### ✅ 2. Load Balancing

* Distributes traffic across multiple Pods

### ✅ 3. Service Discovery

* Pods can talk using service names instead of IPs

---

## 🔹 How Service Works (Core Concept)

Service uses:

👉 **Labels & Selectors**

### 🔸 Example

Pods have labels:

```yaml id="a7fz9n"
labels:
  app: my-app
```

Service selects them using selectors:

```yaml id="3z6z8y"
selector:
  app: my-app
```

👉 Now Service connects to ALL matching Pods

---

## 🔹 Types of Services (Very Important)

There are **4 main types**:

### ✅ 1. ClusterIP (Default)

#### 🔸 What it does

* Exposes Service **inside the cluster only**

#### 🔸 Use Case

* Backend services
* Internal communication

#### 🔸 Example

Frontend → Backend (inside cluster)

---

## ✅ 2. NodePort

### 🔸 What it does

* Exposes Service on a **port of each node**

### 🔸 Access

```id="j4z1nt"
<NodeIP>:<NodePort>
```

#### 🔸 Use Case

* Testing
* Simple external access

---

## ✅ 3. LoadBalancer

### 🔸 What it does

* Creates an external load balancer (cloud)

#### 🔸 Supported on

* Amazon Web Services
* Google Cloud
* Microsoft Azure

### 🔸 Result

👉 You get a public IP to access your app

---

## ✅ 4. ExternalName

### 🔸 What it does:

* Maps service to external DNS

### 🔸 Example

```id="w3v7n0"
google.com
```

---

## 🔹 Service Flow (Very Important)

```id="0q4o5v"
User → Service → Pods
```

### 🔸 What happens:

1. User hits Service
2. Service selects Pods
3. Traffic distributed automatically

---

## 🔹 Service YAML Example

```yaml id="3mdt7k"
apiVersion: v1
kind: Service
metadata:
  name: my-service

spec:
  type: NodePort

  selector:
    app: my-app

  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
      nodePort: 30007
```

---

## 🔹 Explanation (Simple)

### 🔸 type

```yaml id="5v0frk"
type: NodePort
```

👉 How service is exposed

### 🔸 selector

```yaml id="gsd8sd"
app: my-app
```

👉 Which Pods to connect

### 🔸 ports

* `port`: Service port
* `targetPort`: Container port
* `nodePort`: External port

---

## 🔹 Important Concept: Service is NOT Pod

👉 Service does NOT run containers
👉 It only **routes traffic**

---

## 🔹 Real-World Example

You have:

* 3 Pods running your app

User sends request:

👉 Service distributes traffic like:

```id="6fs5q9"
User → Pod1
User → Pod2
User → Pod3
```

---

## 🔁 Deployment + Service Together

```id="6c5nqf"
Deployment → Create and Manage Pods
Service → Access Pods
```

---

## 🧠 Final Understanding

> Pods run your app
> Deployments manage Pods
> Services expose your app

👉 Together they form a complete system

---
