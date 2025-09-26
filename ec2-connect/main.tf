terraform {
  required_providers {
    aws = {                 # can use any type of provider as - abc 
      source = "hashicorp/aws"
      version = "6.14.1"
    }
  }
}

provider "aws" {
    region = "ap-south-1"   # region
}
resource "aws_instance" "myserver" {    # resource type and name  ec2 
  ami = "ami-02d26659fd82cf299"
  instance_type = "t2.micro"
}