resource "aws_instance" "eks_mgr" {
    ami = "${lookup(var.AMI, var.AWS_REGION)}"
    instance_type = "t2.micro"
    # VPC
    subnet_id = "${aws_subnet.ckp-subnet-public-1.id}"
    # Security Group
    vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]
    # the Public SSH key
    key_name = "${aws_key_pair.ckp-region-key-pair.id}"
    # nginx installation
    connection {
        user = "${var.EC2_USER}"
        private_key = "${file("ckp-region-key-pair")}"
    }
}
// Sends your public key to the instance
resource "aws_key_pair" "ckp-region-key-pair" {
    key_name = "ckp-region-key-pair"
    public_key = "${file("ckp-region-key-pair.pub")}"
}
