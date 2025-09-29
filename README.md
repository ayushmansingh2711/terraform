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


## Random provider for random id name password name   

     Note - this is the link for random provider

    https://registry.terraform.io/providers/hashicorp/random/latest    


  ![alt text](image.png)


  ##  Terraform remote state Management 

   NOTE -  ec2 instance bna ke tf-file ko s3 ki help se manage krte hai  

Terrafoem ki tf-state vali file remotely s3 ki help se cloud me store krte h  jisse multiple people us file ko access krke kaam  kar sake 
   
   ![alt text](<Screenshot from 2025-09-29 18-00-15.png>)

    Note --  the file name is backend.tf 

   ![alt text](<Screenshot from 2025-09-29 18-00-57.png>)

 # Note -- Terraform.tfstate  me main.tf file ka sara data hota hai  jo bhi hm kaam krte h usme 
   

