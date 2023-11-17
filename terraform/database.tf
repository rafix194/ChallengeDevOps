resource "aws_security_group" "rds-in" {
  name   = "challenge - RDS"
  vpc_id = aws_vpc.main.id


  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = aws_subnet.private_subnet.*.id

  tags = {
    Name = "My DB subnet group"
  }
}


resource "aws_db_instance" "mysql" {
  identifier             = "mysql"
  engine                 = "mysql"
  engine_version         = "8.0.33"
  instance_class         = "db.t2.micro"
  allocated_storage      = 5
  name                   = "homestead"
  username               = "homestead"
  password               = "secret01"
  port                   = "3306"
  db_subnet_group_name   = aws_db_subnet_group.default.id
  deletion_protection    = false
  vpc_security_group_ids = [aws_security_group.rds-in.id]
  skip_final_snapshot    = true
}