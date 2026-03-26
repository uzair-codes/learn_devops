# Ansible Roles Directory Structure

In Ansible, **roles** are used to organize playbooks and automation logic into **reusable, modular components**. Instead of writing everything in one large playbook, roles help structure the project into logical parts such as web server setup, database configuration, or monitoring installation.

A typical roles directory looks like this:

```bash
roles/
  <role_name>/
    README.md
    defaults/
    files/
    handlers/
    meta/
    tasks/
    templates/
    tests/
    vars/
```

Each subdirectory has a specific purpose.

---

## 1. `README.md`

This file contains **documentation for the role**.

Typical contents include:

* Role purpose
* Variables used
* Example playbook usage
* Dependencies
* Author information

Example:

```markdown
# nginx role

This role installs and configures nginx web server.

## Variables

nginx_port: 80

## Example

- hosts: web
  roles:
    - nginx
```

This helps other engineers understand **how to use the role**.

---

## 2. `defaults/`

This directory contains **default variables for the role**.

File:

```yml
defaults/main.yml
```

These variables have the **lowest priority** and can easily be overridden by:

* playbooks
* inventory variables
* extra vars

Example:

```yaml
nginx_port: 80
nginx_user: www-data
```

Defaults are ideal for **configuration values users may want to change**.

---

## 3. `files/`

This directory contains **static files** that will be copied to managed hosts.

Example files:

```bash
roles/nginx/files/index.html
roles/nginx/files/nginx.conf
```

Used with the `copy` module:

```yaml
- name: Copy nginx config
  copy:
    src: nginx.conf
    dest: /etc/nginx/nginx.conf
```

Important:
When referencing files inside a role, **Ansible automatically searches the role's `files/` directory**.

---

## 4. `handlers/`

Handlers contain tasks that run **only when notified by another task**.

File:

```yml
handlers/main.yml
```

Example:

```yaml
- name: Restart nginx
  service:
    name: nginx
    state: restarted
```

Called using `notify`:

```yaml
- name: Update nginx config
  template:
    src: nginx.conf.j2
    dest: /etc/nginx/nginx.conf
  notify: Restart nginx
```

Handlers are typically used for:

* restarting services
* reloading configurations

---

## 5. `meta/`

Contains **role metadata**.

File:

```yml
meta/main.yml
```

Used for:

* declaring role dependencies
* galaxy metadata
* supported platforms

Example:

```yaml
dependencies:
  - role: common
  - role: firewall
```

This means when this role runs, **Ansible will run those roles first**.

---

## 6. `tasks/`

This is the **main logic of the role**.

File:

```yml
tasks/main.yml
```

All role tasks are defined here or imported from other task files.

Example:

```yaml
- name: Install nginx
  apt:
    name: nginx
    state: present

- name: Start nginx
  service:
    name: nginx
    state: started
```

You can split tasks into multiple files:

```yml
tasks/
  main.yml
  install.yml
  config.yml
```

Example:

```yaml
- import_tasks: install.yml
- import_tasks: config.yml
```

This improves **readability and maintainability**.

---

## 7. `templates/`

Contains **Jinja2 templates** used for dynamic configuration files.

Example:

```j2
templates/nginx.conf.j2
```

Example template:

```j2
server {
  listen {{ nginx_port }};
  server_name {{ server_name }};
}
```

Used with the `template` module:

```yaml
- name: Deploy nginx config
  template:
    src: nginx.conf.j2
    dest: /etc/nginx/nginx.conf
```

Templates allow **variables to dynamically configure files**.

---

## 8. `tests/`

This directory is used to **test the role**.

Example structure:

```yml
tests/
  inventory
  test.yml
```

Example test playbook:

```yaml
- hosts: localhost
  roles:
    - nginx
```

This allows developers to **verify the role works correctly**.

---

## 9. `vars/`

This directory contains **role variables with higher priority than defaults**.

File:

```yml
vars/main.yml
```

Example:

```yaml
nginx_service_name: nginx
```

Variables here are **harder to override** and usually contain values that should **not be changed by users**.

---

## Example Complete Role Structure

```yml
roles/
  nginx/
    README.md
    defaults/
      main.yml
    files/
      index.html
    handlers/
      main.yml
    meta/
      main.yml
    tasks/
      main.yml
    templates/
      nginx.conf.j2
    tests/
      inventory
      test.yml
    vars/
      main.yml
```

---

## Using a Role in a Playbook

Example playbook:

```yaml
- hosts: web_servers
  become: true
  roles:
    - nginx
```

Ansible will automatically execute:

```yml
roles/nginx/tasks/main.yml
```

---

## Benefits of Using Roles

Roles provide several advantages:

* Modular project structure
* Reusable automation components
* Cleaner playbooks
* Easier collaboration
* Standardized project layout

Roles are considered a **best practice for large Ansible projects**.

---
