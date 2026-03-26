# Section 9: Disk Management & LVM

## 💾 What is Disk Management?

* Disk management means:

  * Managing **disks and partitions**
  * Allocating storage
  * Mounting file systems

---

### 📦 Basic Concepts

#### 🔹 Disk

* Physical storage device
* Example: `/dev/sda`, `/dev/xvda`

#### 🔹 Partition

* A **division of a disk**
* Example:

  * `/dev/sda1`
  * `/dev/sda2`

#### 🔹 File System

* Format used to store data
* Example:

  * ext4 (most common in Ubuntu)
  * xfs

---

### 🧰 Important Disk Commands

1. `df (Disk Free)` – Shows disk space usage of mounted filesystems.
2. `du (Disk Usage)` – Shows disk usage of files and directories
3. `lsblk (List Block Devices)` – lists all disks and partitions
4. `blkid (Block ID)` – Locate and print attributes of partitions, Shows UUID and filesystem type.
    `UUID` is used for permanently mounting disks in `/etc/fstab` **A configuration file in Linux that tells the system which disks, partitions, or filesystems to mount automatically at boot time.**
5. `fdisk (Disk Partition Tool)` - Used to create, delete, manage partitions. Older tool (mainly for MBR disks), limited GPT support. `sudo fdisk -l`  “list partitions”, `sudo fdisk /dev/xvda`  “Open partition in interactive mode”
6. `parted (Partition Editor)` - Used to create, resize, manage partitions. Supports GPT and large disks. `sudo parted -l`. `sudo parted /dev/xvda` “Open parted on disk - interactive mode”

---

### How to check if disk is MBR or GPT

#### Method 1 (Best): Using parted

```bash
sudo parted -l
```

Look for this line: `Partition Table: gpt` OR `Partition Table: msdos`

Meaning:

* gpt → GPT disk
* msdos → MBR disk

#### Method 2: Using fdisk

```bash
sudo fdisk -l /dev/sda
```

If you see: `Disklabel type: gpt` → GPT
If you see: `Disklabel type: dos` → MBR

---

### Create Partition

Let's say our disk name is `/dev/nvme0n1`

#### Create Partition Using `parted`

We will create partition on /dev/nvme0n1

Check free space using:

`sudo parted /dev/nvme0n1 print free`

##### Step 1: Open parted on disk

```bash
sudo parted /dev/nvme0n1
```

##### Step 2: Check current partition table

Inside parted:  `print`

You will see: `Partition Table: unknown` OR `Partition Table: gpt`

##### Step 3: Create GPT partition table (if none exists i.e. Partition Table: unknown)

Inside parted: `mklabel gpt`

Confirm: Yes

##### Step 4: Create partition

Example: create partition from 1MB to 500MB

```bash
mkpart primary ext4 1MiB 500MiB
```

##### Step 5: Verify partition

Inside parted:  `print`

Output example:

```bash
Number  Start   End     Size
 1      1MiB    500MiB  499MiB
```

##### Step 6: Exit parted

`quit`

#### Create Partition Using `fdisk`

Open fdisk intractive mode on /dev/nvme0n1

```bash
sudo fdisk /dev/nvme0n1
```

Then press:
g   → create GPT
n   → new partition
Enter → default
Enter → default
Enter → default
w   → write changes

### Format Partition

```bash id="0xq5v2"
sudo mkfs.ext4 /dev/nvme0n1
```

---

### 📂 Mounting

#### What is Mounting?

* Attaching a partition to a directory

#### Mount Partition

mount point like `/mnt/data` must exist in advance befor mounting.

```bash id="50d0el"
sudo mount /dev/nvme0n1 /mnt/data
```

---

#### Unmount

```bash id="9p4o2x"
sudo umount /mnt/data
```

---

#### Auto Mount (Important)

File: `/etc/fstab` is used to mount disks automatically on boot

1. Get UUID: `sudo blkid`
2. Add to fstab: `sudo vim /etc/fstab`
3. Add: `UUID=abcd-1234 /data ext4 defaults,nofail 0 2`

Fields Explanation

| Field | Meaning               | Example        |
|-------|-----------------------|----------------|
| 1     | Device or UUID        | UUID=1234-5678 |
| 2     | Mount point           |/data           |
| 3     | Filesystem type       |ext4            |
| 4     | Mount options         |defaults        |
| 5     | Dump backup option    |0               |
| 6     | Filesystem check order|2               |

How to mount using fstab without reboot

```bash
sudo mount -a # Mounts everything defined in `/etc/fstab`
```

---

### Extend Existing Partition

#### Step 1: Install growpart

```bash
sudo apt update && sudo apt install cloud-guest-utils -y
```

#### Step 2: Extend partition

```bash
sudo growpart /dev/nvme0n1 1
```

This extends `partition 1` to full disk.

#### Step 3: Resize filesystem

For Ubuntu (ext4):

```bash
sudo resize2fs /dev/nvme0n1p1
```

#### Step 4: Verify

```bash
df -h
```

You should see:

```bash
/dev/nvme0n1p1   12G   ...
```

