resource "aws_instance" "nginx-server" {    # resource type and name  ec2 
  ami = "ami-01b6d88af12965bb6"
  instance_type = "t3.micro"
    subnet_id = aws_subnet.public-subnet.id
    vpc_security_group_ids = [aws_security_group.nginx-sg.id]
    associate_public_ip_address = true


    user_data = <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install -y nginx
                sudo systemctl start nginx
                EOF
    tags = {
      Name = "nginx-server"
    }
}