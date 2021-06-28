module "vpc" {
  source = "git::ssh://git@github.com/reactiveops/terraform-vpc.git?ref=v5.0.1"

  aws_region = "us-west-1"
  az_count   = 2
  aws_azs    = "us-west-1b, us-west-1c"

  global_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

module "eks" {
  source       = "git::https://github.com/terraform-aws-modules/terraform-aws-eks.git?ref=v17.1.0"
  cluster_name = var.cluster_name
  cluster_version = "1.16"
  vpc_id       = module.vpc.aws_vpc_id
  subnets      = module.vpc.aws_subnet_private_prod_ids

  node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 3
      min_capaicty     = 1
      instance_type = "t2.small"
    }
  }

  manage_aws_auth = false
}
