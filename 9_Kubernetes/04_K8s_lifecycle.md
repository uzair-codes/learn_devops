# 🔹 Kubernetes Lifecycle - How Everything Works Together (Step-by-Step)

Let’s understand the **flow** 👇

### 🔸 Step 1: You Give Command

* You write a deployment file (app.yaml), that says:
  * "I want to run 3 replicas of my app:
* Then you run the deployment file using:

```bash
kubectl apply -f app.yaml
```

👉 Request goes to API Server

### 🔸 Step 2: API Server Processes It

* Validates request
* Stores data in etcd

### 🔸 Step 3: Scheduler Decides

* Scheduler Constantly monitors the API server
* It sees new request "3 app pods need home"
* It checks the owkre nodes and decides which node are fit to run Pods (Finds best worker node).
* It updates the API server with the decision (Which nodes will run the pods)

### 🔸 Step 4: Kubelet Runs Containers

* The Kubelet on the selected worker node receives instructions from the API server to run the containers.
* Kublet Creates the Pod and tells the container run time (like docker shim or containerd) to pull the image and run the containers inside the new Pod.

---

### 🔸 Step 5: Kube-Proxy Handles Traffic

* Kube-Proxy sets up networking for the new pods, So the Pod is reachable.
* Routes requests to correct containers

---

### 🔸 Step 4: Controller Ensures State

* Pods start running, Kublet reports back to the API server, which updates etcd with the new state.
* Current State Matches Desired State.
* Controller Manager continuously checks the state of the cluster. If sees the current state matches the desired state, "Job Done".
* If in future any Pod fails, controller manager (via Replicaset controller) will automatically create a new Pod to maintain the desired state.

---

## 🔁 Full Flow Summary

```
User → API Server → etcd
                ↓
            Scheduler
                ↓
        Worker Node (Kubelet)
                ↓
        Container Runtime
                ↓
            Running App
```

---

## Kubernetes Distributions

* Kubernetes is open-source, but many companies offer their own versions (distributions) with extra features and support.

### Most Popular Kubernetes Distributions

* Kubernetes (Open-source)
* OpenShift (Red Hat)
* Rancher (SUSE/Rancher Labs)
* VMware Tanzu (VMware)
* EKS (AWS), AKS (Azure), GKE (Google Cloud)

---
