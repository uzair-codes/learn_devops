
# Infrastructure as Code (IaC)

Practice of managing and creating IT infrastructure using configuration file.

## IaC Advantages

- **Fast** → Infrastructure can be created in minutes.
- **Less Errors** → No manual mistakes.
- **Consistent** → Same setup every time.
- **Version Controlled** → Code can be stored in VCS like Git.
- **Scalable** → Easy to increase or reduce resources.
- **Reusable** → Same code can be reused in other projects.
- **Declarative** → We define what we want, not how to create it.

## 🌩️ Cloud-Native vs Cloud-Agnostic IaC Tools

### 🔹 1. Cloud-Native IaC Tools

These tools are **built by cloud providers** and work mainly with their own platform.

#### Cloud-Native IaC Tools Examples

- AWS CloudFormation → only for AWS
- Azure Resource Manager → only for Azure
- Google Cloud Deployment Manager → only for GCP

#### Cloud-Native IaC Tools Key Features

- Deep integration with their cloud
- Supports all services of that cloud
- Strong security and access control (IAM)

#### Cloud-Native IaC Tools Limitations

- Vendor lock-in (you are stuck with one cloud)
- Hard to move to another cloud later

---

### 🔹 2. Cloud-Agnostic IaC Tools

These tools work across **multiple cloud providers**.

#### Cloud-Agnostic IaC Tools Examples

- Terraform ⭐ (Most popular)
- Pulumi
- Ansible (also supports IaC)

#### Cloud-Agnostic IaC Tools Key Features

- Works with AWS, Azure, GCP, and more
- Same code can be reused
- No vendor lock-in

#### Cloud-Agnostic IaC Tools Limitations

- Sometimes slower to support new cloud features
- Requires external providers/plugins

---

## 🚀 Why Terraform?

Terraform is the **most widely used IaC tool in DevOps**.

Let’s understand **WHY** 👇

---

### 🔹 1. Multi-Cloud Support 🌍

Terraform works with:

- AWS
- Azure
- GCP
- Kubernetes
- GitHub, Cloudflare, etc.

👉 One tool → manage everything

---

### 🔹 2. Declarative Language (HCL) 🧠

Terraform uses **HCL (HashiCorp Configuration Language)**.

Example:

```hcl
resource "aws_instance" "example" {
  ami           = "ami-123456"
  instance_type = "t2.micro"
}
```

👉 You describe **what you want**, not how to do it.

#### Declarative vs Imperative

Declarative → You define the desired final state and the tool figers out how to do it. **Example**: “I want 2 EC2 instances.”

Imperative → You define step-by-step instructions. **Example**: “Create server → Install OS → Configure network…”

Most modern IaC tools (like Terraform) are Declarative.

---

### 🔹 3. State Management 📦

Terraform keeps a **state file**:

- Tracks real infrastructure
- Knows what is created/changed/deleted
- Helps avoid duplication

👉 Very important for automation

---

### 🔹 4. Execution Plan (Safe Changes) 🔍

Before applying changes:

```bash
terraform plan
```

👉 Shows:

- What will be created
- What will be modified
- What will be deleted

➡️ Safe and predictable

---

### 🔹 5. Idempotency ♻️

Running same code multiple times:

```bash
terraform apply
```

👉 Result = Same infrastructure (no duplication)

---

### 🔹 6. Large Ecosystem (Providers & Modules) 🧩

- Providers → connect to platforms (AWS, Azure, etc.)
- Modules → reusable code

👉 Example:

```hcl
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
}
```

---

### 🔹 7. Version Control Friendly 📂

- Works perfectly with Git
- Easy to track changes
- Great for CI/CD pipelines

---

### 🔹 8. Automation & CI/CD Ready ⚙️

Terraform integrates with:

- Jenkins
- GitHub Actions
- GitLab CI/CD

👉 Fully automated infrastructure

---

### 🔹 9. Open Source + Industry Standard 🏆

- Huge community
- Tons of tutorials
- Used in real companies

---

### 📌 Simple Summary

