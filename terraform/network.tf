resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "VPC DNX Challenge"
  }

}

resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.main.id
    tags = {
      Name = "Gateway DNX Challenge"
    }
}

resource "aws_subnet" "public_subnet" {
    count = length(var.public_subnet_cidrs)
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_cidrs[count.index]
    availability_zone = var.azs[count.index]
    tags = {
      Name = "Public Subnet"
    }
  
}

resource "aws_subnet" "private_subnet" {
    count = length(var.private_subnet_cidrs)
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnet_cidrs[count.index]
    availability_zone = var.azs[count.index]
    tags = {
      Name = "Private Subnet"
    }
  
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.main.id
    tags = {
      Name = "Challenge Public Route Table"
    }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_route_table_association" "public_subnet_asso" {
    count = length(var.public_subnet_cidrs)
    subnet_id = aws_subnet.public_subnet[count.index].id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.main.id
    tags = {
      Name = "Challenge Private Route Table"
    }
}

resource "aws_route" "private" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.default.id
}

resource "aws_route_table_association" "private_subnet_asso" {
    count = length(var.private_subnet_cidrs)
    subnet_id = aws_subnet.private_subnet[count.index].id
    route_table_id = aws_route_table.private_rt.id
}

resource "aws_eip" "nat" {
  vpc   = true
}

resource "aws_nat_gateway" "default" {
  depends_on = [aws_internet_gateway.gw]


  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet[0].id
}