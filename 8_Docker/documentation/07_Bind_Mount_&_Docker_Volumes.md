# **Section 7: Bind Mount and Docker Volumes**

## **1. Problem: Container Data is NOT Persistent**

### 👉 What happens by default?

* Containers are **temporary (ephemeral)**
* When container is deleted → data is lost ❌

### ❗ Example

```bash
docker run -it ubuntu bash
```

* Create a file inside container
* Exit and remove container

```bash
docker rm <container_id>
```

➡️ File is gone 😱

### 🧠 Why?

* Containers use **temporary writable layer**
* When container is removed → layer is deleted

---

## **2. Solution: Persist Data***

There are **2 ways to persist data in Docker**:

### **1. Bind Mount**

> It connects a **directory from host machine** to a container's directory.

#### **Important Commands (Bind Mount)**

##### 🔹 Run with Bind Mount

```bash
docker run -d \
  -v /home/uzair/app:/app \
  nginx
```

##### 🔹 Alternative Syntax (Recommended)

```bash
docker run -d \
  --mount type=bind,source=/home/uzair/app,target=/app \
  nginx
```

---

#### 📦 Example

```bash
docker run -v /host/data:/container/data nginx
```

#### 🔍 Explanation

```id="8a3fxd"
/host/data → Your system folder
/container/data → Container folder
```

➡️ Both are now **linked**

#### ✅ What happens?

* Changes in container → directly reflect on host
* Changes in host → directly reflect in container

#### 📁 Real Use Case

* Store logs
* Store database files
* Live code development, Code Changes in host folder will be directly reflected in container folder, you don't have to change code and recreated container again and againe.

#### ⚠️ Important Points

* Path must exist on host
* Works with **absolute path**

---

### **2. Docker Volumes**

#### 👉 What is Docker Volume?

> A docker volume is a **managed storage** created and controlled by Docker on the host machine's filesystem.

* Docker manages storage internally

#### 📦 Location

* BOTH Named and Anonymous volumes are Stored in:

```id="34hcd9"
# In Mac/Linux
/var/lib/docker/volumes/

# In Windows
C:/ProgramData/docker/volumes
```

#### ✅ Advantages over Bind Mount

* Easier to manage
* More secure
* Better for production

---

#### **Types of Volumes**

##### **1. Named Volume**

* Volume with a specific name

###### 📦 Named Volume Example

```bash
docker volume create myvolume
```

👉 Only creates storage ❌
👉 Does NOT connect/mount it to any container
👉 Volume must be mounted to be used

```bash
docker run -d -v myvolume:/app nginx
```

##### **2. Anonymous Volume**

* Volume without name (auto-generated)

###### 📦 Anonymous Volume Example

```bash
docker run -d -v /app nginx
```

* This creates an Anonymous Volume
* Docker automatically:
  * Creates a random volume name
  * Mounts it to `/app` inside container

###### ❗ Problem

* Hard to manage (no name)

---

#### **Important Volume Commands**

##### 🔹 Create Volume

```bash
docker volume create myvolume # Create Named Volume, but not mount it
docker run -v /app <img_name> # Create and mount an Anonymous Volume
```

##### 🔹 List Volumes

```bash
docker volume ls
```

##### 🔹 Inspect Volume

```bash
docker volume inspect myvolume
```

##### 🔹 Remove Volume

```bash
docker volume rm myvolume
```

##### 🔹 Remove Unused Volumes

```bash
docker volume prune
```

---

### **3. Bind Mount vs Volume (VERY IMPORTANT)**

| Feature     | Bind Mount       | Volume           |
| ----------- | ---------------- | ---------------- |
| Managed by  | User             | Docker           |
| Location    | Anywhere on host | Docker directory |
| Flexibility | High             | Medium           |
| Security    | Less             | More             |
| Portability | Low              | High             |
| Recommended | Dev              | Production       |

#### 🧠 When to Use What?

##### ✅ Use Bind Mount

* Development
* Live code changes
* Testing

##### ✅ Use Volumes

* Databases
* Production apps
* Persistent storage

---

### 4. Real DevOps Example *Run MySQL with Volume*

```bash
docker run -d \
  -v mysql_data:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=123 \
  mysql
```

➡️ Even if container is deleted → data remains ✅

---

## 🔚 Summary

* Containers are **ephemeral**
* Data is lost without persistence

### Two Solutions

1. **Bind Mount**

   * Host-controlled
   * Good for development

2. **Docker Volume**

   * Docker-managed
   * Best for production

---

## 🧠 Key Insight (Interview)

> Volumes are preferred over bind mounts in production because they are **secure, portable, and managed by Docker**