---

### Important Warning

DO NOT modify existing root partition: `/dev/root/` i.e. `/dev/nvme0n1p1`
This contains your OS.
If damaged → EC2 will not boot.

---

### Delete Partition

Before deleting a Partition

1. Make sure it is NOT mounted
2. Make sure it is NOT root (/) or boot partition
3. Take backup if data is important
4. Check mounted partitions: `lsblk` or `df -h`

If mounted, unmount first:

```bash
sudo umount /dev/nvme0n1p2
```

#### Delete Partition Using parted

##### Step 1 — Open parted on the disk (NOT partition)

⚠️ Always use the disk name, not p1/p2.

```bash
sudo parted /dev/nvme0n1
```

##### Step 2 — Show partitions

Inside parted: `print`
Example output:
Number  Start   End     Size
1       ...
2       ...

##### Step 3 — Remove the partition

If you want to delete partition 2:

`rm 2`

Confirm if asked.

##### Step 4 — Exit

`quit`

##### Step 5 — Inform kernel

```bash
sudo partprobe
```

Verify:

`lsblk`

nvme0n1p2 should be gone.

#### Alternative Method — Using fdisk

```bash
sudo fdisk /dev/nvme0n1
```

Inside fdisk:
p   → print
d   → delete
2   → partition number
w   → write changes

Deleting partition:

* Removes partition entry from GPT, Does NOT securely erase data. Data may still be recoverable
* To wipe completely: `sudo wipefs -a /dev/nvme0n1p2`

---

## 🔄 What is LVM (Logical Volume Manager)?

LVM is a storage management system that allows **flexible disk management** by creating **logical volumes** on top of **physical volumes**. You can resize, extend, and manage storage dynamically.

---

### Why LVM?

* Resize storage easily
* Combine multiple disks
* Better management

---

### 🧱 LVM Architecture (Hierarchy)

Physical Disk (/dev/nvme1n1)
       ↓
Physical Volume (PV): Actual disk or partition
       ↓
Volume Group (VG): Group of physical volumes
       ↓
Logical Volume (LV): Virtual partition created from VG
       ↓
Filesystem (ext4/xfs)
       ↓
Mount Point (/data)

### 🧰 LVM Commands

#### Step 1 — Install LVM

```bash
sudo apt update && sudo apt install lvm2 -y
```

#### Step 2 — Create Physical Volume (PV)

```bash
sudo pvcreate /dev/nvme0n1
sudo pvs  # List physical volumes
```

#### Step 3 — Create Volume Group (VG)

Create VG named my_vg:

```bash
sudo vgcreate my_vg /dev/nvme0n1
sudo vgs
```

#### Step 4 — Create Logical Volume (LV)

Create 5GB logical volume:

```bash
sudo lvcreate -L 5G -n my_lv my_vg
sudo lvs
```

Now device path will be:

`/dev/my_vg/my_lv`

#### Step 5 — Create Filesystem

```bash
sudo mkfs.ext4 /dev/my_vg/my_lv
```

#### Step 6 — Create Mount Point

```bash
sudo mkdir /data
```

#### Step 7 — Mount It

```bash
sudo mount /dev/my_vg/my_lv /data
df -h
```

#### Step 8 — Make It Permanent

Get UUID: `sudo blkid`
Edit: `sudo vim /etc/fstab`
Add: `/dev/my_vg/my_lv   /data   ext4   defaults   0 2`
Apply: `sudo mount -a`

### How to Extend LVM

Suppose you want to extend from 5GB → 8GB.

#### Step 1 — Extend Logical Volume

```bash
sudo lvextend -L +3G /dev/my_vg/my_lv
```

#### Step 2 — Resize Filesystem

For ext4:

```bash
sudo resize2fs /dev/my_vg/my_lv
df -h
```

Done — no reboot required.

---

### Delete LVM

Assume:
VG name: my_vg
LV name: my_lv
PV: /dev/nvme0n1p1
Mount: /mnt/local_val

#### Step 1 — Unmount filesystem

```bash
sudo umount /mnt/local_val
```

Verify:

```bash
mount | grep local_val
```

No output = good

#### Step 2 — Remove Logical Volume

```bash
sudo lvremove /dev/my_vg/my_lv
```

Type: `y`

Verify: `sudo lvs`

#### Step 3 — Remove Volume Group

```bash
sudo vgremove my_vg
```

Verify: `sudo vgs`

#### Step 4 — Remove Physical Volume

```bash
sudo pvremove /dev/nvme0n1p1
```

Verify: `sudo pvs`

#### Step 5 (Optional) — Delete partition

If you created partition:

```bash
sudo parted /dev/nvme0n1
rm 1
quit
```

#### Step 6 (Optional) — Wipe filesystem signatures

```bash
sudo wipefs -a /dev/nvme0n1p1
```

## 🔹 Quick Revision Summary

* Disk → physical storage
* Partition → part of disk
* File system → data format
* Mount → attach disk to directory
* LVM = flexible storage management
* PV → VG → LV structure

---
