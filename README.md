# Terraform Project

This repository contains Terraform code for AWS infrastructure.

## Usage
1. Run `terraform init`
2. Run `terraform plan`
3. Run `terraform apply`

##

  Note ` if you have not default vpc in your aws then run this cammond `

  Run ` aws ec2 create-default-vpc --region ap-south-1 `

   ![alt text](<Screenshot from 2025-09-26 15-53-27.png>)

### 
  If you want to destory  your resouce 
  
  Run `terraform destory `

  ![alt text](<Screenshot from 2025-09-26 16-19-37.png>)



  ## terraform outputs 

     It is for the instance phblic ip 

     output "aws_instance_public_ip" {
    value = aws_instance.myserver.public_ip
  
     }

Note - myserver is the name of resource   ---   ( main.tf )






 ## How to create s3 bucket 


![alt text](<Screenshot from 2025-09-29 16-21-24.png>)

     Note -- source ../.env 
          terraform init 
          terraform validate 
          terraform plan 
          terraform apply   
