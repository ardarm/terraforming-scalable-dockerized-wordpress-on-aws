# k8s-wordpress

_Building wordpress site in AWS with terraform and Docker container_


**1. Setup VPC**

Create tf configuration file like in the folder step-1, then run "terraform init" followed by "terraform apply"

Change nameservers after completed.

**2. Create instance and database**

After execute configuration in the step-1, move all the files to another directory outside the terraform folder. Prepare step-2 files, then you can execute "teraform init" then "terraform apply"

**3. Redundancy**

Move all the step-2 file to the outside terraform directory. Prepare all the step-3 configuration then you can execute "terraform init", then "terraform apply"

**4.Auto-scalling Policy**

- Again, move all the step-3 files, prepare the step-4 files, then execute "terraform init" and "terraform apply"
- If CPU reach 80% load, then autoscalling will ad 2 extra nodes
- we can use stress to give load to cpu. Please ssh to one of the server, the execute
  command : apt-get install stress
            stress -c 90
            
 **5.Final Words**
 
 Finally looking through the challenge and solution, i realized many flaws in the build-up process and result, but i tried my best to provide my answer to the challenge. This is a basic challenging case, which is actually i enjoy and will be my walkthrough to the Cloud Native path.
 
THANKS !
