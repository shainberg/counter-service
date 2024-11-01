provider "aws" {
  region = var.region
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.65.0"
    }
     helm = {
      source = "hashicorp/helm"
      version = "2.15.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "tfstate-s3-eilon-task" 
    key    = "terraform/state/terraform.tfstate"
    region = "eu-west-1"
  }
}


# Data for Helm Provider
data "aws_eks_cluster" "eks" {
  name = aws_eks_cluster.eks.name
}

data "aws_eks_cluster_auth" "eks" {
  name = aws_eks_cluster.eks.name
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}