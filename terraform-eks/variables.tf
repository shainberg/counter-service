locals {
    env = "prod"
}

variable "region" {
    default = "eu-west-1"
}

variable "availability_zone1" {
    default = "eu-west-1a"
}

variable "availability_zone2" {
    default = "eu-west-1b"
}

variable "eks_name" {
    default = "eks-eilon"
}

variable "eks_version" {
    default = "1.30"
}