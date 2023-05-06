# terraform-vpc
Terraform IAC! 

It creates; 
* 1 VPC, 
* 2 public subnet,1 private subnet
* 1 Internet Gateway, 1 NAT
* 1 Security Group
* 1 EC2 
* 1 ALB 

Prerequiste :
- Add the keys for the aws command 
- install terraform

After cloning the repo, just run these 3 commands

```
ssh-keygen -f key-pair
terraform init
terraform plan 
terraform apply

