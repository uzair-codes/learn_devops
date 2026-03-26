# Section 6: Permissions & Ownership Management

## 🔐 What are Permissions in Linux?

Permissions control **who can access a file or directory** and **what actions they can perform**.

### 👥 Permission Types (Users)

Each file has 3 types of users:

* **Owner (u)** → User who owns the file
* **Group (g)** → Group associated with file
* **Others (o)** → Everyone else

### ⚙️ Permission Types (Actions)

* **Read (r)** → View file content
* **Write (w)** → Modify file
* **Execute (x)** → Run file (script/program)

---

### 📊 Permission Representation

Example:

```bash id="8ozfpk"
-rwxr-xr--
```

👉 Breakdown:

* `-` → File type
* `rwx` → Owner permissions
* `r-x` → Group permissions
* `r--` → Others permissions

---

### 🔢 Numeric (Octal) Permissions

| Permission | Value |
| ---------- | ----- |
| r          | 4     |
| w          | 2     |
| x          | 1     |

#### Example

```bash id="glr5d8"
chmod 755 file.sh
```

👉 Meaning:

* Owner → 7 (rwx)
* Group → 5 (r-x)
* Others → 5 (r-x)

---

## 🧰 Important Commands

### 🔹 Change Permissions

#### Numeric Method

```bash id="9r2izg"
chmod 755 file.sh
```

---

#### Symbolic Method

```bash id="0x5m9q"
chmod u+x file.sh             # Add execute permission to user
chmod u=rwx,g=rw,o=x file.sh   # Specify permissions using =
```

---

### 🔹 Change Ownership

```bash id="y9hn52"
sudo chown user file.txt           # Change file owner
sudo chown :group file.txt         # Change file Group
sudo chown user:group file.txt     # Change file Owner + Group
sudo chown -R user dir_name        # Change dir/ owner
sudo chown -R :group dir_name      # Change dir/ Group
sudo chown -R user:group dir_name  # Change dir/ Owner + Group

# Changing Group using chgrp
sudo chgrp newgrp filename
sudo chgrp -R newgrp dir_name
```

---

## 🔹 View Permissions

```bash id="u8z3x2"
ls -l
```

---

## 📂 Directory Permissions

* **Read (r)** → List files
* **Write (w)** → Create/delete files
* **Execute (x)** → Enter directory (`cd`)

---

## 🔐 Special Permissions (Important)

### 🔹 SUID (Set User ID)

```bash id="zyj3iy"
chmod u+s file # Runs file with owner’s permissions
```

### 🔹 SGID (Set Group ID)

```bash id="s1nny2"
chmod g+s filename # Runs file with group's permissions
chmod g+s dir      # New files inherit group ownership
```

### 🔹 Sticky Bit

```bash id="6x2xul"
chmod +t dir  # Only file owner can delete files (used in `/tmp`), even if others have write permissions
```

---

## ⚡ Important Notes

* `chmod` → change permissions

* `chown` → change owner

* `ls -l` → check permissions

* Always be careful with `chmod 777` - Gives full access to everyone (security risk)

* `umask` - defins default permissions for files & directories, default final permissions after applying `umask` file=644 (rw-r-r), dir=755 (rwxr-xr-x).

---

## 🔹 Quick Revision Summary

* 3 users: **owner, group, others**
* 3 permissions: **read, write, execute**
* Numeric: r=4, w=2, x=1
* `chmod` → change permissions
* `chown` → change ownership
* Special perms: **SUID, SGID, Sticky Bit**
