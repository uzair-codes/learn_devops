# Section 4: User & Group Management (Very Important)

## 👤 What are Users and Groups?

* **User** =a person or service that can log into the system
* **Group** = collection of users

👉 Used to **control access and permissions**

---

## 🔐 Types of Users

* **Root User**

  * Full access (admin)
  * ID = 0

* **Normal User**

  * Limited access
  * Used for daily work

* **System User**

  * Used by services (nginx, mysql)

---

## 📁 Important Files

### 🔹 `/etc/passwd`

* Stores user information
* Example:

```bash
uzair:x:1001:1001:/home/uzair:/bin/bash
```

👉 Fields:

* Username
* Password (x means stored in shadow file)
* UID
* GID
* Home directory
* Shell

### 🔹 `/etc/shadow`

* Stores **encrypted passwords**
* Only root can access

### 🔹 `/etc/group`

* Stores group information

### 🔹 `/etc/gshadow`

* Secure group info (passwords)

---

## User Management

### ➕ Create User

```bash
sudo useradd username               # Create user (without home directory), better for automation
sudo useradd -m username            # Create user (with home directory)
sudo useradd -s /bin/bash username  # Specify Shell
sudo adduser username               # Create user (with home directory)
```

---

### ❌ Delete User

```bash
sudo userdel username # Delete user only
sudo userdel -r username # Delete user + home directory
```

---

### 🔧 Modify User

```bash
sudo usermod -d /new/home username # Change home directory
sudo usermod -s /bin/bash username  # Change shell
sudo usermod -L username # Lock user
sudo passwd -l username # Lock user
sudo usermod -U username # Unlock user
sudo passwd -u username # Unlock user
```

---

### 🔑 Password Management

```bash
sudo passwd username               # Change Password
sudo usermod -p PASSWORD username  # Change Password
sudo passwd -S username            # Show password status
suod chage -M 90 username          # Change password expiry
sudo passwd -e username            # Force password change on next login
```

---

## 👥 Group Management

### Create & Delete Group

```bash
sudo groupadd groupname # Create group
sudo groupdel groupname # Delete group
```

---

### Add user to group

```bash
sudo gpasswd -a username groupname
sudo gpasswd -M user1,user2,.. groupname
sudo usermod -aG groupname username
```

* Always use **(`-aG`= append to group)** when adding user to group
  ❌ Without `-a` → removes user from other groups

---

### Remove user from group

```bash
sudo gpasswd -d username groupname
sudo usermod -rG groupname username
```

---

### Change primary group

```bash
sudo usermod -g newgroupname username
```

---

## 🔍 Useful Commands

```bash
groups             # view groups membership
whoami             # Check current user
id username        # Check user ID and groups
who                # List logged-in users
sudo su - username # Switch user
```

---

## 🔹 Quick Revision Summary

* Users = accounts, Groups = collection of users
* Important files: `/etc/passwd`, `/etc/shadow`, `/etc/group`
* `useradd`, `userdel`, `usermod` → user management
* `groupadd`, `groupdel` → group management
* `usermod -aG` → add user to group
* Passwords stored in `/etc/shadow`

---

## 🔹 Interview Key Points

* Difference between **/etc/passwd and /etc/shadow**
* Meaning of `-aG` flag in `usermod`
* Difference between **primary group vs secondary group**
* Root user has UID = 0
* How to create user with home directory (`-m`)
* How to delete user with home directory (`-r`)
