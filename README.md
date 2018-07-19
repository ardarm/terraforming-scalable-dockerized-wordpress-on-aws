# k8s-wordpress

1. Setup VPC

execute the terraform script in this order
- vpc.tf (create vpc)
- route.tf (create routing table)
- security.tf (create security gateway)

Change nameservers after completed.

2. Create instance and database

execute the terraform script in this order
- database.tf (create RDS)
- instance.tf (create instance)
- routeinstance.tf (add dns record)

3. Redundancy
