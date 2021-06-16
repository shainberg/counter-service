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
  load_config_file       = false
}

module "my-cluster" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "my-cluster"
  cluster_version = "1.17"
  subnets         = ["${aws_subnet.ckp-subnet-public-1.id}", "${aws_subnet.ckp-subnet-public-2.id}", "${aws_subnet.ckp-subnet-public-3.id}"]
  vpc_id          = "${aws_vpc.ckp-vpc.id}"

  worker_groups = [
    {
      instance_type = "m5a.large"
      asg_max_size  = 5
    }
  ]
}
