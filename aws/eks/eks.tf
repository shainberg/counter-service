data "aws_eks_cluster" "cluster" {
  name = module.my-cluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.my-cluster.cluster_id
}


data "aws_vpc" "selected" {
  filter {
    name = "tag:Name"
    values = ["ckp-vpc"]
  }
}

data "aws_subnet" "ckp-subnet-public-1" {
  vpc_id = data.aws_vpc.selected.id
  filter {
    name   = "tag:Name"
    values = ["ckp-subnet-public-1"] # insert values here
  }
}

data "aws_subnet" "ckp-subnet-public-2" {
  vpc_id = data.aws_vpc.selected.id
  filter {
    name   = "tag:Name"
    values = ["ckp-subnet-public-2"] # insert values here
  }
}

data "aws_subnet" "ckp-subnet-public-3" {
  vpc_id = data.aws_vpc.selected.id
  filter {
    name   = "tag:Name"
    values = ["ckp-subnet-public-3"] # insert values here
  }
}

resource "aws_iam_role" "example" {
  name = "eks-node-group-example"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.example.name
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.example.name
}

resource "aws_iam_role_policy_attachment" "example-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.example.name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

module "my-cluster" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "my-cluster"
  cluster_version = "1.20"
  subnets         = [data.aws_subnet.ckp-subnet-public-1.id, data.aws_subnet.ckp-subnet-public-2.id, data.aws_subnet.ckp-subnet-public-3.id]
  vpc_id          = data.aws_vpc.selected.id
}

resource "aws_eks_node_group" "example" {
  cluster_name    = data.aws_eks_cluster.cluster.id 
  node_group_name = data.aws_eks_cluster.cluster.id
  node_role_arn   = aws_iam_role.example.arn
  subnet_ids      = [data.aws_subnet.ckp-subnet-public-1.id, data.aws_subnet.ckp-subnet-public-2.id, data.aws_subnet.ckp-subnet-public-3.id]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  remote_access {
    ec2_ssh_key = "ckp-region-key-pair"
  }

  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
  ]
}
