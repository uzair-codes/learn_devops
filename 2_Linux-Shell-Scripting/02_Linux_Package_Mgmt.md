# Section 2: Linux Package Management (Ubuntu)

## 📦 What is Package Management?

* Package management is used to **install, update, and remove software** in Linux
* Software is distributed in the form of **packages (.deb in Ubuntu)**

---

## 🧰 Package Manager in Ubuntu

Ubuntu uses:

* **APT (Advanced Package Tool)** → High-level tool (most used)
* **dpkg** → Low-level tool (works with .deb files directly)

### ⚙️ APT (Most Important Tool)

APT is used to:

* Install software
* Update system
* Remove packages
* **Automatically resolve dependencies**

#### 🔹 Important APT Commands

#### 1️⃣ List all Packages

```bash
sudo apt list

sudo apt list --installed   # List Installed Packages only
```

#### 2️⃣ Update Package List

```bash
sudo apt update
```

👉 Updates list of available packages (does NOT install anything)

#### 3️⃣ Upgrade Packages

```bash
sudo apt upgrade
```

👉 Installs latest versions of installed packages

#### 4️⃣ Install a Package

```bash
sudo apt install nginx
```

👉 Installs nginx web server

#### 5️⃣ Remove a Package

```bash
sudo apt remove nginx
```

👉 Removes package (keeps config files)

#### 6️⃣ Remove Completely

```bash
sudo apt purge nginx
```

👉 Removes package + configuration files

#### 7️⃣ Search for Package

```bash
apt search nginx

dpkg -l | gerp nginx
```

👉 Finds package in repository

#### 8️⃣ Show Package Info

```bash
apt show nginx
```

👉 Displays details about package

#### 9️⃣ Clean Unused Packages

```bash
sudo apt autoremove
```

👉 Removes unused dependencies

---

### 📦 dpkg (Low-Level Tool)

* Works with **.deb files directly**
* Does NOT handle dependencies automatically

#### 🔹 Important dpkg Commands

#### 1️⃣ Install .deb File

```bash
sudo dpkg -i package_name.deb
```

#### 2️⃣ Remove Package

```bash
sudo dpkg -r package_name
```

#### 3️⃣ List Installed Packages

```bash
dpkg -l
```

---

## 🌐 Package Repositories

* Repositories are **online servers** that store packages

### Types in Ubuntu

* Main → Official supported software
* Universe → Community packages
* Multiverse → Restricted software

### Repository File

```bash
/etc/apt/sources.list
```

👉 Contains repository URLs

---

## ⚡ Important Notes

* Always run:

```bash
sudo apt update
```

before installing packages

* Use APT instead of dpkg for dependency handling

---

## 🔹 Quick Revision Summary

* Package management = install, update, remove software
* Ubuntu uses **APT (main)** and **dpkg (low-level)**
* `apt update` updates package list
* `apt install` installs software
* `apt remove/purge` removes software
* Repositories store packages

---

## 🔹 Interview Key Points

* APT is preferred because it **handles dependencies automatically**
* dpkg is used for **manual .deb installation**
* `apt update` ≠ `apt upgrade` (very common question)
* Repositories are defined in `/etc/apt/sources.list`
* `apt autoremove` helps clean unused packages

---
