variable "instance_type" {
  type = string
  default = "t3.micro"
}

variable "image_name" {
  type = list(string)
}

variable "ports" {
  type = list(number)
  default = [22, 80, 443]

}

variable "ports" {
  type = map(number)
  default = {
    "ssh" = 22
    "http" = 80
    "https" = 443
  }
}
