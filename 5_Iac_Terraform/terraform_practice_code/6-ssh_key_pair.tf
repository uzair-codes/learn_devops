# Manually Creating SSH Key Pair
# path.module is used to get the path of the current module "creating_ssh_key.tf" file.
# path.module --> /home/uzair/devops/terraform-projects/learndevops/terraform
resource "aws_key_pair" "ssh_keygen" {
  key_name   = "ssh-key"
  public_key = file("${path.module}/assets/id_rsa.pub")
}
