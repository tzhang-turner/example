provider "aws" {
    profile = "${var.aws_profile}"
    region = "${var.aws_region}"
}

resource "aws_instance" "terraformtest" {
    ami = "ami-fce3c696"
    instance_type = "t2.micro"
    key_name = "rcannon_ec2"
    vpc_security_group_ids = ["sg-e8ee6091"]
    subnet_id = "subnet-eaf50a9c"
    tags {
        Name="RobTest"
    }
}