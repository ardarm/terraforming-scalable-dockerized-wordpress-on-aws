# High-Availability Wordpress on AWS & Docker

_Building wordpress site on AWS using terraform and Docker container_


Pre-requisite to run the script :
- Install Terraform
- Internet Connection
- AWS Account

Clone my whole project folder and put terraform.exe file into every step folder(1-6). Enter the directory in sequence from 1 to 6. To execute the script, first run command "terraform init", followed by "terraform apply". If you want to see the change before execute, you can execute command "terraform plan". After every "terraform apply" command, dont'forget to copy terraform.tfstate file to the next folder. For example, you execute in folder step-1, then after completed, copy terraform.tfstate file to folder step-2. Execute terraform in folder 2, then after complete, copy terraform.tfstate file from folder step-2 to folder step-3 and so on until folder step-6.


**Step-1**
----------
In this section, we created base VPC for the website.

Components created
- VPC
- Security Groups
- Subnets
- NAT & Internet Gateway
- Routing Tables

For the DNS, you can user route53 or another DNS Record service like cloudflare(i'm using it).

**Step-2**
-------------
In this section, our main purpose is to create EC2 and RDS

Components created :
- EC2-Instance(with wordpress container pointing connection to RDS)
- RDS 

After the process completed, login to your AWS account, go to EC2 menu then copy your EC2 public IP adrress or Public DNS to your choosen DNS record service. Put your domain name to pointing to the IP Address. Try to access your domain name from browser. You can see the wordpress page showing on your browser. Since this is just one instance, we will destroy this instance in the next step and deploy the instance via Auto-Scaling in the step-4.

**Step-3**
----------
Since we will deploy minimum 2 instance for High-Availability purpose, file storage will be needed here to store files like javascript, CSS, and images. We will use Amazon EFS here for storing the static files.

Component created :
- EFS
- Add additional Security Group for EFS

After completed, you will see the EC2-Instance destroyed because we're not included the EC2 script in this step, but in the next step, we will deploy it again via Auto-Scaling.

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
