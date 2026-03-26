# EC2 resource uses count to create multiple instances.
# When you use count, Terraform creates:
  # aws_instance.server[0]
  # aws_instance.server[1]
  # aws_instance.server[2]

## Output All IPs
output "public_ip" {
  value = aws_instance.server[*].public_ip
}

## Output a Specific Instance
# output "first_instance_public_ip" {
#   value = aws_instance.server[0].public_ip
# }

## Output Map With Names
# output "public_ips" {
#   value = {
#     for instance in aws_instance.server :
#     instance.id => instance.public_ip
#   }
# }
### Example Output:
# {
#   "i-0123": "3.110.25.10",
#   "i-0456": "13.233.40.20"
# }