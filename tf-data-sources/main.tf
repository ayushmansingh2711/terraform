terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.15.0"
    }
  }
}

provider "aws" {
 region = "ap-south-1"

}

data "aws_ami" "name" {
  most_recent = true
  owners = ["amazon"]
}
output "aws_ami" {
  value = data.aws_ami.name.id
}

# security group
data "aws_security_group" "name" {
  tags = {
    Name = "all-traffic"
  }
}

output "aws_security_group" {
  value = data.aws_security_group.name.id
}

# vpc
data "aws_vpc" "name" {
   tags = {
     Name = "vpc"
   }
}

  output "name" {
    value = data.aws_vpc.name.id
  }

  #AZ
  data "aws_availability_zones" "names" {
    state = "available"
  }

  output "aws_availability_zones" {
    value = data.aws_availability_zones.names
  }
resource "aws_instance" "myserver" {    # resource type and name  ec2 
  # ami = "ami-01b6d88af12965bb6"
  ami = data.aws_ami.name.id
  instance_type = "t2.micro"
  
}