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