- **Cloud-native tools** → limited to one cloud
- **Cloud-agnostic tools** → work everywhere
- **Terraform = best choice** because:

  - Multi-cloud
  - Easy syntax
  - Safe changes (plan)
  - Strong ecosystem
  - CI/CD friendly

---

## Terraform

- Infrastructure as Code (IaC) tool
- Uses HCL (HashiCorp Configuration Language) language

### 1. Key Features

- **Cloud Agnostic** - Terraform works with any cloud provider (AWS, Google Cloud, Azure, Kubernetes, Alibaba, etc.).
- **Immutable Infrastructure** - Replaces servers rather than changing them, reducing "configuration drift" (where servers become inconsistent over time).
- **State Management** -Terraform keeps track of real-world resources in a state file (terraform.tfstate)
- **Moduler** - You can package code into Modules to reuse common patterns.
- **Idempotent** - Compare the current infrastructure with the desired state and apply only the necessary changes.

---

### 2. Terraform Architecture & Core Elements

#### The Core (Engine)

- The main engine that reads your `.tf` files. Creates an execution plan. Communicates with providers. Manages the state file.
- It compares: Desired state (your code) vs Current state (real infrastructure). Then applies only required changes.

#### Terraform CLI

- Open-source Command Line Interface tool. Single executable binary. Used to run commands. It is how we interact with Terraform.

#### Terraform Providers

- Plugin that enables Terraform to interact with specific infrastructure platforms through their APIs.

#### Terraform State

- Stored in terraform.tfstate file, Keeps track of real resources, Maps Terraform code to actual cloud resources.
- Types of State:
  - Local State → Stored on your machine.
  - Remote State → Stored remotely (like S3, Terraform Cloud).
    - Remote state improves:
      - Security
      - Team collaboration
      - Reliability

#### Terraform Modules

- A module is a container for a set of related resources that are used together to perform a specific task. Defined using the `module` block

#### Terraform Provisioners

- Allow you to execute scripts or commands on infrastructure after it has been created, helping with post-deployment configuration.

#### Terraform Private Module Registry

- A secure repository for Terraform modules, accessible only to authorized users within an organization.
- It enables teams to manage, reuse, and distribute infrastructure code internally instead of relying on public registries.

---

### 3. Terrraform Commands

- `terraform --help` - Shows all available Terraform commands.
- `terraform init` - Prepares your directory to run other Terraform commands. Downloads providers, Downloads modules, Initializes backend, Creates .terraform folder
- `terraform init -migrate-state` is used when you change the backend configuration (where Terraform stores the state file). Move (migrate) the existing state file to the new backend.
- `terraform validate` - Checks if your configuration is syntactically correct. It does NOT check cloud resources.
- `terraform plan` - Shows what changes will be made to your infrastructure.
- `terraform apply` - Executes the changes to create or modify your infrastructure.
- `terraform destroy` - Deletes the infrastructure that was previously created.
- `terraform import` - Imports an existing resource into the Terraform state, It only updates state, You must write resource code manually.
- `terraform output` - Shows output variable values.
- `terraform fmt` - formate terraform files
- `terraform providers` - List terraform providers
- `terraform console` - Opens an interactive console for evaluating expressions in the Terraform configuration.
- `terraform refresh` - Updates state file to match real infrastructure. In modern Terraform, refresh happens automatically during plan and apply.
- `terraform show` - Displays details of the state or plan file.
- `terraform state list/show/pull/push` --> `terraform state pull` > ./assets/backend.tfstate
- `terraform taint` - Mark resources as tainted, recreate tainted resource when ever terraform apply command runs
- `terraform graph` - Shows dependency graph of resources, `terraform graph | dot -Tpdf > graph.pdf`
- `terraform force-unlock <LOCK_ID>` - Force state release

---

### 4. Variable

Variables are used to make Terraform code flexible and reusable.

#### Defining veriable

```hcl
variable "variable_name" {
  description = "Variable Description "
  default = "default_value"
  type = " " # Variable data type: string, number, bool, list(string), list(number), list(Object), map(string) etc.
}
```

#### Invoking variable

