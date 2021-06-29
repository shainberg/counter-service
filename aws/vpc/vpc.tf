resource "aws_vpc" "ckp-vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = "true" #gives you an internal domain name
    enable_dns_hostnames = "true" #gives you an internal host name
    enable_classiclink = "false"
    instance_tenancy = "default"

    tags = {
        Name = "ckp-vpc"
    }
}

resource "aws_subnet" "ckp-subnet-public-1" {
    vpc_id = "${aws_vpc.ckp-vpc.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true" //it makes this a public subnet
    availability_zone = "eu-central-1a"
    tags = {
        Name = "ckp-subnet-public-1"
    }
}

resource "aws_subnet" "ckp-subnet-public-2" {
    vpc_id = "${aws_vpc.ckp-vpc.id}"
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true" //it makes this a public subnet
    availability_zone = "eu-central-1b"
    tags = {
        Name = "ckp-subnet-public-2"
    }
}

resource "aws_subnet" "ckp-subnet-public-3" {
    vpc_id = "${aws_vpc.ckp-vpc.id}"
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = "true" //it makes this a public subnet
    availability_zone = "eu-central-1c"
    tags = {
        Name = "ckp-subnet-public-3"
    }
}
