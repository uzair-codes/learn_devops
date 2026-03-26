# Section 10: Networking in Linux

## 🌐 What is Networking?

* Networking allows systems to **communicate with each other**
* Used for:

  * Internet access
  * Server communication
  * API calls

---

## 🧱 Basic Networking Concepts

### 🔹 IP Address

* Unique address of a system
* Example:

  ```bash
  192.168.1.10
  ```

### 🔹 Public vs Private IP

* **Public IP** → Accessible from internet
* **Private IP** → Used inside local network

### 🔹 Port

* Logical number used by services

**Examples:**

* 80 → HTTP
* 443 → HTTPS
* 22 → SSH

### 🔹 DNS (Domain Name System)

* Converts domain → IP

👉 Example:

* google.com → 142.x.x.x

---

## 🧰 Important Networking Commands

### 🔹 IP

Modren utility in Linux for network management

`ip [Object] [Command] [Option]`
**Object:** link, addr, route
**Command:** show, add, del

```bash id="r9k1vh"
ip addr show or ip a # Shows IP and network interfaces
ip link show or ip l # Show Interface details
ip addr add/del 192.168.1.100/24 dev eth0
ip link set eth up/down
ip route show
ip route add 192.168.1.100 via 192.168.1.0
ip neigh show 
```

### 🔹 Check Connectivity (ping)

```bash id="v6z25k"
ping -c 4 google.com
```

👉 Tests network connection

### 🔹 Check Open Ports (netstat)

```bash id="7m3j8s"
netstat -tulnp
```

👉 Shows:

* Listening ports
* Running services

#### 🔹 `netstat` Alternative (Modern)

```bash id="b0e1l5"
ss -tulnp
```

👉 Faster than netstat

---

### 🔹 DNS Lookup

```bash id="z3r9zq"
nslookup google.com
```

### 🔹 Download File

```bash id="l5gxsl"
curl http://example.com
```

---

## 🔥 Firewall in Linux

Firewall controls **incoming and outgoing traffic**

### 🛡️ UFW (Ubuntu Firewall)

#### Enable Firewall

```bash id="9ciz4a"
sudo ufw enable
```

#### Check Status

```bash id="dcxw42"
sudo ufw status
```

#### Allow Port

```bash id="f8whg2"
sudo ufw allow 80
```

#### Deny Port

```bash id="g3qu06"
sudo ufw deny 22
```

#### Disable Firewall

```bash id="jv2b1y"
sudo ufw disable
```

---

### 🛡️ firewalld

Used in:

* CentOS
* RHEL

#### Start firewalld

```bash id="0pn4aq"
sudo systemctl start firewalld
```

#### Enable at Boot

```bash id="u8q2jv"
sudo systemctl enable firewalld
```

#### firewall-cmd Commands

```bash id="2l0qz1"
sudo firewall-cmd --state # Check Status
sudo firewall-cmd --list-all # List all rules
sudo firewall-cmd --add-port=80/tcp --permanent # Allow Port
sudo firewall-cmd --remove-port=80/tcp --permanent # Remove Port
sudo firewall-cmd --reload # Reload Firewall
```

---

## ⚡ Important Notes

* `ip a` → check IP
* `ping` → test connectivity
* `ss` → check ports (modern)
* UFW → Ubuntu firewall
* firewalld → RHEL/CentOS firewall

---

## 🔹 Quick Revision Summary

* IP address identifies system
* Ports identify services
* `ip a`, `ping`, `ss` → basic networking commands
* UFW used in Ubuntu
* firewalld used in RHEL/CentOS
* Firewall controls traffic
