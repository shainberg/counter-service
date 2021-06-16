data "aws_eks_cluster" "cluster" {
  name = module.my-cluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.my-cluster.cluster_id
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
  subnets         = ["${aws_subnet.ckp-subnet-public-1.id}", "${aws_subnet.ckp-subnet-public-2.id}", "${aws_subnet.ckp-subnet-public-3.id}"]
  vpc_id          = "${aws_vpc.ckp-vpc.id}"
}

resource "aws_eks_node_group" "example" {
  cluster_name    = data.aws_eks_cluster.cluster.cluster_name 
  node_group_name = data.aws_eks_cluster.cluster.cluster_name
  node_role_arn   = aws_iam_role.example.arn
  subnet_ids      = ["${aws_subnet.ckp-subnet-public-1.id}", "${aws_subnet.ckp-subnet-public-2.id}", "${aws_subnet.ckp-subnet-public-3.id}"]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
  ]
}
