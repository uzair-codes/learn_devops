variable "instance_type" {
  type = string
  default = "t3.micro"
}

variable "ports" {
  type = list(number)
  default = [22, 80, 443]
}

variable "key_name" {
  type = string
}

variable "num_of_instances" {
  type = number  
  default = 1
}