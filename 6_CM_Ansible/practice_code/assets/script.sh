#!/bin/bash

# user_data are executed with root privilages so no need to add sudo
apt update -y
apt install nginx -y
systemctl enable nginx
systemctl start nginx