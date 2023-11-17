# resource "aws_instance" "ubuntu_dnx_challenge" {
#   ami                     = "ami-0df4b2961410d4cff"
#   instance_type           = "t2.micro"
#   subnet_id = aws_subnet.private_subnet[0].id
#   user_data = <<EOF
#   #!/bin/bash
#   git clone https://github.com/DNXLabs/ChallengeDevOps.git
#   cd ChallengeDevOps
#   cp .env.example .env
#   sudo add-apt-repository ppa:ondrej/php
#   sudo apt update -y
#   sudo apt upgrade -y
#   sudo apt install -y php7.4
#   sudo apt-get install php-mbstring php7.4-mbstring -y
#   sudo apt install php7.4-xml
#   sudo apt install php7.4-mysql
#   curl -sS https://getcomposer.org/installer -o composer-setup.php
#   sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
#   composer dump-autoload
#   composer install
#   php artisan key:generate
#   php artisan jwt:generate
#   php artisan migrate
#   php artisan db:seed
#   php artisan migrate:refresh
#   php artisan serve --host=0.0.0.0
#   EOF
#   iam_instance_profile {
#     name = aws_iam_instance_profile.role_ssm_profile.name
#   }
# }

# resource "aws_security_group" "bastian-ssh" {
#   name   = "Bastian host"
#   vpc_id = aws_vpc.default.id

#   ingress {
#     # TLS (change to whatever ports you need)
#     from_port = 22
#     to_port   = 22
#     protocol  = "tcp"

#     # Please restrict your ingress to only necessary IPs and ports.
#     # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     # TLS (change to whatever ports you need)
#     from_port = 80
#     to_port   = 80
#     protocol  = "tcp"

#     # Please restrict your ingress to only necessary IPs and ports.
#     # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = -1
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }


# resource "aws_launch_template" "ec2challenge" {
#   name = "Template Challenge"

#   block_device_mappings {
#     device_name = "/dev/xvda"

#     ebs {
#       volume_size = 10
#     }
#   }

#    disable_api_termination = false
#   image_id                = var.amis["ap-southeast-2"]
#   instance_type           = "t2.micro"
#   key_name                = var.key_name
#   vpc_security_group_ids  = [aws_security_group..id, aws_security_group.bastian-ssh.id]
#   user_data               = base64encode(file("files/userdata.sh"))
#   iam_instance_profile {
#     name = aws_iam_instance_profile.role_ssm_profile.name
#   }