- var.variable_name
- `${var.variable_name}`-->old way

#### Ways to Pass Variable Values

1. Command Line: `terraform apply -var 'variable1_name=value' -var 'variable2_name=value'` --> "passing value as command line arugment"
2. Using `.tfvars` File
   - Using `terraform.tfvars` File: `terraform apply`
   - Using `custom named .tfvars` File: `terraform apply -var-file="custom_name.tfvars"`  --> If .tfvars file is named other the terraform.tfvars
3. Environment Variable: `export TF_VAR_name=value`
4. Set Default values in variable block

#### Variable Priority (Highest → Lowest)

1. Command line `-var`
2. `-var-file=custom_name.tfvars`
3. terraform.tfvars
4. Environment variable
5. Default value in variable block

---

### 5. Outputs

Outputs are used to display useful information after Terraform creates infrastructure.

```hcl
outpute "output_name" {
  value = aws_instance.web_server.public_ip
}
```

#### How to View Outputs

- After running: `terraform apply` Terraform will automatically show outputs.
- You can also run: `terraform output`
- To get a specific output: `terraform output public_ip`

**Output in Modules:**

*Inside child module you define:*

```hcl
output "instance_ip" {
  value = aws_instance.web.public_ip
}
```

*In root module:*

```hcl
output "server_ip" {
  value = module.module_name.instance_ip
}
```

This allows modules to return values.

---

### 6. Resource referring in Terraform

Resource referencing means using one resource’s value inside another resource.

- In Terraform, you can refer to resources and their attributes using expressions with the syntax:
  - `<RESOURCE_TYPE>.<RESOURCE_NAME>.<ATTRIBUTE>`
- Referencing with Variables: `instance_type` = `var.instance_type`
- Referencing Module Outputs: `module.<MODULE_NAME>.<OUTPUT_NAME>`
- Data Source Reference Format: `data.<TYPE>.<NAME>.<ATTRIBUTE>`
- Self reference: Any resource refering to it's own attribute is accessed using `self.<attribute_name>` syntax.

#### When to Use `depends_on`

Terraform usually handles dependencies automatically. But if you need to define dependency explicitly you can use `depends_on` keyword.
Like we defined in `NAT Gateway` that it `depends_on: Internet_Gateway_name`

---

### 7. Data Source

A Data Source in Terraform is used to get information about something that already exists.
**Important:**

- `resource` → Creates something new
- `data` → Reads something that already exists
- Data sources do NOT create resources.
- They only fetch information.

#### Why We Use Data Sources

- Use existing VPC
- Get latest AMI
- Read existing Security Group
- Use existing IAM role
- Connect new resources with old infrastructure
  
#### Basic Syntax

```hcl
data "<PROVIDER_RESOURCE_TYPE>" "<NAME>" {
   # arguments to search/filter
}
```

**Data Source Reference Format:** `data.<TYPE>.<NAME>.<ATTRIBUTE>`

### 8. Terraform Workspace

A workspace in Terraform is used to manage multiple environments using the same code.
It mainly changes the state file. Each workspace has its own state.

#### Workspace Commands

- `terraform workspace list`   # List Workspaces
- `terraform workspace show`  # Show the name of the current workspace
- `terraform workspace new workspace_name`  # Create a new workspace
- `terraform workspace delete workspace_name`  # Delete a workspace, can't delete default workspace, can't delete current workspace.
- `terraform workspace select workspace_name`  # Select a workspace

---

### 9. Terraform Modules

In Terraform, A module in Terraform is a group of related resources, that are used together to perform a specific task.
Think of a module like a function in programming. Modules allow users to organize and reuse their infrastructure code,
Reduce duplication, making it easier to manage complex infrastructure deployments.

#### How to Call a Module

```hcl
module "name" {
  source = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
}
```

1. Modules are defined using the `module` block in Terraform configuration.
2. A module block takes the following arguments:
   - `source`: The source location of the module. This can be a local path or a URL.
   - `name`: The name of the module. This is used to reference the module in other parts of the configuration.
   - `version`: The version of the module to use. This is optional and can be used to specify a specific version of the module.
