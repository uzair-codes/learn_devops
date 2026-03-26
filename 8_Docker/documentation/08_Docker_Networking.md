# **Section 8: Docker Networking**

## **1. Why Do We Need Networking in Docker?**

### 👉 Problem

* Containers are **isolated by default**
* They cannot communicate with:

  * Other containers
  * Host machine
  * External world (internet)

### 🎯 Solution

> Docker provides networking to allow communication between containers and outside systems

### 🧠 Simple Idea

* Networking connects:

  * Container ↔ Container
  * Container ↔ Host
  * Container ↔ Internet

---

## **2. Types of Docker Networks**

Docker provides different network types based on use case.
Different Network drivers define how different network works.
Example:

* Bridge driver defines how Bridge Network works
* Host driver defines how Host Network works.

> Specify network driver: `--network driver_name`

### **1. Bridge Network (Default Network)**

> Default network created by Docker
> Bridge driver defines how this network works.

1. In Bridge Network each container gets:
   * Private IP address
   * Internet access (through NAT)
2. Containers can talk to each other using IP, but not name.
3. Containers are not directly accessible from host or outsid world, we need `port binding or mapping` to allow this communication
4. When we create a container without defining `Network Driver`, it is automatically added to `Bridge Network`.

#### 📦 Bridge Network Example

```bash
docker run -d nginx
docker run -d ubuntu
```

➡️ Both are on **bridge network**

#### ❗ Limitation

* Cannot communicate using container name (by default)
* Need IP address

---

### **2. Host Network**

> Container shares the **host machine’s network stack**
> Host driver defines how this network works.

#### 🧠 How it works

* No isolation
* Container uses host ports directly

#### 📦 Host Network Example

```bash
docker run --network host nginx
```

* You can access this nginx server at host_ip:80

#### ✅ Advantage

* High performance (no network overhead)

#### ❌ Disadvantages

* No isolation
* Port conflicts possible

---

### **3. None (Null) Network**

> Container has **no network access**

#### 📦 None Network Example

```bash
docker run --network none nginx
```

#### 🧠 Use Case

* Security testing
* Isolated environments

---

### **4. Custom Bridge Network (VERY IMPORTANT)**

> User-defined bridge network with better features

#### 🎯 Why use it?

* Containers can communicate with each other using **names**
* Better isolation
* Preferred in real projects

#### **Create Custom Network**

```bash
docker network create mynetwork
```

#### **Run Containers in Custom Network**

```bash
docker run -d --name app1 --network mynetwork nginx
docker run -d --name app2 --network mynetwork ubuntu
```

#### 🧠 Communication Example

Inside `app2` container:

```bash
ping app1
```

➡️ Works using **container name** ✅

---

## **3. Important Network Commands**

### 🔹 List Networks

```bash
docker network ls
```

### 🔹 Inspect Network

```bash
docker network inspect mynetwork
```

### 🔹 Create Network

```bash
docker network create mynetwork
```

### 🔹 Remove Network

```bash
docker network rm mynetwork
```

---

## **4. Network Types Comparison**

| Network Type  | Isolation | Communication | Use Case         |
| ------------- | --------- | ------------- | ---------------- |
| Bridge        | Medium    | IP-based      | Default          |
| Host          | None      | Direct        | High performance |
| None          | Full      | No network    | Security         |
| Custom Bridge | Good      | Name-based    | Best for apps    |

---

## 🧠 Real DevOps Example (IMPORTANT)

### 📦 Scenario

* Backend container (Node.js)
* Database container (MongoDB)

### ❌ Without custom network

* Hard to connect (need IP)

### ✅ With custom network

```bash
docker network create app-network

docker run -d --name backend --network app-network node
docker run -d --name db --network app-network mongo
```

### 🎯 Now backend can connect to DB using

```id="1e2zyi"
mongodb://db:27017
```

➡️ Using container name `db` ✅

---

## 🔥 Key Insight (Interview)

> Custom bridge networks allow containers to communicate using **names instead of IPs**, making them ideal for microservices

---

## 🔚 Summary

* Docker networking enables communication
* Types:

  * Bridge (default)
  * Host (no isolation)
  * None (no network)
  * Custom Bridge (best option)
