resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.ssh_keygen.key_name
  vpc_security_group_ids = [aws_security_group.ssh_access.id]
  tags = {
    Name = "Web Server"
  }

# Post-Deployment Configuration using user_data script and provisioners to execute commands on the instance after it's created.
# user_data: 
#A script that runs during the instance's initialization phase. 
# This is typically used to install software, configure settings, or perform any setup tasks required for the instance to function as intended. 
# The script is executed with root privileges, allowing it to make system-level changes.
user_data = file("${path.module}/assets/user_data_script.sh")

# Provisioners
connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${path.module}/assets/id_rsa")
    host        = self.public_ip # Any resource refering to it's own attribute is accessed using self.<attribute_name> syntax.
  }

# provisioner "<TYPE>" --> file, local-exec, remote-exec
# file: 
# Copies files or directories from the machine where Terraform is running to the new resource.
provisioner "file" {
  source      = "${path.module}/assets/user_data_script.sh"
  destination = "/home/ubuntu/user_data_script.sh"
}
provisioner "file" {
  content     = "#!/bin/bash\nsudo apt update -y\nsudo apt install nginx -y\nsudo systemctl start nginx\nsudo bash -c 'echo \"<h1>Welcome Web Server are you nginx</h1>\" > /var/www/html/index.nginx-debian.html'"
  destination = "/home/ubuntu/user_data.sh"
}


# local-exec: 
# Invokes an executable on the local machine after Terraform creates the resource. 
# This is useful for running scripts or commands that need to be executed on the machine where Terraform is running,
# such as storing details of created resource in a file, setting permissions or triggering other local processes (tregring CI/CD pipeline, run ansible playbook).
provisioner "local-exec" {
  working_dir = path.module                # Specifies the working directory for the command. 
  interpreter = ["/usr/bin/python3", "-c"] # Specifies the interpreter to use for executing the command. 
  command     = "print('Instance created with public IP: ${self.public_ip}')"
}
provisioner "local-exec" {
  when    = destroy # Specifies that this provisioner should run during the destroy phase of the resource lifecycle.
  command = "echo 'Instance with public IP ${self.public_ip} is being destroyed'"

# By default, if a provisioner fails, Terraform will halt the execution and mark the resource as tainted, which means it will be destroyed and recreated in the next apply.
# However, you can change this behavior by using the on_failure argument.
  on_failure = continue # Specifies that if the command fails, Terraform should continue the execution.
}

# remote-exec: Executes commands on the newly created resource after it's provisioned. 
# This is useful for performing post-deployment configuration, such as installing software, configuring services, or running any necessary setup commands on the instance itself. 
# The commands are executed over SSH, and you can specify the connection details (like user, private key, etc.) to connect to the instance.
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
}