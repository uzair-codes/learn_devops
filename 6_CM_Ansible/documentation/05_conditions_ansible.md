# 🔹 Conditions in Ansible (`when`)

Conditions allow Ansible to **run a task only if a condition is true**.
Without conditions → Task always runs
With conditions → Task runs only when required

## 1️⃣ Basic Syntax

```yaml
when: condition
```

Example:

```yaml
- name: Install nginx only on Ubuntu
  apt:
    name: nginx
    state: present
  when: ansible_os_family == "Debian"
```

✔ Task runs only if OS family is Debian (Ubuntu uses Debian family)

## 2️⃣ Most Common Condition Operators

| Operator | Meaning          |
| -------- | ---------------- |
| ==       | Equal            |
| !=       | Not equal        |
| >        | Greater than     |
| <        | Less than        |
| >=       | Greater or equal |
| <=       | Less or equal    |
| and      | Logical AND      |
| or       | Logical OR       |
| not      | Negation         |

## 3️⃣ Condition Using Variables

```yaml
vars:
  env: production
```

```yaml
- name: Run only in production
  debug:
    msg: "Production environment"
  when: env == "production"
```

## 4️⃣ Multiple Conditions

### Using AND

```yaml
when: env == "production" and app_port == 80
```

### Using OR

```yaml
when: env == "dev" or env == "test"
```

## 5️⃣ Condition with List

```yaml
when: ansible_os_family in ["Debian", "RedHat"]
```

✔ Checks if value exists in list

## 6️⃣ Condition with Registered Variable ⭐

```yaml
- name: Check if nginx installed
  command: which nginx
  register: nginx_check
  ignore_errors: yes

- name: Install nginx if not present
  apt:
    name: nginx
    state: present
  when: nginx_check.rc != 0
```

Most common real-world condition: Using `register` + checking `rc`.

Explanation:

* `rc` = return code
* 0 → success
* Non-zero → failure

## 7️⃣ Condition with Loop

```yaml
- name: Install only nginx
  debug:
    msg: "{{ item }}"
  loop:
    - nginx
    - git
  when: item == "nginx"
```

Condition applies per loop item.

## 8️⃣ Condition Based on Facts ⭐

Ansible collects system facts automatically.
Example:

```yaml
- name: Install package on RedHat
  yum:
    name: httpd
    state: present
  when: ansible_os_family == "RedHat"
```

Only installs httpd on RedHat.
Common fact variables:

* `ansible_os_family`
* `ansible_hostname`
* `ansible_distribution`
* `ansible_memtotal_mb`

## 9️⃣ Using `is defined` and `is not defined`

Very important to avoid errors.

```yaml
when: app_port is defined
```

```yaml
when: app_port is not defined
```

Check if variable exists before using it

✔ Prevents undefined variable errors

## 1️⃣0️⃣ Condition in Block

You can apply condition to multiple tasks.

```yaml
- block:
    - name: Install nginx
      apt:
        name: nginx
        state: present

    - name: Start nginx
      service:
        name: nginx
        state: started
  when: ansible_os_family == "Debian"
```

✔ Cleaner than repeating `when` for each task

## 1️⃣1️⃣ Condition in Roles

You can apply condition when including role:

```yaml
- hosts: web
  roles:
    - role: nginx
      when: env == "production"
```

Only applies nginx role in production environment.

## 🔥 Real DevOps Example

```yaml
- hosts: web
  tasks:

    - name: Check disk usage
      shell: df -h /
      register: disk

    - name: Alert if disk > 80%
      debug:
        msg: "Disk usage high"
      when: "'80%' in disk.stdout"
```

Checks disk usage and alerts if it exceeds 80%.

## 🚀 Quick Revision Summary

* Use `when:` for conditions
* Works with variables, facts, loops
* Supports logical operators
* `is defined` prevents errors
* Registered output uses `.rc`
