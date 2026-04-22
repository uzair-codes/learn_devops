# 🧠 What is kubectl?

👉 kubectl is a **command-line tool** used to talk to Kubernetes.

**🔹 Simple meaning:**

👉 **kubectl = remote control of Kubernetes**

## 🧠 Real-life example:

* Kubernetes = machine
* kubectl = remote control
* You = user

You press buttons → machine works

## 🔹 What kubectl does:

Using kubectl, you can:

* Create apps
* Delete apps
* Check status
* Debug problems
* Scale apps

---

# 🔁 How kubectl works (behind the scenes)

When you run a command:

```bash id="zd5mfw"
kubectl get pods
```

👉 This happens:

1. kubectl sends request
2. Goes to Kubernetes API server
3. API server checks data (in etcd)
4. Response comes back

---

# 📦 Most Common kubectl Commands

## 📊 1. View / Check Commands

### 🔹 See nodes (machines)

```bash id="h16thg"
kubectl get nodes
```

### 🔹 See Pods

```bash id="1lrx31"
kubectl get pods
```

### 🔹 See Deployments

```bash id="rkvnyf"
kubectl get deployments
```

### 🔹 See everything

```bash id="6wxqt0"
kubectl get all
```

### 🔹 Detailed info

```bash id="pkvavc"
kubectl describe pod <pod-name>
```

👉 Shows:

* events
* errors
* status

---

## 📦 2. Create / Run Commands

### 🔹 Create Pod

```bash id="w1fscg"
kubectl run mypod --image=nginx
```

### 🔹 Create Deployment

```bash id="udpxxa"
kubectl create deployment myapp --image=nginx
```

### 🔹 Create using YAML

```bash id="n6xq2p"
kubectl apply -f file.yaml
```

👉 Most important command (real-world)

---

## ❌ 3. Delete Commands

### 🔹 Delete Pod

```bash id="ib1wkt"
kubectl delete pod mypod
```

### 🔹 Delete Deployment

```bash id="n7ysh4"
kubectl delete deployment myapp
```

### 🔹 Delete using YAML

```bash id="1dbay2"
kubectl delete -f file.yaml
```

---

## 🔄 4. Update / Scale Commands

### 🔹 Scale Deployment

```bash id="8o9ywz"
kubectl scale deployment myapp --replicas=3
```

### 🔹 Update image

```bash id="bn0xgk"
kubectl set image deployment/myapp nginx=nginx:1.25
```

---

## 📜 5. Logs & Debugging

### 🔹 View logs

```bash id="59hpj9"
kubectl logs <pod-name>
```

### 🔹 Enter Pod (very useful)

```bash id="w2a2bz"
kubectl exec -it <pod-name> -- /bin/bash
```

👉 Like SSH into container

---

## 📂 6. YAML / Config Commands

### 🔹 Generate YAML (very important)

```bash id="2c32tf"
kubectl create deployment myapp --image=nginx --dry-run=client -o yaml
```

### 🔹 Apply changes

```bash id="2tf2yw"
kubectl apply -f deployment.yaml
```

---

## 🧠 Easy Way to Remember

| Action  | Command        |
| ------- | -------------- |
| See     | get            |
| Details | describe       |
| Create  | create / apply |
| Delete  | delete         |
| Scale   | scale          |
| Debug   | logs / exec    |

---

# 🔥 Most Important Commands (Must Remember)

If you remember only these, you're good:

```bash id="ccki61"
kubectl get all
kubectl apply -f file.yaml
kubectl delete -f file.yaml
kubectl describe pod <name>
kubectl logs <pod-name>
kubectl exec -it <pod-name> -- /bin/bash
```

---

