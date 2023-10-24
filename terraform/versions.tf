terraform{
    required_version = ">= 0.14"
    required_providers {
      aws = {
        version = "~> 4.16.0"
        source = "hashicorp/aws"
      }
    }
}

provider "aws" {
    region = "ap-southeast-2"
  
}