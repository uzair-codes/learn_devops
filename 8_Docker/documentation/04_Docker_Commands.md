# **Section 4: Most Commonly Used Docker Commands**

We’ll cover commands in a **logical flow**, just like you use Docker in real life.

---

## 🧠 **Basic Command Format**

```bash
docker <command> <options>
```

---

## **1. Docker Version & Info**

### 🔹 Check Docker Version

```bash
docker --version
```

### 🔹 Detailed System Info

```bash
docker info
```

👉 Shows:

* Containers count
* Images count
* Storage driver
* OS details

---

## **2. Working with Images**

### 🔹 List Images

```bash
docker images
```

👉 Shows:

* Repository
* Tag
* Image ID
* Size

### 🔹 Build Image from Dockerfile

```bash
docker build /DockerfilePath
docker build -t myapp /DockerfilePath
```

👉 `-t` = tag (name of image)

### 🔹 Rename Image

```bash
docker tag old_img_name new_img_name
```

### 🔹 Remove Image

```bash
docker rmi <image_id>
```

---

## **3. Working with Containers**

### 🔹 List Running Containers

```bash
docker ps
```

### 🔹 List All Containers (Including Stopped)

```bash
docker ps -a
```

### 🔹 Run a Container

```bash
docker run <img_name>
```

👉 Starts container from image

### 🔹 Run Container in interactive mode

```bash
docker run -it <img_name>
```

### 🔹 Run Container in Background (Detached Mode)

```bash
docker run -d <img_name>
```

👉 `-d` = detached mode

### 🔹 Run with Port Mapping

When ever a container is created it has a virtual filesystem and a port binded to it by default. We can map or bind a host port to a container port using `-p` or `--publish` option, so the traffic on host port is forwarded to container port.

```bash
docker run -p host_port:container_port <img_name>
docker run --publish host_port:container_port <img_name>
docker run -p 8080:80 nginx
```

### 🔹 Run with Custom Name

```bash
docker run --name mynginx nginx
```

### 🔹 Run With Environment Variables

```bash
docker run -e NAME=value
```

### 🔹 Stop Container

```bash
docker stop <container_id>
```

### 🔹 Start Container

```bash
docker start <container_id>
```

### 🔹 Restart Container

```bash
docker restart <container_id>
```

### 🔹 Remove Container

```bash
docker rm <container_id>
```

### 🔹 Example

```bash
docker run -d -it \
> -p 8080:3306 \
> --name my_sql_server \
> -e MYSQL_ROOT_PASSWORD=mysecret  mysql
```

---

## **4. Inspecting Containers**

### 🔹 View Logs

```bash
docker logs <container_id>
```

### 🔹 Real-Time Logs

```bash
docker logs -f <container_id>
```

### 🔹 Execute Command Inside Container

```bash
docker exec -it <container_id> bash
```

👉 `-it` = interactive terminal

### 🔹 Inspect Container Details

```bash
docker inspect <container_id>
```

👉 Shows full JSON details

---

## **5. Docker System Cleanup**

### 🔹 Remove All Stopped Containers

```bash
docker container prune
```

### 🔹 Remove Unused Images

```bash
docker image prune
```

### 🔹 Remove Everything (⚠️ Careful)

```bash
docker system prune
```

👉 Removes:

* Stopped containers
* Unused images
* Networks

---

## **6. Working with Docker Hub (Registry)**

### 🔹 Login to Docker Hub

```bash
docker login  
docker login -u username # Login using username and password
```

### 🔹 Push Image

```bash
docker push myapp
```

### 🔹 Pull Image

```bash
docker pull myapp
```

👉 Downloads image from Docker Hub

---

## **7. Useful Shortcuts & Tricks**

### 🔹 Run + Remove Automatically

```bash
docker run --rm nginx
```

👉 Container deletes after stopping

### 🔹 Run Interactive Container

```bash
docker run -it ubuntu bash
```

### 🔹 Show Only Container IDs

```bash
docker ps -q
```

### 🔹 Stop All Running Containers

```bash
docker stop $(docker ps -q)
```
