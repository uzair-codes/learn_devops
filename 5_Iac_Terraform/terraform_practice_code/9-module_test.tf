
# module "web_server" {
#   source        = "../modules/webserver"
#   pub_key       = file("${path.module}/assets/id_rsa.pub")
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = var.instance_type
#   key_name      = "webserver_key"
# }

