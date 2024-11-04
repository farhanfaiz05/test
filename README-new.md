
# Coding Challenge: Deploying a Web Server in AWS EKS

# Workflow
Once the code is pushed, the Github actions will apply the terraform code and provision the required AWS and AWS EKS resources. This code uses helm(using terraform) to deploy NGINX Ingress Controller for exposing the nginx service. The NGINX controller deploys an AWS Classic Load Balancer. "index.html" file is where the website contents are provided. Any changes to this file will automatically reflect on the url "interview.devops.g2.com". SSL is not configured for the domain as it requires domain valdiation.

# Pre-requisites
1. The terraform code uses S3 as backend to store the terraform statefile. S3 bucket name should be added in the backend.tf file before executing terraform apply. This code does not include code to create S3 bucket.
2. Github actions uses "g2-interview" as workspace for storing terraform statefile. This can be changed in ./github/workflows/deploy.yml if needed.
3. Name prefix for AWS and EKS resources is a variable mentioned in variables.tf file(g2-interview is hardcoded now). Any change to name prefix or region in the variables.tf file should also be made in github actions file(./github/workflows/deploy.yml) line 57. This is required to configure kubectl to connect to the correct EKS cluster.
4. The domain and index.html file is also configurable in variables.tf file.

# Output
The final stage in github actions is to get the Loadbalancer DNS. This is DNS to which the domain has to be pointed to view the webpage.

# Note
The Classic load balancer and the corresponding Network Interfaces has to be deleted manually before doing Terraform destroy as terraform state does not include these because these are created by the NGINX ingress controller.