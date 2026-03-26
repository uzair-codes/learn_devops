output "Bastion-Public-IP" {
  value = aws_instance.bastion_host.public_ip
}
output "alb-dns" {
  value = aws_lb.webserver_alb.dns_name
}
