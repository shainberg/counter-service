variable "AWS_REGION" {
    default = "eu-central-1"
}

variable "AMI" {
    type = map(string)

    default = {
        eu-central-1 = "ami-06ec8443c2a35b0ba"
    }
}
