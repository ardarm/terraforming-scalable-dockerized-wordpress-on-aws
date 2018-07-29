# High-Availability Wordpress on AWS & Docker

_Building wordpress site on AWS using terraform and Docker container_


Pre-requisite to run the script :
- Install Terraform
- Internet Connection
- AWS Account

Clone this project and put terraform.exe file into every step folder(1-6). Enter the directory in sequence from 1 to 6. To execute the script, first run command "terraform init", followed by "terraform apply". If you want to see the change before execute, you can execute command "terraform plan". After every "terraform apply" command, dont'forget to copy terraform.tfstate file to the next folder. For example, you execute in folder step-1, then after completed, copy terraform.tfstate file to folder step-2. Execute terraform in folder 2, then after complete, copy terraform.tfstate file from folder step-2 to folder step-3 and so on until folder step-6.


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

After completed, you will see the EC2-Instance is destroyed because we're not included the EC2 script in this step, but in the next step, we will deploy it again via Auto-Scaling.

**Step-4**
----------
In this step, we are back to deploy EC2-Instance, but this time we will launch 2 instance via Auto-Scaling and it will be ELB member. The EC2 will be mounted to EFS at /efs folder. Wordpress container will ber mounted to the /efs directory.

Components created :
- 2 EC2-Instance(with wordpress container inside)
- Elastic Load Balancer
- Auto-Scaling Group

After the process completed, login to your AWS account and click on the ELB menu to capture your ELB public DNS or you can copy it from terraform.tfstate file too. Paste it to your DNS Record(change the public IP/public DNS you have used before).

**Step-5**
----------
In this section, we will add Auto-Scaling policy, which is change in capacity to add 2 nodes if the CPU reach 80% beyond 4 minutes.

Components created :
- Auto-Scaling Policy to add 2 nodes.
- Cloudwatch metric alarm for high-CPU

**Step-6**
----------
Finally, we arrived at the last step of our journey to build scalable wordpress website. In this step, we will add Auto-Scaling policy, which is change in capacity to terminate 2 nodes if the CPU under 25% beyond 4 minutes(after high-cpu alarm).

Components created :
- Auto-Scaling Policy to terminate 2 nodes.
- Cloudwatch metric alarm for low-CPU

After the execute completed, we can test the scalability of our Wordpress site now. You can use tools like Artilery or Stress to test your website. In this tutorial we will use Stress to load-test the website. SSH to both of your instance, execute command "sudo apt-get install stress" and your tools is ready to be used. Simply execute command "stress -c 90" and wait until 4 minutes to let the Cloudwatch trigerring the High-CPU Auto-Scaling Policy. Login to your AWS Account and you can see 2 new nodes launched. After the nodes ready, terminate your Stress tool (press ctrl+c) and wait until 4 minutes to see your Cloudwatch trigerring Low-CPU Policy.
            
 **Final Words**
 
Finally, i realized many flaws in the build-up process. This is an interesting project on how to build simple high-scalable web-application infrastucture. I'm sure will keep update and improving the process.
