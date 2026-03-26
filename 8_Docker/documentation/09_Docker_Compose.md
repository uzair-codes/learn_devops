# **Section 9: Docker Compose**

## **1. What is Docker Compose?**

### 👉 Definition

> Docker Compose is a tool used to **define and run multi-container Docker applications** using a single YAML file.

### 🧠 In Simple Words

* Instead of running long multiple `docker build and docker run` commands
  ➡️ You define everything in **one file (`docker-compose.yml`)**

### 🎯 Problem it Solves

Without Docker Compose:

```bash
docker network create app-network

docker run -d --name db --network app-network mongo

docker run -d --name backend --network app-network -p 3000:3000 node
```

👉 Too many commands 😓

### ✅ With Docker Compose

```yaml
version: '3'
services:
  db:
    image: mongo

  backend:
    image: node
    ports:
      - "3000:3000"
```

➡️ Run everything with **one command** ✅
➡️ Create once and reuse

---

## **2. Docker Compose File Structure**

### 📄 File Name

```id="g6gmpx"
docker-compose.yml
```

### 🧩 Basic Structure

```yaml
version: '3'

services:
  service1_name:
    image: image_name
    ports:
      - "host:container"
  
  service2_name:
    image: image_name
    ports:
      - "host:container"
```

---

## **3. Key Components of Docker Compose**

### **1. version**

> Defines Compose file version

```yaml
version: '3'
```

### **2. services (MOST IMPORTANT)**

> 👉 Defines containers

```yaml
services:
  web:
    image: nginx
```

### **3. image**

> 👉 Pre-built image

```yaml
image: nginx
```

### **4. build**

> 👉 Build image from Dockerfile

```yaml
build: .
```

### **5. ports**

> 👉 Port mapping

```yaml
ports:
  - "8080:80"
```

### **6. volumes**

> 👉 Persistent storage

```yaml
volumes:
  - myvolume:/app
```

* Also define volumes block at top level outside services block

```yaml
volumes:
  myvolume:
```

### **7. environment**

> 👉 Environment variables

```yaml
environment:
  - MYSQL_ROOT_PASSWORD=123
```

### **8. depends_on**

> 👉 Control startup order

```yaml
depends_on:
  - db
```

### **9. networks**

> 👉 Custom network

```yaml
networks:
  - mynetwork
```

* Also define network block at top level outside services block

```yaml
networks:
  mynetwork:
```

---

## **4. Complete Real-World Example (VERY IMPORTANT)**

### 📦 Node.js + MongoDB App

```yaml
version: '3'

services:
  backend:
    build: .
    ports:
      - "3000:3000"
    depends_on:
      - db
    networks:
      - app-network

  db:
    image: mongo
    volumes:
      - mongo-data:/data/db
    networks:
      - app-network

volumes:
  mongo-data:

networks:
  app-network:
```

### 🧠 Explanation

#### 🔹 backend

* Builds from Dockerfile
* Runs app on port 3000

#### 🔹 db

* Uses MongoDB image
* Stores data in volume

#### 🔹 volume

* `mongo-data` → persists database

#### 🔹 network

* Both services communicate via `app-network`

---

## **5. Docker Compose Commands (VERY IMPORTANT)**

### 🔹 Start Services

```bash id="3tji9a"
docker-compose up
docker-compose -f docker-compose.yml up
```

### 🔹 Run in Background

```bash id="5f45oq"
docker-compose up -d
```

### 🔹 Stop Services

```bash id="os6v1c"
docker-compose down
docker-compose -f docker-compose.yml down
```

### 🔹 Rebuild Containers

```bash id="hshui0"
docker-compose up --build
```

### 🔹 View Running Services

```bash id="q69aq2"
docker-compose ps
```

### 🔹 View Logs

```bash id="b04wmr"
docker-compose logs
```

---

## **6. Advantages of Docker Compose**

### ✅ 1. Simplicity

* One file to manage everything

### ✅ 2. Multi-Container Management

* Run full application stack easily

### ✅ 3. Automatic network creation

* docker-compose automatically created a network and add all services to it

### ✅ 4. Faster Development

* Ideal for local development

---

## 🔥 Key Insight (Interview Level)

> Docker Compose is used to manage **multi-container applications**, while Docker CLI is used for **single container operations**
