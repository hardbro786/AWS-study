# Ansible Inventory (Static File) – Documentation  

Why, What, Key Features

---

## 📌 Table of Contents
- [Author Information](#author-information)
- [Ansible Inventory](#ansible-inventory)
  - [What is Ansible Static Inventory](#what-is-ansible-static-inventory)
  - [Why Static Inventory](#why-static-inventory)
  - [Key Features of Static Inventory](#key-features-of-static-inventory)
- [Static Inventory Structure](#static-inventory-structure)
- [Example Static Inventory File](#example-static-inventory-file)
- [FAQs](#faqs)
- [Contact Information](#contact-information)

---

## Author Information

| Author      | Created on | Version | Last updated by | Last edited on |
| ----------- | ---------- | ------- | --------------- | -------------- |
| Hardik Modi | 16-01-2026 | v1.0    | Hardik Modi     | 16-01-2026     |

---

## Ansible Inventory

### What is Ansible Static Inventory

Ansible **Static Inventory** is a manually maintained file that contains a list of servers (hosts) along with their IP addresses or DNS names.

It also defines:
- Server grouping (web, db, app, etc.)
- SSH connection details (user, key, port)
- Environment-based organization (dev, qa, prod)

Static inventory files are usually written in **INI** or **YAML** format.

---

### Why Static Inventory

| Reason | Description |
|------|------------|
| Simple to Use | Easy to understand and configure |
| Full Control | Manual control over servers |
| Beginner Friendly | Best for learning Ansible |
| No External Dependency | Does not require cloud APIs |
| Stable Infra Support | Ideal for small and fixed environments |

---

### Key Features of Static Inventory

| Feature | Description |
|------|------------|
| Host Definitions | Servers defined using IP or DNS |
| Grouping Support | Logical grouping of hosts |
| Variable Support | SSH user, key, ports |
| Multiple Formats | INI and YAML supported |
| Reliable Execution | Works consistently with Ansible |

---

## Static Inventory Structure

A proper static inventory should:
- List **all servers with correct names or IPs**
- Organize servers into **groups**
- Include **required SSH and runtime settings**
- Work correctly with Ansible commands

**Common inventory file name:**
```bash
hosts
[web]
web1 ansible_host=13.233.10.10
web2 ansible_host=13.233.10.11

[db]
db1 ansible_host=13.233.20.20

[app]
app1 ansible_host=13.233.30.30

[production:children]
web
db
app

[production:vars]
ansible_user=ec2-user
ansible_ssh_private_key_file=~/mykey.pem
ansible_python_interpreter=/usr/bin/python3
```

## Test Inventory 

ansible -i hosts production -m ping

anisible -i hosts web -m ping

## FAQs

**Q1. What is a static inventory in Ansible?**  
A static inventory is a manually created file that lists hosts (servers) and groups along with their connection details such as IP addresses, SSH users, and keys.

**Q2. Can static inventory be used in production?**  
Yes, static inventory can be used in production environments that are small, stable, and do not change frequently.

**Q3. Which format is better – INI or YAML?**  
INI format is simpler and easier for beginners, while YAML is more structured, readable, and preferred for complex inventories.

**Q4. Where should common variables be defined?**  
Common variables should be defined using group variables (`[group:vars]`) or in the `group_vars` directory for better organization and reusability.

---

## References

- Ansible Inventory Documentation  
  https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html

- Ansible Best Practices  
  https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html

- Ansible Variable Precedence  
  https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_variables.html#understanding-variable-precedence

- Ansible Command Line Tools  
  https://docs.ansible.com/ansible/latest/cli/ansible.html

---

## Contact Information

| Name        | Email                    |
|-------------|--------------------------|
| Hardik Modi | modihardik19@gmail.com   |

