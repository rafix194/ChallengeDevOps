resource "aws_instance" "Ubuntu DNX Challenge" {
  ami                     = "ami-0c595b8bc24551ef4"
  instance_type           = "t2.micro"
  tenancy                 = "host"
  user_data = base64encode
}