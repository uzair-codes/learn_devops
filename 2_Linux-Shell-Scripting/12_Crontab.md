# Section 12: Crontab (Job Scheduling)

## 🕒 What is Crontab?

* Crontab = schedule **commands or scripts** to run automatically at a specified time
* Used in DevOps to automate tasks like backups, monitoring, or cleanup

---

## 📂 Crontab Files

* **System Crontab:** `/etc/crontab` → runs for all users
* **User Crontab:** edited using `crontab -e` → runs for current user

---

## 🧰 Crontab Commands

### Edit User Crontab

```bash id="1k2vxl"
crontab -e
```

### List User Cron Jobs

```bash id="9p8vjq"
crontab -l
```

### Remove User Cron Jobs

```bash id="6r4xzj"
crontab -r
```

---

## ⏰ Cron Syntax

```bash
* * * * * command_to_run
| | | | |
| | | | └─ Day of week (0-7) Sun=0/7
| | | └── Month (1-12)
| | └─── Day of month (1-31)
| └──── Hour (0-23)
└───── Minute (0-59)
```

### 🔹 Examples

#### Run every day at 2 AM

```bash id="v1tqj2"
0 2 * * * /home/uzair/backup.sh
```

#### Run every 5 minutes

```bash id="2z8xkc"
*/5 * * * * /home/uzair/check_disk.sh
```

#### Run every Monday at 9 AM

```bash id="9t1pjx"
0 9 * * 1 /home/uzair/weekly_report.sh
```

---

## 🧩 Special Strings

| String   | Meaning         |
| -------- | --------------- |
| @reboot  | Run at startup  |
| @hourly  | Run every hour  |
| @daily   | Run every day   |
| @weekly  | Run every week  |
| @monthly | Run every month |

### Example

```bash id="k4u2zd"
@daily /home/uzair/daily_backup.sh
```

---

## ⚡ Important Notes

* Use **absolute paths** for commands/scripts
* Scripts must be executable (`chmod +x`)
* Cron logs: `/var/log/syslog` (Ubuntu)

---

## 🔹 Quick Revision Summary

* Crontab automates tasks on schedule
* `crontab -e` → edit jobs
* `crontab -l` → list jobs
* Syntax: `min hr day month weekday command`
* Special strings: `@daily`, `@reboot`, etc.
* Always use absolute paths
