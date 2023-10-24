variable "cidr_block" {
    type = string
    default = "10.0.0.0/16"
    description = "CIDR block for the VPC"
  
}

variable "public_subnet_cidrs" {
    type = string
    default = "10.0.1.0/24" 
    description = "Public Subnet CIDR Values"
}

variable "private_subnet_cidrs" {
    type = string
    default = "10.0.2.0/24" 
    description = "Private Subnet CIDR Values"
}

variable "azs" {
    type = string
    description = "Availability Zones"
    default = "ap-southeast-2b"
}