3. Inside a module block, users can define the resources that make up the module, as well as any input and output variables that the module exposes.
4. Input variables allow users to pass values into the module when it is called, and output variables allow the module to return values to the calling configuration.
5. Modules can be nested, allowing users to create complex infrastructure architectures using a hierarchical structure.
6. Modules can also be published and shared on the Terraform Registry, enabling users to reuse and extend the infrastructure code of others.

#### Types of Modules

##### 1️⃣ Root Module

Main folder where you run Terraform commands.

##### 2️⃣ Child Module

A separate folder called using module block.

#### Passing Variables to Module

Inside Child module

```hcl
variable "cidr_block" {
  type = string
}
```

Calling module

```hcl
module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
}
```

#### Getting Output from Module

**Inside Child module:**

```hcl
output "vpc_id" {
  value = aws_vpc.main.id
}
```

**In root module:**

```hcl
output "vpc_id" {
  value = module.vpc.vpc_id
}
```

#### Reference format

`module.<MODULE_NAME>.<OUTPUT_NAME>`

#### Module Sources

Modules can come from:

- Local path (./modules/vpc)
- GitHub repository
- Terraform Public Registry
- Terraform Private Registry (for organizations)

---

### 10. count, for_each and Dynamic Block in Terraform

#### count

Used to create multiple copies of a resource

When to Use count;

- When resources are almost identical.
- When you only need a number (like 3 servers).
- ⚠ Problem: If order changes, Terraform may recreate resources.

```hcl
resource "aws_instance" "web" {
  count         = 3
  ami           = "ami-123456"
  instance_type = "t2.micro"
}
```

Terraform creates 3 EC2 instances.

They are indexed like this:

- aws_instance.web[0]
- aws_instance.web[1]
- aws_instance.web[2]

#### for_each

Creates multiple resources using a **map (key value pair) or set of values**.

Better and safer than count in many cases

```hcl
variable "instances" {
  default = {
    web1 = "t2.micro"
    web2 = "t2.small"
  }
}
resource "aws_instance" "web" {
  for_each      = var.instances
  ami           = "ami-123456"
  instance_type = each.value
  tags = {
    Name = each.key
  }
}
```

##### *Can `for_each` Be Used with a List in Terraform?*

Yes — but not directly with a normal list.

- `for_each` works with: map, set of strings
- It does NOT directly support: list (because list can have duplicates and have order)
- But `for_each` needs: Unique keys, Stable identity

There are 2 way we can use `for_each` with list

1. **Convert List to Set using `toset()` function.**

```hcl
variable "names" {
  default = ["web1", "web2", "web3"]
}
resource "aws_instance" "web" {
  for_each = toset(var.names)
  ami      = "ami-123456"
  instance_type = "t2.micro"
  tags = {
    Name = each.value
  }
}
```

What happens?

- `toset()` Converts list → set
- Each value becomes a key
- No duplicate values allowed

2. **Alternative: Convert List to Map (More Powerful)**

```hcl
resource "aws_instance" "web" {
  for_each = { for name in var.names : name => name }
  ami           = "ami-123456"
  instance_type = "t2.micro"
  tags = {
    Name = each.key
  }
}
```

Now:

- Key = instance name
- Value = instance name

More stable and recommended for production.

#### Dynamic Block

Used when you need to generate nested blocks inside a resource. Example: Multiple security group ingress rules.

```hcl
variable "ports" {
  default = [80, 443, 8080]
}

resource "aws_security_group" "web_sg" {
  name = "web-sg"
  dynamic "ingress" {
    for_each = var.ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
```

---

### 11. Post-Deployment Configuration

`Terraform Provisioners` and `user_data` allow you to execute scripts or commands on infrastructure after it has been created, helping with post-deployment configuration.

**Commonly used with:**

- EC2 instances
- Launch Templates
- Auto Scaling Groups

**It is mostly used to:**

- Install packages
- Start services
- Configure applications

#### **user_data**

