# Section 8: System Monitoring (CPU, Memory, Disk)

## 📊 What is System Monitoring?

* System monitoring means checking **system performance and health**
* Helps you:

  * Detect issues
  * Improve performance
  * Avoid system crashes

---

## 🧠 CPU Monitoring

### Check CPU Usage (Real-Time)

```bash id="2l69ec"
top
```

👉 Shows CPU, memory, processes (live)

#### Better View

```bash id="2lqb0p"
htop
```

👉 Interactive and easy to read

### CPU Info

```bash id="q63g5q"
lscpu  # Shows CPU details
nproc  # Shows number of processors
```

### Load Average

```bash id="llpf8j"
uptime
```

👉 Shows system load (1, 5, 15 minutes)

---

## 🧮 Memory Monitoring

### Check Memory Usage

```bash id="i9ycr5"
free -h
```

👉 Shows RAM usage (human readable)

### Detailed Memory Info

```bash id="p0qqdz"
vmstat
```

👉 Shows memory + processes

---

## 💾 Disk Monitoring

### Check Disk Usage

```bash id="apvnpd"
df -h
```

👉 Shows disk space (human readable)

### Check Folder Size

```bash id="4q9ej8"
du -sh /home/uzair
du -sh *
```

👉 Shows directory size

### Disk Partitions

```bash id="55oriy"
lsblk
```

👉 Shows disks and partitions

---

## 📈 I/O Monitoring (Advanced)

### Disk I/O

```bash id="7s9mq9"
iostat
```

👉 Shows disk read/write stats

---

## Process Resource Usage

```bash id="2abie7"
top
```

---

## 🔍 Network Monitoring (Basic)

```bash id="q1hx3b"
netstat -tulnp
```

👉 Shows open ports

---

## ⚡ Important Notes

* `top/htop` → real-time monitoring
* `free -h` → memory usage
* `df -h` → disk space
* `du -sh` → directory size

---

## 🔹 Quick Revision Summary

* Monitoring = check system health
* CPU → `top`, `htop`, `uptime`
* Memory → `free -h`, `vmstat`
* Disk → `df -h`, `du -sh`, `lsblk`
* Network → `netstat`

---
