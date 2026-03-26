# **Section 5: Dockerfile, Docker Registry and Important Dockerfile Instructions**

## **1. What is a Dockerfile?**

### 👉 Definition

> A Dockerfile is a **text file** that contains instructions to **build a Docker image**
> The Dockerfile uses **DSL (Domain Specific Language)**

### 📦 Example

```dockerfile
FROM nginx
COPY . /usr/share/nginx/html
```

👉 This means:

* Use nginx as base
* Copy website files into it

---

## **2. Important Dockerfile Instructions (VERY IMPORTANT)**

### **1. FROM (Base Image)**

* Defines the **base image**

```dockerfile
FROM ubuntu
```

#### 🧠 Note

* Every Dockerfile must start with `FROM`

---

### **2. WORKDIR**

* Sets working directory inside container

```dockerfile
WORKDIR /app
```

👉 Now all commands run inside `/app`

---

### **3. COPY**

* Copies files from local machine → container

```dockerfile
COPY /local_path /container_path
COPY . /app
```

👉 Copy everything to current working directory "app"

---

### **4. ADD**

### 👉 Similar to COPY but

* Can extract zip files
* Can download from URL

```dockerfile
ADD app.tar.gz /app
```

#### 🧠 Best Practice

> Prefer `COPY` unless you need extra features

---

### **5. RUN**

* Executes commands during image build

```dockerfile
RUN apt update && apt install -y nginx
```

👉 Used for:

* Installing packages
* Setting up environment

---

### **6. CMD**

* Defines Default command when container starts

#### ✅ Example

```dockerfile
CMD ["nginx", "-g", "daemon off;"]
```

#### 🧠 Important

* Only **one CMD** allowed (last one is used)
* Can be overwritten

---

### **7. ENTRYPOINT**

* Similar to CMD but more strict

```dockerfile
ENTRYPOINT ["nginx"]
```

#### 🧠 Difference

| CMD               | ENTRYPOINT       |
| ----------------- | ---------------- |
| Can be overridden | Hard to override |
| Default command   | Fixed command    |

---

### **8. EXPOSE**

* Documents which port container uses

```dockerfile
EXPOSE 80
```

👉 Does NOT actually publish port (just info)

---

### **9. ENV**

* Set environment variables

```dockerfile
ENV APP_ENV=production
```

---

### **10. ARG**

* Build-time variables

```dockerfile
ARG VERSION=1.0
```

---

### **11. LABEL**

* Add metadata

```dockerfile
LABEL maintainer="uzair@example.com"
```

---

### **12. USER**

* Specify user inside container, which user container should run as.

```dockerfile
USER nginx
```

---

## **3. Complete Dockerfile Example (VERY IMPORTANT)**

### 🧾 Example: Node.js App

```dockerfile
# Base image
FROM node:18

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy app code
COPY . .

# Expose port
EXPOSE 3000

# Run app
CMD ["npm", "start"]
```

### 🔄 Build & Run

```bash
docker build -t mynodeapp .
docker run -d -p 3000:3000 mynodeapp
```

---

### 🧠 Best Practices (IMPORTANT)

#### ✅ 1. Use Small Base Images

* Example:

  * `alpine` version

#### ✅ 2. Minimize Layers

* Combine RUN commands

#### ✅ 3. Use .dockerignore

* Avoid unnecessary files

#### ✅ 4. Use COPY instead of ADD

#### ✅ 5. Avoid Running as Root

---

## **4. What is Docker Registry?**

> A Docker Registry is a place where Docker images are **stored and shared**

### 🌐 Types of Registry

#### 🔹 1. Public Registry

* Anyone can access

👉 Example:

* Docker Hub (most popular)

#### 🔹 2. Private Registry

* Only authorized users

👉 Used in companies for security

#### 🔄 Workflow

```id="e3z5ru"
Build Image → Push to Registry → Pull → Run Container
```

### ✅ Commands

```bash
docker login
docker push myapp
docker pull myapp
```

---

## 🔚 Summary

* Dockerfile is used to **build images**
* Registry is used to **store and share images**
* Important instructions:

  * FROM, RUN, COPY, CMD, ENTRYPOINT, EXPOSE
