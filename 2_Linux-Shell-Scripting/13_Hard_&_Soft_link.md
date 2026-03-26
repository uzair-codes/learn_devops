# Section 13: Hard & Soft Links, Break & Continue in Shell

## 🔗 What are Links in Linux?

Links allow **multiple names for the same file**.
Two types: **Hard Link** and **Soft Link (Symbolic Link)**

## 🧱 Hard Link

* Points to the **same inode** (physical file)
* **Cannot link directories**
* **Changes reflect in both files**
* Cannot cross file systems

### Create Hard Link

```bash id="hlnk1"
ln original.txt hardlink.txt
```

### Check

```bash id="hlnk2"
ls -l
```

* Hard link has **same inode number** as original file

---

## 🌿 Soft Link (Symbolic Link)

* Points to the **file path**
* Can link directories
* Can cross file systems
* If original file is deleted → soft link breaks

### Create Soft Link

```bash id="slnk1"
ln -s original.txt softlink.txt
```

Check:

```bash id="slnk2"
ls -l
```

* Soft link shows `-> original.txt`

---

## ⚡ Important Notes

* Hard link = same inode, soft link = path pointer
* `ln` → hard link, `ln -s` → soft link
* Links are useful in DevOps for config files and scripts

---

## 🔹 Quick Revision Summary

* Hard link = duplicate pointer to same file
* Soft link = pointer to file path
* Hard link cannot cross file systems, soft link can

---

## 🔹 Interview Key Points

* Difference between **hard link and soft link**
* Commands: `ln`, `ln -s`
* Use cases of soft links (configs, binaries)

---
