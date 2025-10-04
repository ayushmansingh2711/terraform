terraform {
  required_providers {
    aws = {                 # can use any type of provider as - abc 
      source = "hashicorp/aws"
      version = "6.14.1"
    }
  }
}

provider "aws" {
    region = "ap-south-1"  # region
}

# Create VPC
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-vpc"
  }
}

# private subnet

resource "aws_subnet" "private-subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "private-subnet"
  }
}

# public subnet

resource "aws_subnet" "public-subnet" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "public-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "my-ig" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "my-ig"  
}

}
# Route Table
resource "aws_route_table" "my-route-table" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-ig.id
  }
}

resource "aws_route_table_association" "public-sub" {
  route_table_id = aws_route_table.my-route-table.id
  subnet_id = aws_subnet.public-subnet.id
}
 
  # Create EC2 instance in public subnet
resource "aws_instance" "myserver" {    # resource type and name  ec2 
  ami = "ami-01b6d88af12965bb6"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public-subnet.id
  tags = {
    Name = "myserver"
    }
}