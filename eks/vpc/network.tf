resource "aws_internet_gateway" "ckp-igw" {
    vpc_id = "${aws_vpc.ckp-vpc.id}"
    tags = {
        Name = "ckp-igw"
    }
}
resource "aws_route_table" "ckp-public-crt" {
    vpc_id = "${aws_vpc.ckp-vpc.id}"

    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0"
        //CRT uses this IGW to reach internet
        gateway_id = "${aws_internet_gateway.ckp-igw.id}"
    }

    tags = {
        Name = "ckp-public-crt"
    }
}

resource "aws_route_table_association" "ckp-crta-public-subnet-1"{
    subnet_id = "${aws_subnet.ckp-subnet-public-1.id}"
    route_table_id = "${aws_route_table.ckp-public-crt.id}"
}

resource "aws_security_group" "ssh-allowed" {
    vpc_id = "${aws_vpc.ckp-vpc.id}"

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        // This means, all ip address are allowed to ssh !
        // Do not do it in the production.
        // Put your office or home address in it!
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "ssh-allowed"
    }
}
