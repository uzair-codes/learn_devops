# Section 11: Shell Scripting (Conditions, Loops, Functions)

## 🖥️ What is Shell Scripting?

* Shell scripting = writing **commands in a file** to automate tasks
* File extension:

  ```bash
  .sh
  ```

### Example

```bash id="8q6u9y"
#!/bin/bash
set -x # run script in debug mode
set -e # exit at error
set -o pipefail # exit if | fails
echo "Hello DevOps"
```

👉 `#!/bin/bash` (**Shebang**)→ tells system to use bash shell

### ▶️ Run Script

```bash id="6kl2s2"
chmod +x script.sh
./script.sh
bash -x script.sh
```

👉 `chmod +x` → makes script executable

---

## 📥 Variables

```bash id="a7k3q2"
name="Uzair"
echo $name
```

👉 Store and use values

---

## 🔀 Conditions (if-else)

### Basic If Condition

```bash id="0n8hqp"
if [ $num -gt 10 ]
then
  echo "Greater than 10"
fi
```

### If-Else

```bash id="2p1y0m"
if [ $num -gt 10 ]
then
  echo "Greater"
else
  echo "Smaller"
fi
```

### If-Elif-Else

```bash id="cbv4f1"
if [ $num -gt 10 ]
then
  echo "Greater"
elif [ $num -eq 10 ]
then
  echo "Equal"
else
  echo "Smaller"
fi
```

---

## Common Operators

* `-eq` → equal
* `-ne` → not equal
* `-gt` → greater than
* `-lt` → less than

---

## 🔁 Loops

### 🔹 For Loop

```bash id="cm5o7t"
for i in [1..100]
do
  echo $i
done
```

### 🔹 While Loop

```bash id="fkk7lq"
i=1
while [ $i -le 5 ]
do
  echo $i
  ((i++))
done
```

---

## ⏹️ Break & Continue

### Break (stop loop)

```bash id="jpfyil"
for i in 1 2 3 4
do
  if [ $i -eq 3 ]
  then
    break
  fi
  echo $i
done
```

### Continue (skip iteration)

```bash id="w5k6y1"
for i in 1 2 3 4
do
  if [ $i -eq 3 ]
  then
    continue
  fi
  echo $i
done
```

---

## 🧩 Functions

### Define Function

```bash id="o0psrb"
my_func() {
  echo "Hello from function"
}
```

### Call Function

```bash id="4tsav0"
my_func
```

### Function with Argument

```bash id="q1vjq0"
greet() {
  echo "Hello $1"
}

greet Uzair
```

👉 `$1` = first argument

---

## ⚡ Important Notes

* Always start with:

  ```bash
  #!/bin/bash
  ```

* Use variables to make scripts flexible
* Use loops for repetition
* Use conditions for decision making

---

## 🔹 Quick Revision Summary

* Shell script = automation using `.sh` files
* `chmod +x` → make executable
* Variables store values
* `if-else` → decision making
* `for`, `while` → loops
* Functions = reusable code
* `break` & `continue` control loops
