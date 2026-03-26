# **Section 6: Multistage Docker Build**

## **1. Problem with Traditional Dockerfile**

Before learning multistage builds, let’s understand the **problem first**.

### ❌ 1. Oversized Images

👉 In traditional Dockerfile:

* We install:

  * Build tools (gcc, npm, maven, etc.)
  * Dependencies
  * Application

➡️ Everything goes into the final image

#### 📦 Example

```dockerfile
FROM node:18

WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

CMD ["npm", "start"]
```

#### 🚨 Problem

* Final Image contains:

  * Source code
  * Dev dependencies
  * Build tools

➡️ The problem is many Packages and build tools that are only needed to build the application, but not run it are also included in the Final image, So the Final image becomes **very large**

---

### ❌ 2. Slow Deployment

* Large image = more time to:

  * Build
  * Push
  * Pull

---

### ❌ 3. Increased Storage Cost

* Large images consume:

  * Disk space
  * Registry storage

---

## **2. Solution: Multistage Docker Build**

### 👉 Definition

> Solution for oversized images is to split "Dockerfile" into multiple stages using two or more **FROM** instructions, and copy only required files into final image using `COPY --from=builder`.

## **3. How Multistage Build Works**

> Multistage builds reduce image size by separating **build environment** and **runtime environment**

### 🔄 Flow

```id="61b5dl"
Stage 1 (Builder) → Build application 
         ↓
Stage 2 (Final) → Copy only required files → Run application
```

---

## **4. Multistage Dockerfile Example**

### 🧾 Example: Node.js App

```dockerfile
# -------- Stage 1: Build --------
FROM node:18 AS builder

WORKDIR /app
COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build


# -------- Stage 2: Production --------
FROM node:18-alpine

WORKDIR /app

# Copy only built files from builder
COPY --from=builder /app /app

EXPOSE 3000

CMD ["npm", "start"]
```

---

### 🧠 Explanation

#### 🔹 `AS builder`

* Naming the first stage

#### 🔹 `COPY --from=builder`

* Copy files from stage 1 → stage 2

#### 🎯 Result

* Final image does NOT contain:

  * Build tools
  * Unnecessary files

➡️ Only production-ready code ✅

---

## **5. Benefits of Multistage Builds**

### ✅ 1. Smaller Image Size

* Removes unnecessary files

### ✅ 2. Faster Deployment

* Small images = faster pull & push

### ✅ 3. Better Security

* No dev tools in production

### ✅ 4. Clean Production Image

* Only required files included

---

## **6. Pro-Level Optimization Tips**

### ✅ Use Alpine Images

```dockerfile
FROM node:18-alpine
```

👉 Very small image size

### ✅ Copy Only Required Files

Instead of:

```dockerfile
COPY . .
```

Use:

```dockerfile
COPY package.json .
```

### ✅ Use .dockerignore

👉 Prevent copying:

* node_modules
* logs
* .git

---

## **7. Ultimate Solution: Distroless Images (Advanced)**

### 👉 What are Distroless Images?

> Images that contain **only application and runtime**, no OS tools

### ❌ What they DON'T include

* Shell (bash)
* Package manager
* Debug tools

### ✅ What they include

* Only:

  * Application
  * Required runtime

### 🧠 Example

* Instead of:

```dockerfile
FROM node:18
```

Use:

```dockerfile
FROM gcr.io/distroless/nodejs
```

### 🎯 Benefits

#### ✅ 1. Ultra Small Images

* Much smaller than Alpine

#### ✅ 2. More Secure

* No shell → harder to attack
* As the final image does not include tools like shell, so even if the container got compromised the attacker couldn't do anything.

#### ✅ 3. Production Ready

* Ideal for real-world deployments

---

### ⚠️ Limitation

* Hard to debug (no shell)

---

### 🧠 When to Use Distroless?

| Use Case         | Recommendation |
| ---------------- | -------------- |
| Development      | ❌ No          |
| Production       | ✅ Yes         |
| Debugging needed | ❌ No          |

---

## 🔚 Summary

* Traditional Dockerfile → large & inefficient
* Multistage build → optimized & clean
* Distroless → ultra-secure & minimal

---
