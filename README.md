# High-Availability Wordpress on Docker

_Building wordpress site in AWS with terraform and Docker container_


**1. Setup VPC**

Clone my folder step-1 on your terraform directory. Edit the file based on your aws credential account and needs, then run command "terraform init" followed by "terraform apply".

Components created
- VPC
- DNS
- Security Groups
- Subnets
- NAT
- Internet Gateway
- Routing Tables

Prepare your name and change nameservers after completed.

**2. Create instance and database**

Clone my folder step-2 on your terraform directory. make changes according to your environment, then run command "terraform init", followed by "terraform apply".

In this section, our activity is :
- Create RDS
- Create EC2
- Add DNS record to Route53
- Mount EFS on start and assign it to docker
- Update ELB DNS record Route53
- Define Auto-Scaling Group

**3. Redundancy**

Clone my folder step-3 on your terraform directory. edit .tf file according your environment, then run command "terraform init", followed by "terraform apply".

In this section, our activity is :
- Create EFS to store static content such as images, css, and javascript.
- Add Security group for EFS
- Create ELB to routing traffic

**4.Auto-scalling Policy**

- Again, move all the step-3 files, prepare the step-4 files, then execute "terraform init" and "terraform apply"
- If CPU reach 80% load, then autoscalling will ad 2 extra nodes
- we can use stress to give load to cpu. Please ssh to one of the server, the execute
  command : apt-get install stress
            stress -c 90
            
 **5.Final Words**
 
 Finally looking through the challenge and solution, i realized many flaws in the build-up process and result, but i tried my best to provide my answer to the challenge. This is a basic challenging case, which is actually i enjoy and will be my walkthrough to the Cloud Native path.
 
THANKS !
