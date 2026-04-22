# 🚀 1. Directly Running Pods & Deployments (CLI)

## 📦 Create Pod (not recommended in real-world)

```bash
kubectl run mypod --image=nginx
```

### Check:

```bash
kubectl get pods
```

---

## 📦 Create Deployment (recommended)

```bash
kubectl create deployment myapp --image=nginx
```

### 🔁 Scale Deployment

```bash
kubectl scale deployment myapp --replicas=3
```

### 🔄 Update Image

```bash
kubectl set image deployment/myapp nginx=nginx:1.25
```

## ❌ Delete

```bash
kubectl delete pod mypod
kubectl delete deployment myapp
```

---

# ⚠️ Problem with CLI approach

* Not reusable
* Not version controlled
* Hard to manage in real projects

👉 Solution = **YAML files**

---

# 🧾 2. Kubernetes YAML Basics

Every K8s YAML file has **4 main parts**:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
spec:
  # desired state
```

## 🔹 Meaning:

* **apiVersion** → version of API
* **kind** → type (Pod, Deployment, Service)
* **metadata** → name, labels
* **spec** → actual configuration

---

# 📦 3. Pod YAML (Basic)

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  containers:
    - name: nginx
      image: nginx
      ports:
        - containerPort: 80
```

## ▶️ Run it:

```bash
kubectl apply -f pod.yaml
```

## ❌ Delete:

```bash
kubectl delete -f pod.yaml
```

---

# 📦 4. Deployment YAML (Important)

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx

  template:
    metadata:
      labels:
        app: nginx

    spec:
      containers:
        - name: nginx
          image: nginx
          ports:
            - containerPort: 80
```

## 🔥 Important Concepts

### 🔹 replicas

* Number of Pods

### 🔹 selector

* How Deployment finds Pods

### 🔹 template

* Blueprint of Pod

## ▶️ Apply:

```bash
kubectl apply -f deployment.yaml
```

## 🔁 Update YAML (change image):

```yaml
image: nginx:1.25
```

Then:

```bash
kubectl apply -f deployment.yaml
```

👉 Kubernetes does **rolling update automatically**

---

# 🔍 5. View Resources

```bash
kubectl get all
kubectl describe pod mypod
kubectl logs <pod-name>
```

---

# 🧠 6. How YAML is Written (RULES)

## 🔹 Indentation matters (VERY IMPORTANT)

* Use **2 spaces**
* No tabs ❌

---

## 🔹 Lists use `-`

```yaml
containers:
  - name: nginx
```

---

## 🔹 Key: Value format

```yaml
name: myapp
```

---

## 🔹 Nested structure

```yaml
spec:
  containers:
    - name: nginx
```

---

# 🔥 7. Best Practice (Real DevOps)

Never write from scratch ❌

Use:

```bash
kubectl create deployment myapp --image=nginx --dry-run=client -o yaml > deploy.yaml
```

👉 Then edit YAML

---

# 🔥 8. Real-World Flow

1. Write YAML
2. Store in Git
3. Apply:

```bash
kubectl apply -f .
```

4. Update YAML
5. Re-apply

---

