variable "cidr_block" {
    type = string
    default = "10.0.0.0/16"
    description = "CIDR block for the VPC"
  
}

variable "public_subnet_cidrs" {
    type = list(string)
    default = ["10.0.1.0/24", "10.0.2.0/24"] 
    description = "Public Subnet CIDR Values"
}

variable "private_subnet_cidrs" {
    type = list(string)
    default = ["10.0.3.0/24", "10.0.4.0/24"]
    description = "Private Subnet CIDR Values"
}

variable "azs" {
    type    = list(string)
    description = "Availability Zones"
    default = ["ap-southeast-2a", "ap-southeast-2b"]
}

variable "amis" {
  type = map(string)

  default = {
    "ap-southeast-2" = "ami-01df5ddccb0612987"
  }
}