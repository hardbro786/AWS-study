# PostgreSQL POC Setup on AWS

---
## Document Details
|     Author      |  Created on  | Version | L0 Reviewer | L1 Reviewer | L2 Reviewer |
|-----------------|--------------|---------|-------------|-------------|-------------|
| Suraj Tripathi  |  04-02-2026  |  1.0    | Annirudh    |Shreya S     |Ashwani      |

---

## Index

 1. [Cloud & Infrastructure Details](#1-cloud--infrastructure-details)
 2. [Supported Linux Distributions for PostgreSQL)](#2-supported-linux-distributions-for-postgresql)
 3. [PostgreSQL Installation](#3-postgresql-installation)
    - 3.1 [Configure PostgreSQL Apt Repository (Automated)](#31-configure-postgresql-apt-repository-automated)
    - 3.2 [Manual Repository Configuration (Optional)](#32-manual-repository-configurationoptional)
    - 3.3 [Verify PostgreSQL Service](#33-verify-postgresql-service)
    - 3.4 [PostgreSQL Login](#34-postgresql-login)
 4. [Database Demo (POC Validation)](#4-database-demo-poc-validation)
 5. [Set PostgreSQL User Password](#5-set-postgresql-user-password)
 6. [Client EC2 Configuration](#6-client-ec2-configuration)
 7. [Security Best Practices (POC Level)](#7-security-best-practices-poc-level)
 8. [POC Outcome](#8-poc-outcome)
 9. [Notes for Jira Documentation](#9-notes-for-jira-documentation)
10. [Contact Information](#10-contact-information)

---

## 1. Cloud & Infrastructure Details
- **Cloud Platform**: AWS
- **AMI**: Ubuntu Server 24.04 (LTS – Noble)
- **Instance Type**: t3.micro
- **PostgreSQL Version**: 14
- **Architecture**: amd64
- **Ports Used**:
  - `22` – SSH (restricted to admin IP)
  - `5432` – PostgreSQL (restricted)

---
## 2. Supported Linux Distributions for PostgreSQL

| Distribution Family | Example Distributions | Package Manager |
|--------------------|----------------------|------------------|
| Debian-based | Ubuntu (22.04, 24.04), Debian (11, 12, 13) | APT |
| RHEL-based | RHEL, Rocky Linux, AlmaLinux, CentOS Stream (8, 9) | DNF/YUM |
| SUSE-based | openSUSE, SLES | Zypper |
| Arch-based | Arch Linux, Manjaro | Pacman |


---
## 3. PostgreSQL Installation
### 3.1 Configure PostgreSQL Apt Repository (Automated)
```bash
sudo apt install -y postgresql-common
sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh
```
### 3.2 Manual Repository Configuration(Optional)
Import the repository signing key:
```bash
sudo apt install curl ca-certificates
```
```bash
sudo install -d /usr/share/postgresql-common/pgdg
```
```bash
sudo curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail \
https://www.postgresql.org/media/keys/ACCC4CF8.asc
```
Create the repository configuration file:
```bash
. /etc/os-release
```
```bash
sudo sh -c "echo 'deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] \
https://apt.postgresql.org/pub/repos/apt $VERSION_CODENAME-pgdg main' \
> /etc/apt/sources.list.d/pgdg.list"
```
<img width="1890" height="552" alt="Screenshot 2026-02-02 233155" src="https://github.com/user-attachments/assets/95db1f0d-6767-46c8-a598-a7fd6a415cc1" />

Update the package lists:
```bash
sudo apt update
```
Install PostgreSQL: (replace "14" by the version you want)
```bash
sudo apt install postgresql-14
```
<img width="1279" height="377" alt="Screenshot 2026-02-02 233308" src="https://github.com/user-attachments/assets/130fe616-dfdf-47ac-8792-9fb70b17a9e5" />

### 3.3 Verify PostgreSQL Service
```bash
sudo systemctl status postgresql
```
<img width="1358" height="301" alt="Screenshot 2026-02-02 233527" src="https://github.com/user-attachments/assets/11a964bb-9eb9-459c-9abb-d229e1550155" />

### 3.4 PostgreSQL Login
```bash
sudo -u postgres psql
```
<img width="734" height="168" alt="Screenshot 2026-02-02 233629" src="https://github.com/user-attachments/assets/1c6b3fc0-97ca-4e06-99f3-b735e4ccf513" />

---
## 4. Database Demo (POC Validation)

#### Create Database
```bash
CREATE DATABASE procdb;
```
<img width="630" height="116" alt="Screenshot 2026-02-02 233823" src="https://github.com/user-attachments/assets/08b5a731-dd99-48bd-a79b-c7e14a927c53" />

#### List Databases
```bash
\l
```
<img width="1656" height="381" alt="Screenshot 2026-02-02 234041" src="https://github.com/user-attachments/assets/462ced23-f2f4-4a71-9a52-bd53a169ccf3" />

#### Connect to Database
```bash
\c <database_name>
```
```bash
Example: \c procdb
```
<img width="1084" height="111" alt="Screenshot 2026-02-02 234204" src="https://github.com/user-attachments/assets/6d610d7d-6553-49be-92f5-a8f04dd6ba0b" />

#### Create Table
```bash
CREATE TABLE employee (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  role VARCHAR(50)
);
```
<img width="991" height="208" alt="Screenshot 2026-02-02 234359" src="https://github.com/user-attachments/assets/6df623bd-cf70-482f-9468-c538933bfb8a" />

#### List Tables
```bash
\dt
```
<img width="716" height="235" alt="Screenshot 2026-02-02 234549" src="https://github.com/user-attachments/assets/7936e254-758a-4d51-8ce7-1d19cbf68042" />

#### Insert Data
```bash
INSERT INTO employee(name, role)
VALUES ('Suraj', 'DevOps');
```
<img width="1859" height="138" alt="Screenshot 2026-02-02 234803" src="https://github.com/user-attachments/assets/8af1b5e9-b8f8-4263-b506-aa85f5085582" />

#### Show table data
```bash
SELECT * FROM employee;
```
<img width="1894" height="209" alt="Screenshot 2026-02-02 234916" src="https://github.com/user-attachments/assets/56f57c58-1f92-42e4-a31f-ec5670fc4151" />

---
## 5. Set PostgreSQL User Password
```bash
sudo -u postgres psql
```
```bash
ALTER USER postgres WITH PASSWORD 'StrongPassword@123';
```
Exit:
``` bash
\q
```
## 6. Client EC2 Configuration

#### Install PostgreSQL Client
```bash
sudo apt update
sudo apt install postgresql-client -y
```
#### Connect to PostgreSQL from Client EC2
```bash
psql -h <DB-EC2-private-IP> -p 5432 -U postgres
```
<img width="841" height="248" alt="image" src="https://github.com/user-attachments/assets/8d11a337-c14a-4605-a13b-a3f20f5e9dda" />

---
## 7. Security Best Practices (POC Level)

- PostgreSQL port 5432 is restricted to client subnet / EC2 IP.

- SSH port 22 is restricted to admin IP.

- Database communication uses private IPs within VPC.

- Public IP is used only for administrative access (POC purpose)

---
## 8. POC Outcome

- PostgreSQL successfully installed on AWS EC2

- Database operations validated

---

## 9. Notes for Jira Documentation

All installation steps documented

- Issues and resolutions recorded

- POC validated with live demo

## 10. Contact Information

| Contact Type | Details                                                             |
| ------------ | ------------------------------------------------------------------- |
| Name         | Suraj Tripathi                                                      |
| Role         | DevOps Trainee                                                      |
| Email        | [suraj.tripathi.snaatak@mygurukulam.co](mailto:suraj.tripathi.snaatak@mygurukulam.co) |

### End of POC
---
