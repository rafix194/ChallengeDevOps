resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "VPC DNX Challenge"
  }

}

resource "aws_subnet" "public_subnet" {
    count = length(var.public_subnet_cidrs)
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_cidrs
    availability_zone = var.azs
    tags = {
      Name = "Public Subnet"
    }
  
}

resource "aws_subnet" "private_subnet" {
    count = length(var.private_subnet_cidrs)
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnet_cidrs
    availability_zone = var.azs
    tags = {
      Name = "Private Subnet"
    }
  
}

resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.main
    tags = {
      Name = "Gateway DNX Challenge"
    }
}

resource "aws_route_table" "second_rt" {
    vpc_id = aws_vpc.main.id

    route = {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw.id
    }
    tags = {
      Name = "2nd Route Table"
    }
}

resource "aws_route_table_association" "public_subnet_asso" {
    count = var.public_subnet_cidrs
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.second_rt.id
}