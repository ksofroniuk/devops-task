Task 1  
- [fixed ingress cidr block](terraform/network.tf#L66) from 0.0.0.0/24 to 0.0.0.0/0  
- [fixed security group port 80](terraform/network.tf#L91)  
- added [ec2.tf](ec2.tf), added new subnet in [network.tf](terraform/network.tf#L31)  

Task 2  
- run docker container with same image as recngx01 had running  

Task 3  
- added ALB in [lb.tf](terraform/lb.tf)  

Task 4  
- run [custom docker image](terraform/vm-init.sh#L19) on both servers that show container hostname on webpage, the hostname value was replaced with the ip of ec2 (from docker host)

<br>
<br>

Bonus task 1  
- terraform code is under [/terraform](terraform/)  

Bonus task 2  
- added [action.yaml](.github/workflows/action.yaml), workflow that build and push docker image with desired nginx configuration then perform rolling update of kubernetes deployment  

Bonus task 3  
- added [eks.tf](terraform/eks.tf), used community terraform-aws-modules

Bonus task 4  
- added [alert.tf](terraform/alert.tf), using aws native monitoring solution - CloudWatch, alarm set to look for unhealty host count of ALB target group from task 4, it send email as an action if unhealthy instance found  