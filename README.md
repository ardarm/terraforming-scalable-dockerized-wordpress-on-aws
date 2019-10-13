# Building High-Availability Scalable Wordpress on AWS with Terraform & Docker Container

_Building Wordpress site on AWS using terraform and Docker container_


Pre-requisite to run the script :
- Internet Connection
- Terraform
- AWS Account
- AWS-CLI

Clone this project and choose whether you want to deploy this into ASG(Autoscalling Group) or you need just 1 instance without ASG. ASG folder for the first choice and Non-ASG folder for second choice.

Command : terraform init && terraform apply


**Non-ASG**
----------
In this section, we created base VPC, EC2 and RDS for our website.

Components created
- VPC
- Security Groups
- Subnets
- NAT & Internet Gateway
- Routing Tables
- EC2-Instance(with wordpress container pointing connection to RDS)
- RDS 

For the DNS, you can user route53 or another DNS Record service like Cloudflare.


**ASG**
----------
Components created :

First, we create base Networking VPC and RDS
- VPC
- Security Groups
- Subnets
- NAT & Internet Gateway
- Routing Tables
- RDS

Since we will deploy minimum 2 instance for High-Availability purpose, file storage will be needed here to store files like javascript, CSS, and images. We will use Amazon EFS here for storing the static files.
- EFS
- Add additional Security Group for EFS

Launch 2 instance via Auto-Scaling and it will be ELB member. The EC2 will be mounted to EFS at /efs folder. Wordpress container will ber mounted to the /efs directory.
- 2 EC2-Instance(with wordpress container inside)
- Elastic Load Balancer
- Auto-Scaling Group

Add Auto-Scaling policy, which is change in capacity to add 2 nodes if the CPU reach 80% beyond 4 minutes and terminate 2 nodes if the CPU under 25% beyond 4 minutes(after high-cpu alarm).
- Auto-Scaling Policy to add 2 nodes.
- Cloudwatch metric alarm for high-CPU
- Auto-Scaling Policy to terminate 2 nodes
- Cloudwatch metric alarm for low-CPU

After the execute completed, we can test the scalability of our Wordpress site now. You can use tools like Artilery or Stress to test your website. In this tutorial we will use Stress to load-test the website. SSH to your instance, then execute command "sudo apt-get install stress". Your tools is ready to be used by simply execute command "stress -c 90" and wait until 4 minutes to let the Cloudwatch trigerring the High-CPU Auto-Scaling Policy. Login to your AWS Account and you can see a new instance launched. After the instance ready, terminate your Stress-test (press ctrl+c) and wait until 4 minutes to see your Cloudwatch trigerring Low-CPU Policy.
            
 **Final Words**
 ---------------
Finally, i realized there is still some flaws in the build-up process. This is an interesting project on how to build simple high-scalable web-application infrastucture and i'm sure will keep update and improving the process.
