# Section 14: grep, awk and sed (Text Processing Tools)

## 📄 What are grep, awk, sed?

These are **powerful Linux tools** used to:

* Search text
* Filter data
* Modify content

👉 Very important in DevOps for:

* Log analysis
* Automation
* Data processing

---

## 🔍 1. grep (Search Tool)

* Used to **search text inside files**

### grep Basic Syntax

```bash
grep "pattern" file.txt
```

👉 Finds lines containing the pattern

### Important grep Commands

#### Search Text

```bash
grep "error" file.txt
```

#### Ignore Case

```bash
grep -i "error" file.txt
```

#### Show Line Numbers

```bash
grep -n "error" file.txt
```

#### Count Matches

```bash
grep -c "error" file.txt
```

#### Search Recursively

```bash
grep -r "error" /var/log
```

#### Invert Match (exclude)

```bash
grep -v "error" file.txt
```

---

## 🧠 2. awk (Pattern + Processing Tool)

* Used for:

  * **Processing structured data**
  * Works line by line
  * Splits data into columns (fields)

### awk Basic Syntax

```bash
awk 'pattern {action}'
```

### Important awk Examples

#### Print First Column

```bash
awk '{print $1}' file.txt
```

#### Print Multiple Columns

```bash
awk '{print $1, $3}' file.txt
```

#### Use Condition

```bash
awk '$3 > 50 {print $1}' file.txt
```

👉 Print rows where column 3 > 50

#### Change Field Separator

```bash
awk -F ":" '{print $1}' /etc/passwd
```

👉 `-F` = field separator

---

## ✂️ 3. sed (Stream Editor)

* Used to **edit text automatically**
* Can:

  * Replace text
  * Delete lines
  * Modify files

---

### sed Basic Syntax

```bash
sed 's/old/new/' file.txt
```

👉 Replace first occurrence

---

### Important sed Commands

#### Replace Text

```bash
sed 's/error/success/' file.txt
```

#### Replace All Occurrences

```bash
sed 's/error/success/g' file.txt
```

#### Edit File Directly

```bash
sed -i 's/error/success/g' file.txt
```

👉 `-i` = modify file

#### Delete Line

```bash
sed '2d' file.txt
```

👉 Deletes line 2

#### Print Specific Line

```bash
sed -n '2p' file.txt
```

## ⚡ grep vs awk vs sed (Simple Difference)

| Tool | Use                      |
| ---- | ------------------------ |
| grep | Search text              |
| awk  | Process and analyze data |
| sed  | Edit/modify text         |

---

## ⚡ Important Notes

* grep → filtering logs
* awk → working with columns (very important for logs, CSV)
* sed → automation and editing files

---

## 🔹 Quick Revision Summary

* grep = search text
* awk = process structured data
* sed = modify text
* `grep -i`, `-r`, `-v` commonly used
* `awk -F` for delimiter
* `sed -i` for in-place editing
