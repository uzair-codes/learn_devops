# Section 1: Old Way of Hosting Applications and Problems

Before Docker and containers, applications were hosted in **traditional ways**. Understanding these problems is **very important**, because Docker is actually the **solution to these problems**.

## **1. Physical Servers (Bare Metal Servers)**

* Hosting application on physical servers.
* One **application** runs on one **physical machine (server)**

### ❌ Physical Servers Problems

#### 1. Huge Resource Wastage

* Servers have **CPU, RAM, Storage**
* Most applications don’t use full resources

👉 Example:

* Server has 16GB RAM
* App uses only 2GB
  ➡️ Remaining **14GB is wasted**

---

#### 2. High Cost

* Need separate server for each app
* Hardware + maintenance cost is very high

---

#### 3. Poor Scalability

* If traffic increases:

  * You need to buy new servers
  * Setup takes time

---

#### 4. Single Point of Failure

* If server crashes → app goes down

---

## **2. Virtual Machines (VMs)**

### 👉 What is VM?

* A **Virtual Machine** is a software-based computer
* Created using a **Hypervisor**

---

### 🧠 Hypervisor

* Software that allows multiple VMs to run on one physical server using **hardware‑level virtualization**. Each VM has a complete seperate gest OS.

👉 Examples:

* VMware
* VirtualBox
* KVM

---

### ✅ Advantages of VMs

#### 1. Better Resource Usage

* Multiple VMs can run on one physical server

👉 Example:

* 1 server → 5 VMs → 5 applications

---

#### 2. Isolation & Security

* Each VM has:

  * Its own OS
  * Its own memory
* So apps don’t affect each other

---

#### 3. Flexibility

* Can run different OS:

  * Linux VM
  * Windows VM

---

### ❌ VM Problems

#### 1. Still Resource Wastage

* Each VM needs:

  * Full OS
  * Kernel
  * Libraries

➡️ This consumes a lot of RAM & CPU

---

#### 2. Heavyweight

* Becasue each VM has its own complete OS, So VM size is large (GBs)
* Boot time is slow

---

#### 3. Less Scalability

* Creating VM takes minutes
* Not suitable for fast scaling

---

## **3. Biggest Problem: "It Works on My Machine"**

This is one of the **most common real-world problems**.

### 👉 What it means

An application works on a developer's machine but fails on another system.

---

### ❗ Why this happens

Different environments:

* OS differences
* Library versions
* Dependencies mismatch
* Configuration issues
* Environment Variable Missing

---

#### ✅ Example

Developer machine uses:

```bash
Node.js = v18
```

Production server:

```bash
Node.js = v14
```

➡️ App may break

---

### ❌ Impact

* Deployment failures
* Debugging becomes difficult
* Wastes time
* Frustrates teams

---

## **4. Solution: Containerization or OS-level virtualization**

To solve all these problems, **Containerization or OS-level virtualization technology** was introduced.

### 👉 What is Containerization

> Package the application **with everything it needs** (code + dependencies + libraries) into a **lightweight software (container)**, so it runs **anywhere consistently**.

Containerization, **Standardizes the runtime environment** by **bundling everything (app + dependencies)** into containers.

### ✅ What it solves

| Problem                  | Solution by Containers      |
| ------------------------ | --------------------------- |
| Resource wastage         | Lightweight, share Host OS  |
| Heavy VMs                | No full OS needed           |
| "It works on my machine" | Same environment everywhere |
| Scaling issues           | Containers are Ephemeral    |
