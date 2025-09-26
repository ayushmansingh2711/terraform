terraform {
  required_providers {
    aws = {                 # can use any type of provider as - abc 
      source = "hashicorp/aws"
      version = "6.14.1"
    }
  }
}

provider "aws" {
    region = var.region  # region
}
resource "aws_instance" "myserver" {    # resource type and name  ec2 
  ami = "ami-01b6d88af12965bb6"
  instance_type = "t2.micro"
}