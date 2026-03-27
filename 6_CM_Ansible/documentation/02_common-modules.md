# 🔹 Most Commonly Used Ansible Modules (With Important Arguments)

These are the modules you will use **90% of the time** in real DevOps work.

I’ll keep it:

* Simple
* Practical
* Interview-ready

---

## 1️⃣ Package Management Modules

### 🔹 `apt` (Debian/Ubuntu)

Used for installing packages on Debian-based systems.

```yaml
- name: Install nginx
  apt:
    name: nginx
    state: present
```

#### `apt` module Common Arguments

| Argument         | Meaning                   |
| ---------------- | ------------------------- |
| name             | Package name              |
| state            | present / absent / latest |
| update_cache     | yes/no                    |
| cache_valid_time | Seconds                   |

Example:

```yaml
apt:
  name: nginx
  state: latest
  update_cache: yes
```

### 🔹 `yum` / `dnf` (RedHat/CentOS)

```yaml
yum:
  name: httpd
  state: present
```

Common arguments same as apt:

* name
* state
* update_cache

---

## 2️⃣ Service Management

### 🔹 `service`

```yaml
service:
  name: nginx
  state: started
```

#### `service` module Common Arguments

| Argument | Meaning                       |
| -------- | ----------------------------- |
| name     | Service name                  |
| state    | started / stopped / restarted |
| enabled  | yes/no                        |

Example:

```yaml
service:
  name: nginx
  state: started
  enabled: yes
```

### 🔹 `systemd` (Modern Linux)

```yaml
systemd:
  name: nginx
  state: restarted
  enabled: yes
```

Used in systemd-based systems.

---

## 3️⃣ File Management

### 🔹 `copy` Module

Copy static file

```yaml
  copy:
    src: dist/
    dest: /var/www/portfolio/
```

👉 **Common arguments**

* src
* dest
* owner
* group
* mode
* backup

👉 **Problems**

* Slow for large folders, Always copies everything (even unchanged files)

👉 **Best Use Cases**

* Small config files
* Single file copy
* Templates

### 🔹 `synchronize` Module

```yaml
- name: Sync dist folder
  synchronize:
    src: dist/
    dest: /var/www/portfolio/
```

👉 **Advantages**

✔ Only copies **changed files**
✔ Very fast
✔ Perfect for large folders
✔ Production-grade

👉 **Requirements**

* `rsync` must be installed:

  * On control node (your machine / Jenkins)
  * On target server

👉 **Important Difference (Direction)**

* `mode` in `copy` ≠ `mode` in `synchronize`
* `copy` module → `mode` = `file permissions`
* `synchronize` module → `mode` = `transfer direction`
* `synchronize` runs from **control node → remote** by defaule

```yaml
mode: push # Default: Push files FROM control node TO remote server
mode: pull # Pull files FROM remote TO control node
```

👉 **Delete extra files uding `delete` argument**

```yaml
delete: yes
```

✔ Make remote EXACTLY same as local folder

---

### 🔹 `template`

For dynamic files.

```yaml
template:
  src: nginx.conf.j2
  dest: /etc/nginx/nginx.conf
```

Arguments:

* src
* dest
* owner
* group
* mode
* validate

### 🔹 `file`

Manage file properties.

```yaml
file:
  path: /tmp/test
  state: directory
```

States:

* file
* directory
* absent
* touch
* link

Arguments:

* path
* state
* mode
* owner
* group

---

## 4️⃣ User & Group Management

### 🔹 `user`

```yaml
user:
  name: john
  state: present
```

Common arguments:

| Argument | Purpose          |
| -------- | ---------------- |
| name     | Username         |
| state    | present / absent |
| groups   | Assign groups    |
| append   | yes/no           |
| shell    | Login shell      |
| password | Hashed password  |
| remove   | Delete home dir  |

### 🔹 `group`

```yaml
group:
  name: developers
  state: present
```

Arguments:

* name
* state
* gid

---

## 5️⃣ Command Execution

### 🔹 `command`

Runs command (no shell features).

```yaml
command: ls -l
```

Arguments:

* cmd
* chdir
* creates
* removes

### 🔹 `shell`

Runs command with shell features.

```yaml
shell: "echo $HOME"
```

Difference:

* command → safer
* shell → supports pipes, redirects

### 🔹 `script`

Runs local script on remote host.

```yaml
script: install.sh
```

---

## 6️⃣ Debugging & Control

### 🔹 `debug`

```yaml
debug:
  var: ansible_hostname
```

Arguments:

* msg
* var

### 🔹 `set_fact`

Create runtime variable.

```yaml
set_fact:
  env: production
```

---

## 7️⃣ Git & Repository

### 🔹 `git`

```yaml
git:
  repo: https://github.com/user/app.git
  dest: /var/www/app
  version: main
```

Arguments:

* repo
* dest
* version
* force
* update

---

## 8️⃣ Archive & Download

### 🔹 `get_url`

Download file.

```yaml
get_url:
  url: https://example.com/app.tar.gz
  dest: /tmp/app.tar.gz
```

Arguments:

* url
* dest
* mode
* checksum

### 🔹 `unarchive`

Extract archive.

```yaml
unarchive:
  src: /tmp/app.tar.gz
  dest: /opt/
  remote_src: yes
```

Arguments:

* src
* dest
* remote_src

---

## 9️⃣ Firewall & Network

### 🔹 `ufw`

```yaml
ufw:
  rule: allow
  port: 80
```

### 🔹 `firewalld`

```yaml
firewalld:
  port: 80/tcp
  permanent: yes
  state: enabled
```

---

## 🔟 Reboot & Wait

### 🔹 `reboot`

```yaml
reboot:
  reboot_timeout: 300
```

### 🔹 `wait_for`

Wait for port/service.

```yaml
wait_for:
  port: 80
  delay: 10
```

Arguments:

* port
* host
* timeout
* delay

---

## 1️⃣1️⃣ Facts & Information

### 🔹 `setup`

Collect system facts.

```yaml
setup:
```

---

## 🔥 Most Important Modules for Interviews ⭐

Top 10 to remember:

* apt / yum
* service / systemd
* copy
* template
* file
* user
* group
* command
* shell
* debug
* set_fact
* git
* get_url

---

## 🔥 Interview Questions

### Q1: Difference between command and shell?

* command → No shell processing
* shell → Supports pipes, redirection

### Q2: Difference between copy and template?

* copy → Static file
* template → Dynamic Jinja2 file

### Q3: Difference between service and systemd?

* service → Generic
* systemd → More control in modern Linux

### Q4: Which module is idempotent?

Most built-in modules are idempotent (user, apt, service, file, etc.)

---

## 🚀 Quick Revision Summary

| Category     | Important Modules    |
| ------------ | -------------------- |
| Package      | apt, yum, dnf        |
| Service      | service, systemd     |
| File         | copy, template, file |
| User         | user, group          |
| Command      | command, shell       |
| Git          | git                  |
| Download     | get_url              |
| Archive      | unarchive            |
| Debug        | debug                |
| Runtime Vars | set_fact             |
