# Section 3: Linux File System

## 📁 What is Linux File System?

* Linux file system is the way Linux **stores and organizes files and directories**
* Everything in Linux is treated as a **file**

  * Files
  * Directories
  * Devices (disk, USB)

---

## 🌳 File System Structure (Hierarchy)

Linux uses a **tree-like structure**

```bash
/
├── home
├── etc
├── var
├── bin
├── usr
```

👉 `/` is called the **root directory** (top level)

---

## 📂 Important Directories

### 🔹 `/`

* Root directory
* Starting point of the file system

### 🔹 `/home`

* User home directories
* Example:

  ```bash
  /home/uzair
  ```

### 🔹 `/etc`

* System configuration files
* Example:

  * passwd
  * network configs

### 🔹 `/var`

* Variable data (changes frequently)
* Logs, cache, spool

### 🔹 `/bin`

* Basic user commands
* Example:

  * ls
  * cp
  * mv

### 🔹 `/usr`

* User programs and libraries
* Contains most installed software

### 🔹 `/opt`

* Optional software (third-party apps)

### 🔹 `/tmp`

* Temporary files
* Automatically deleted after reboot

### 🔹 `/dev`

* Device files (hardware representation)
* Example:

  * disk
  * USB

### 🔹 `/mnt` and `/media`

* Used to mount external devices
* USB, drives

---

## 📌 Key Concepts

### 1. Everything is a File

* Devices, processes, configs → all are files

### 2. Absolute Path

* Full path from root `/`

```bash id="yud0so"
/home/uzair/file.txt
```

### 3. Relative Path

* Path from current directory

```bash id="xg5pgh"
./file.txt
../file.txt
```

### 4. Hidden Files

* Start with `.`

```bash id="srehtj"
.bashrc
```

👉 Use:

```bash id="v84fui"
ls -a
```

to view hidden files

---

## 🧰 Important File System Commands

### List Files

```bash id="jn8jj0"
ls
```

👉 Shows files in current directory

### Detailed List

```bash id="r3z3k4"
ls -l
```

👉 Shows permissions, owner, size

### Show Hidden Files

```bash id="51l0gl"
ls -a
```

### Change Directory

```bash id="od6zrt"
cd /home
cd ~
cd ../../
```

### Current Directory

```bash id="b9z7a8"
pwd
```

### Create Directory

```bash id="c0y5bx"
mkdir test
```

### Remove Directory

```bash id="ljj8q8"
rmdir test
rm -rf test
```

### Create Empty File

```bash id="ogd1nl"
touch file.txt
```

### View File Content

```bash id="f8zq0b"
cat file.txt
```

---

## 🔹 Quick Revision Summary

* Linux file system is a **hierarchical structure**
* `/` is the root directory
* Important dirs: `/home`, `/etc`, `/var`, `/usr`
* Absolute path starts from `/`
* Relative path starts from current directory
* Hidden files start with `.`

---

## 🔹 Interview Key Points

* Everything in Linux is treated as a **file**
* `/etc` stores configuration files
* `/var` stores logs and dynamic data
* `/home` stores user data
* Difference between **absolute vs relative path** is commonly asked
