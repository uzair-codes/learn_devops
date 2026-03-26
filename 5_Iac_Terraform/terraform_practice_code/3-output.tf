
# Output from resource <value = resource_type.resource_name.attribute>
output "public_ip" {
  description = "The public IP address of the web server"
  value       = aws_instance.web.public_ip
}

# Output from data source <value = data.data_source_type.data_source_name.attribute>
output "ami_id" {
  value = data.aws_ami.ubuntu.id
}

# Output from module <value = module.moule_name.attribue>
output "web_server_public_ip" {
  value = module.web_server.publicIp
}