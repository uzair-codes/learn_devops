# Networking for DevOps

## Computer Networking

In simple words, networking is how different systems (servers, containers, services, users) **talk to each other** over a network.

### Core Networking Concepts (Simple Explanation)

#### 1. OSI

- Application Layer
- Presentation Layer
- Session Layre
- Transport Layre
- Network Layer
- Data Link Layer
- Physical Layre

#### 2. IP Address

IP Address = Unique identity of a system in a network.

Example:

- 192.168.1.10 (private IP)
- 8.8.8.8 (public IP)

Types:

- Private IP → inside network (AWS VPC, office)
- Public IP → accessible from internet

Think of it like:
IP = Home address of a server

---

#### 3. DNS (Domain Name System)

DNS converts domain names into IP addresses.

Example:
google.com → 142.250.x.x

Why needed?
Humans remember names, computers use IPs.

Command example:
nslookup google.com

---

#### 4. Ports

Port is a unique number, that allows to identify a specific program on system.
Ports define **which service is running** on a system.

Examples:

- 80 → HTTP
- 443 → HTTPS
- 22 → SSH
- 3306 → MySQL

Think like:
IP = building
Port = room number

---

#### 5. Protocols

Protocols define **how communication happens**.

Common ones:

- HTTP → web traffic
- HTTPS → secure web traffic
- TCP → reliable communication
- UDP → fast but less reliable

---

### 6. HTTP vs HTTPS

HTTP:

- Not secure
- Data is plain text

HTTPS:

- Secure (uses SSL/TLS)
- Data is encrypted

---

### 7. Load Balancer

A Load Balancer distributes traffic across multiple servers.

Example:
Instead of 1 server handling all users:

User → Load Balancer → Server1 / Server2 / Server3

Benefits:

- High availability
- Scalability
- No single point of failure

---

### 8. Firewall

Firewall controls **who can access your system**.

Example:

- Allow port 22 (SSH)
- Block all other ports

In Linux:
firewalld / iptables

---

### 9. Subnet

A subnet is a **smaller network inside a big network**.

Example:
VPC → divided into subnets

Types:

- Public subnet → internet access
- Private subnet → no direct internet

---

### 10. NAT (Network Address Translation)

NAT allows private servers to access the internet.

Example:
Private server → NAT → Internet

Used in:

- AWS private subnet instances

---

### How Networks Work

Example: User opens a website

1. User types: [www.example.com](http://www.example.com)
2. DNS converts it to IP
3. Request goes to Load Balancer
4. Load Balancer sends request to server
5. Server responds via HTTP/HTTPS
6. Response goes back to user

---

#### Real-World DevOps Example

Example: Deploying a web app in cloud

Flow:

User → Internet → Load Balancer → EC2 Instance → App → Database

- Load balancer handles traffic
- App runs on server
- Database runs in private subnet
- Firewall restricts access

---

### Core Networking Protocols

#### Node Identification Protocols

- MAC, IPv4, IPv6

#### Data Transmission Protocols

- TCP, UDP

#### Link Contentation Protocols

- CSMA/CA, CSMA/CD

#### Resource Sharing Protocols

- Ensure that different organizations and individuals can share information
- Protocols: HTTP, HTTPS, FTP, SMTP

## AWS Core Concepts

AWS is a cloud platform that provides:

- Virtual servers
- Storage
- Networking
- Databases
- DevOps tools

You don’t need to manage physical hardware.

---

### 1. VPC (Virtual Private Cloud)

A VPC is your **private network in AWS**.

It includes:

- IP range (CIDR block)
- Subnets
- Route tables
- Internet Gateway

Example:

```bash
VPC: 10.0.0.0/16
```

---

### 2. Subnets in AWS

Subnets divide VPC into smaller networks.

Example:

| Subnet      | Type    |
| ----------- | ------- |
| 10.0.1.0/24 | Public  |
| 10.0.2.0/24 | Private |

#### Private Subnets

- **No** Internet Access
- Place **sensitive resources** here
- Can access internet using NAT Gateway (for software updates)

#### Public Subnets

- Can access internet
- Place **Public resources** here, like Webservers, Load Balancers

---

### 3. Internet Gateway (IGW)

Connects VPC to internet, Allows communication between VPC and internet.

Used for:

- Public servers
0 Web applications

---

### 4. NAT (Network Address Translation) Gateway

Translates Private address to Public address.
Allows private instances to access internet.

Example use case:

- Install packages on private server
- Pull Docker images

---

### 5. Route Tables

Define how traffic flows inside VPC.

Example:

| Destination | Target           |
| ----------- | ---------------- |
| 0.0.0.0/0   | Internet Gateway |

---

### 6. Security Groups

Acts as a **firewall for instances**.
Controls inbound and outbound traffic of an instance.
Example rules:

- Allow SSH (22)
- Allow HTTP (80)

---

### 7. NACLs

Acts as a **firewall for subnet**
Controls inbound and outbound traffic of a subnet.

### 8. EC2 (Elastic Compute Cloud)

Virtual servers in AWS.

Used to:

 Run applications
 Host websites
 Run backend services

---

### 9. Load Balancer (ELB)

AWS provides:

- Application Load Balancer (ALB)
- Network Load Balancer (NLB)

Used to:

- Distribute traffic
- Improve availability

---

### 10 Elastic IP (EIP)

- Static Public IP

---

### 11 AutoSacling Group (ASG)

- A service that automatically creates and removes instnces to match traffic demands.

### 12 Bastion Host or Jumper Server

- An EC2 instance in public subnet, that is used to access instances in private subnet via SSH.

### 13 Identity and Access Management

- Role base access management service (A Security Service)
- It allows you to create users (People, Services, Apps) and give them permissions based on their roles.  

**IAM User:** User created in AWS account with certain permissions
**IAM Group:** Put multiple users together and assign permissions to group. Makes user management easy.
**IAM Roles:** Temporary permissions give to IAM users.
**IAM Polices:** The actual rules (Json Documents) that defines permissions.

### How It Works (Step-by-Step)

Example: Hosting a web application in AWS

1. Create a VPC
2. Create public and private subnets
3. Attach Internet Gateway to VPC
4. Launch EC2 instance in public subnet
5. Configure security group (allow HTTP/SSH)
6. Deploy application on EC2
7. Attach Load Balancer
8. Map domain using DNS

---

### AWS Services for DevOps

#### Core Infrastructure and Storage Services

- EC2 Instance, VPC, EBS(Persistant block storage), S3

#### Security and Access Services

- IAM, KMS (Stores and Manages Encryption Keys)

#### Monitoring Services

- Cloud Watch, Cloud Trail (Record all API activities)
- Lambda Function: Server less compute service

#### CI/CD and Development Services

- Code build Service
  - Code Build
  - Code Deploy
  - Code Pipeline

#### Container Orchestration Service

- EKS, ECS (AWS Specific), Fargate (Serverless compute Engine for Conatiners)

#### Logging and Data Search

- Elastic Search (Search engin for logs and data)
- EKL Stack - Elastic Search, log Stach and Kibana
