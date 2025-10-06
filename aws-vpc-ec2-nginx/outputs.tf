output "instance_public_ip" {
  value = aws_instance.nginx-server.public_ip
  description = " Public IP of the Nginx server"
  
}

output "instance_url" {
  value = "http://${aws_instance.nginx-server.public_ip}"
  description = "URL of the Nginx web server"
  
}