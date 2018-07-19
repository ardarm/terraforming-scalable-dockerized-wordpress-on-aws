# k8s-wordpress

_Building wordpress site in AWS with terraform and Docker container_


**1. Setup VPC**

execute the script in this order
- vpc.tf (create vpc)
- route.tf (create routing table)
- security.tf (create security gateway)

Change nameservers after completed.

**2. Create instance and database**

execute the script in this order
- database.tf (create RDS)
- instance.tf (create instance)
- bootstrap.tpl (install docker community edition and wordpress)
- routeinstance.tf (add dns record)

**3. Redundancy**

execute the script in this order
- efs.tf (create elastic file system)
- efs_securitygroup.tf (add efs to the security group)
- elb.tf (create elastic load-balancer)
- elb_route.tf (adding elb to route53)
- autoscalling.tf (define auto-scalling group)

**4.Auto-scalling Policy**

- execute script autoscalling_policy.tf to change capacity
- If CPU reach 80% load, then autoscalling will ad 2 extra nodes
- we can use stress to give load to cpu
  command : apt-get install stress
            stress -c 90
            
 **5.Final Words**
 
 Finally looking through the challenge and solution, i realized many flaws in the build-up process and result, but i tried my best to provide my answer to the challenge. This is a basic challenging case, which is actually i enjoy and will be my walkthrough to the Cloud Native path.
 
THANKS !
