# counter-service
This is a simple web server which counts the amount of POST requests it served, and return it on every GET request it gets


Repository stracture to help you find what you need
```bash
.
├── .github/workflows/
│   └── counter-ci.yaml     = Github actions CI job
│
├── argocd/
│   ├── my-apps.yaml        = Argocd app of apps manifest
│   ├── apps/               = Argocd apps manifest
│   ├── git-repos/          = Git repositories connected to argocd 
│   └── helm-charts/        = Helm charts for argocd to deploy
│
├── counter-service/
│   ├── counter-service.py  = counter-service application
│   └── Dockerfile          = Dockerfile for counter-service
│
└── terraform-eks/
    └── main.tf             = Main terraform file for deploying infrastructure
```
## Terraform - Key Points
- tfstate is saved in s3 bucket allowed by ip address
- Cluster autoscaler deployed
- Pod autoscaler deployed
- Argocd server deployed
- Aws LB controller deployed
- Ebs CSI controller deployed

## Counter Service - Key Points
- Created Dockerfile with slim base image
- Counter is saved in redis database, backed up by pvc
- Gets credentials with configMap
- Deployed using a custom helm chart

## Github Actions - Key Points
- Running on every commit to main branch
- Building and pushing new docker image to dockerhub with last commit SHA as tag
- Updates counter-service's helm chart image tag 

## ArgoCD - Key Points
- Being deployed with terraform
- Deploying apps by code
- Using app of apps