```bash
user_data = <<-EOF
  #!/bin/bash
  sudo apt update -y
  sudo apt intall nginx -y
  sudo systemctl start nginx
  sudo systemctl enable nginx
  sudo bash -c 'echo "<h1>Welcome to Terraform Web Server</h1>" > /var/www/html/index.html'
  EOF
```

Instead of writing long scripts inside Terraform file you can use External Script File:

- user_data = `file(${path.module}/user_data_script.sh)`
  - file() → Reads content of a file
  - ${path.module} → Current module directory
  - Keeps Terraform code clean

##### Important Notes

- user_data script is executed with root privileges, allowing it to make system-level changes.
- user_data runs only once when instance is created.
- If you change user_data, and do terraform apply.Terraform may not know what you changed and will say desired infrastructureis already created, so you may need to mark that resource tainted so terraform recreate the resource on next apply, so the configuration changes are applied.
- Used for basic setup, not heavy configuration.
- For complex configuration, use: Ansible, Chef, Puppet

#### Provisioners

##### connection block

Connection block in provisioners define how to connect to host server.

Can be defined inside or outside provisioner block.

```hcl
connection {
  type        = "ssh"
  user        = "ubuntu"
  private_key = file("${path.module}/assets/id_rsa")
  host        = self.public_ip # Any resource refering to it's own attribute is accessed using `self.<attribute_name>` syntax.
  }
```

##### provisioner block

`provisioner "<TYPE>"`--> file, local-exec, remote-exec

###### **file**

Copies files or directories from the machine where Terraform is running to the new resource.

Examples:

```hcl
provisioner "file" {
  source      = "${path.module}/assets/user_data_script.sh"
  destination = "/home/ubuntu/user_data_script.sh"
}
provisioner "file" {
  content     = "#!/bin/bash\nsudo apt update -y\nsudo apt install nginx -y\nsudo systemctl start nginx\nsudo bash -c 'echo \"<h1>Welcome Web Server are you nginx</h1>\" > /var/www/html/index.nginx-debian.html'"
  destination = "/home/ubuntu/user_data.sh"
}
```

###### **local-exec**

- Invokes an executable on the local machine after Terraform creates the resource.
- This is useful for running scripts or commands that need to be executed on the machine where Terraform is running, such as:
  - Storing details of created resource in a file
  - Setting permissions
  - Triggering other local processes (triggering CI/CD pipeline, run ansible playbook).

**Examples:**

```hcl
provisioner "local-exec" {
  working_dir = path.module                # Specifies the working directory for the command. 
  interpreter = ["/usr/bin/python3", "-c"] # Specifies the interpreter to use for executing the command. 
  command     = "print('Instance created with public IP: ${self.public_ip}')"
}


provisioner "local-exec" {
  # Specifies that this provisioner should run during the destroy phase of the resource lifecycle. By default it runs on creation.
  when    = destroy

  command = "echo 'Instance with public IP ${self.public_ip} is being destroyed'"


  # By default, if a provisioner fails, Terraform will halt the execution and mark the resource as tainted, which means it will be destroyed and recreated in the next apply. However, you can change this behavior by using the on_failure argument.
  on_failure = continue # Specifies that if the command fails, Terraform should continue the execution.
}
```

###### remote-exec

- Executes commands on the newly created resource after it's provisioned.
- This is useful for performing post-deployment configuration, such as installing software, configuring services, or running any necessary setup commands on the instance itself.
- The commands are executed over SSH, and you can specify the connection details (like user, private key, etc.) to connect to the instance in connection block.

```hcl
provisioner "remote-exec" {
  # The inline argument allows you to specify a list of commands strings that will be executed sequentially on the remote instance.
  inline = [
    "sudo apt update -y",
    "sudo apt install nginx -y",
    "sudo systemctl start nginx",
    "sudo bash -c 'echo \"<h1>Welcome Web Server are you nginx</h1>\" > /var/www/html/index.nginx-debian.html'"
  ]
}

provisioner "remote-exec" {
  # The script argument allows you to specify a path (absolute or relative) to a script file that will be executed on the remote instance.
  script = "./assets/user_data_script.sh"
}
```
