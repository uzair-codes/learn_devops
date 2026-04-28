# 🔹 What is a Kubernetes YAML File?

In **Kubernetes**, a YAML file is:

> 👉 A **declarative configuration file** used to define the desired state of your resources

---

## 🔸 Simple Understanding

You don’t tell Kubernetes *how to do things step-by-step* ❌
You tell it:

```text
"This is what I want"
```

👉 Kubernetes figures out:

* How to create it
* How to maintain it
* How to fix it if something breaks

---

## 🔹 Structure of a Kubernetes YAML File

Every Kubernetes YAML follows a **common structure**

### ✅ 1. apiVersion

```yaml
apiVersion: apps/v1
```

#### 🔸 What it means

* Defines **which Kubernetes API version** to use
* Different resources belong to different API groups

#### 🔸 Examples

| Resource   | apiVersion |
| ---------- | ---------- |
| Pod        | v1         |
| Service    | v1         |
| Deployment | apps/v1    |

#### 🔸 Why important?

👉 Kubernetes APIs evolve over time
👉 Wrong version → resource won’t work

---

### ✅ 2. kind

```yaml
kind: Deployment
```

#### 🔸 What it means

* Defines **what type of object** you are creating

#### 🔸 Examples

* Pod
* Deployment
* Service
* ConfigMap
* Secret

#### 🔸 Simple Understanding

> kind = “What are you creating?”

---

### ✅ 3. metadata

```yaml
metadata:
  name: my-app
  labels:
    app: my-app
```

#### 🔸 What it contains

* Name of resource
* Labels
* (Optional) namespace, annotations

#### 🔸 name

👉 Unique name of resource

#### 🔸 labels (VERY IMPORTANT)

```yaml
labels:
  app: my-app
```

#### 🔹 What are labels?

* Key-value pairs
* Used to **identify resources**

##### 🔹 Why labels matter?

👉 They connect everything in Kubernetes:

* Service → Pods
* Deployment → Pods

##### 🔸 Real Insight

If labels are wrong ❌
👉 Your Service won’t find Pods
👉 Your Deployment won’t manage Pods

---

## ✅ 4. spec (Most Important Section)

```yaml
spec:
  replicas: 3
```

#### 🔸 What it means

> 👉 Defines the **desired state**

#### 🔸 This is where you define

* Number of Pods
* Container image
* Ports
* Volumes
* Networking
* Everything about behavior

#### 🔸 Key Idea

> metadata = identity
> spec = behavior

---

## 🔹 Full Example (Deployment YAML)

Let’s break a real example step-by-step 👇

```yaml
apiVersion: apps/v1
kind: Deployment

metadata:
  name: nginx-deployment
  labels:
    app: nginx

spec:
  replicas: 3

  selector:
    matchLabels:
      app: nginx

  template:
    metadata:
      labels:
        app: nginx

    spec:
      containers:
        - name: nginx-container
          image: nginx:latest

          ports:
            - containerPort: 80
```

---

## 🔍 Deep Explanation (Line by Line)

### 🔹 replicas

```yaml
replicas: 3
```

👉 Keep **3 Pods running at all times**

### 🔹 selector

```yaml
selector:
  matchLabels:
    app: nginx
```

#### 🔸 What it does

* Tells Deployment:
  👉 “Manage Pods with this label”

#### 🔸 Important Rule ❗

👉 selector must match template labels

### 🔹 template (Pod Blueprint)

```yaml
template:
```

#### 🔸 What it means

👉 This defines how Pods should look

##### 🔹 template.metadata

```yaml
labels:
  app: nginx
```

👉 Labels applied to Pods

##### 🔹 template.spec

```yaml
containers:
```

👉 Defines containers inside Pod

##### 🔹 containers

```yaml
- name: nginx-container
  image: nginx:latest
```

##### 🔸 name

👉 Container name

##### 🔸 image

👉 Docker image to run

##### 🔸 ports

```yaml
containerPort: 80
```

👉 Port inside container

---

## 🔹 Important Kubernetes YAML Concepts

### ✅ 1. Indentation (CRITICAL)

YAML is **space-sensitive**

### ✅ 2. Key-Value Format

```yaml
key: value
```

### ✅ 3. Lists (Arrays)

```yaml
containers:
  - name: nginx
  - name: redis
```

👉 `-` means list item

### ✅ 4. Multi-Document YAML

You can define multiple resources in one file:

```yaml
---
apiVersion: v1
kind: Service
---
apiVersion: apps/v1
kind: Deployment
```

### ✅ 5. Comments

```yaml
# This is a comment
```

---
