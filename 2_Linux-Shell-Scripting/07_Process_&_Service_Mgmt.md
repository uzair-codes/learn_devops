# Section 7: Process & Service Management

## ⚙️ What is a Process?

* A **process** is a running program in Linux
* Example:

  * nginx running
  * a script running

👉 Each process has a unique **PID (Process ID)**

---

## 🔍 View Running Processes

### List Processes

```bash id="c29l9k"
ps # Shows current shell processes
ps -ef # Shows all running processes
ps aux # Shows all running processes

ps -eo pid,ppid,%cpu,%mem --sort=-%cpu  # View in user defined format
```

---

### Count Processes

```bash

ps aux | wc -l 
ps aux | nl -V0

```

### 🔎 Find Specific Process

```bash id="8kq2bh"
ps aux | grep nginx # Search for nginx process
```

### View Processes for a specific user

```bash
ps -u username
ps aux | grep username | awk -F" " '{print $2}' # print PID
```

---

## ❌ Kill Process

```bash id="l6d35l"
kill PID           # Kill by PID, Gracefully stops process
pkill processname  # Kill by processname
kill -9 PID        # Force Kill, Immediately stops process (force)
kill -3 PID        # Kill Process and generate a core dump (Memory snap of the process at the time it received signal - used for debugging)
kill -STOP PID     # Stop a running process
kill -CONT PID     # Continue a Stopped process
```

---

## Prioritise and de-prioritise a process

Adjusting how much CPU time a process gets

```bash
renice -n -10 -p PID
```

* `-n` specifies niceness value, it ranges form `-20=highest priority` to `19=lowest priority`
* only root user can increase priority

```bash
nice -n -10 <command> # Run <command> with specific priority 
```

## ⚡ Process States (Basic)

* Running
* Sleeping
* Stopped
* Zombie

---

## 🔄 What is a Service?

* Any process running in background is called a daemon process
* A **service** is a systemd managed deamon (background process)
* Runs continuously (daemon) in background
* Automatically starts on boot

### Examples

* nginx
* ssh
* docker

### 🧰 Service Management (systemd)

* **systemd** Modern Linux service manager
* **systemctl** command-line tool for managing services

### Importand

```bash id="9okqtr"
sudo systemctl start nginx     # Start nginx Service
sudo systemctl stop nginx      # Stop nginx Service
sudo systemctl restart nginx   # Restart nginx Service
sudo systemctl status nginx    # Check service Status
sudo systemctl enable nginx    # Enable Service (start at boot)
sudo systemctl disable nginx
```

### 📜 View Logs (Important)

```bash id="3pmr8c"
journalctl -u nginx # Shows logs for service
```

---

## ⚡ Important Notes

* `command &`       → Run a command in background
* `jobs`            → List jobs "**Job is a task systemd performs, like start/stop service**"
* `ctrl+z`          → Suspend a running forground process
* `ctrl+c`          → Terminate a running forground process
* `bg % jobnumber`  → Resume a suspended job in bg
* `fg % jobnumber`  → Bring a job to forground

---

## 🔹 Quick Revision Summary

* Process = running program
* PID = unique process ID
* `ps`, `top`, `htop` → view processes
* `kill`, `pkill` → stop processes
* Service = background process
* `systemctl` → manage services

---
