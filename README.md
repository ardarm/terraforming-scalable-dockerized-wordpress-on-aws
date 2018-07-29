# High-Availability Wordpress on AWS & Docker

_Building wordpress site on AWS using terraform and Docker container_


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

Clone my folder step-4 on your terraform directory. modify the files based your environment, then run command "terraform init", followed by "terraform apply".

In this section our activity is :
- Adding new policies to the auto-scalling group 
- If CPU reach 80% load, then autoscalling will ad 2 extra nodes
- we can use stress to give load to cpu. Please ssh to one of the server, the execute
  command : apt-get install stress
            stress -c 90
- Login to your AWS account to make sure new additional nodes created to handle the load stress.
- Stop the stress tools and check again if the new nodes terminates after the load stress down.
            
 **5.Final Words**
 
Finally i realized many flaws in the build-up process and result. This is an interesting project on how to build high-scalable web-application infrastucture. I'm sure will keep update and improving many aspect of this project.
