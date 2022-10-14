# Terraform - Provision an EKS Cluster and setup Jenkins

Prerequisites
1. Require an AWS account
2. The AWS CLI, installed and configured
3. AWS IAM Authenticator should be present
4. The Kubernetes CLI, also known as kubectl should be installed on system
5. Helm cli should be installed on system

# Setup EKS cluster using terraform code:
1. creates VPC, subnets, Internetgateway and Nat gateway
2. Spins up EKS cluster with 3 nodes
3. Sets up security grouos for nodes and Eks cluster
4. creates IAM role and provides permission to it. Adds TLS certificates.
5. region update van be provided in variables.tf

## Below are the steps:
##### Clone the git repository
`git clone guusto`

`cd guusto`

##### Initialize, Plan and Apply terrform code


`terraform init`

`terraform apply`


#### Verify the Cluster

`aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)`

`kubectl cluster-info`

`kubectl get nodes`

##### Create a namespace "app"
`kubectl create ns app`

##### Deploy the merchants and shopping application using yaml files. the yaml files creates a service type ClusterIP, Deployments and configmap 

`cd deployments`

`kubectl create -f merchant.yaml`

`kubectl create -f shop-services.yaml`


To setup Kubernetes cluster refer link: https://learn.hashicorp.com/tutorials/terraform/eks

# To access the Merchant application follow below steps:

1. Validate if the deployment is running:
  kubectl -n app get deployments
  
2. Verify if the service is running:
   kubectl -n app get svc
   
3. The merchant service is using an loadbalancer and shopping service is using ClusterIP for internal access:
   merchant-service-lb   LoadBalancer   x.x.x.x   xxx.elb.amazonaws.com   80:30813/TCP   16h
   shop-service          ClusterIP      x.x.x.x   <none>                  80/TCP         18h

Access the service with loadbalancer URL http://<loadbalancerURL>/v1/merchants


