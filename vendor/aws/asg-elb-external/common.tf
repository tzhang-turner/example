# User / Account specific variables
variable "region" {
  default = "us-east-1"
}

variable "location" {
  default = "ec2"
}

# SG's that allow limited external traffic to vms
variable "aws_external_security_groups" {
  type = "map"

  default = {
    aws-adultswim    = "sg-6f86e927"
    aws-cartoon-prod = "sg-9d40dfe8"
    aws-ent-prod     = "sg-1122296f"
    aws-nbad-prod    = "sg-1bf01b6e"
  }
}

# Internal only SG's (allow all traffic)
variable "aws_security_groups" {
  type = "map"

  default = {
    default             = "sg-0c626576"          # mpto
    aws-adultswim       = "sg-31b2dd79"
    aws-cartoon-prod    = "sg-d248d7a7"
    aws-digital-sandbox = "sg-3074734a"
    aws-digital-prod    = "sg-fe686f84"
    aws-ent-prod        = "sg-2f888c55"
    aws-mpto            = "sg-0c626576"
    aws-news-prod       = "sg-4c6b6c36"
    aws-sports-prod     = "sg-b67770cc"
    aws-shared-services = "sg-a52473d8"
    aws-corp-prod       = "sg-1733ba6c"
    aws-nbad-prod       = "sg-8de4f0ff"
    aws-sdata-prod      = "sg-55a0291c"
    aws-mssbst-portal   = "sg-045db01df32ddf50a"
    aws-ids-main        = "sg-00794bf5f81321682"
    aws-ncaa-nonprod    = "sg-0f5d5b3856bf7cb7b"
    aws-ncaa-prod       = "sg-0f0edc956897f1b43"
    aws-turnerdatacloud = "sg-0f7f91dca3b763a90"
  }
}

variable "aws_availability_zones" {
  type = "map"

  default = {
    default             = "us-east-1b,us-east-1d,us-east-1e"            # mpto
    aws-adultswim       = "us-east-1a,us-east-1b,us-east-1c,us-east-1e"
    aws-cartoon-prod    = "us-east-1c,us-east-1e"
    aws-digital-sandbox = "us-east-1a,us-east-1b"
    aws-digital-prod    = "us-east-1a,us-east-1c,us-east-1d,us-east-1e"
    aws-ent-prod        = "us-east-1a,us-east-1b,us-east-1d,us-east-1e"
    aws-mpto            = "us-east-1b,us-east-1d,us-east-1e"
    aws-news-prod       = "us-east-1b,us-east-1c,us-east-1d,us-east-1e"
    aws-sports-prod     = "us-east-1a,us-east-1b,us-east-1c,us-east-1e"
    aws-shared-services = "us-east-1a,us-east-1b,us-east-1d,us-east-1e"
    aws-corp-prod       = "us-east-1b,us-east-1c,us-east-1d,us-east-1e"
    aws-nbad-prod       = "us-east-1a,us-east-1c"
    aws-sdata-prod      = "us-east-1a,us-east-1b,us-east-1d"
    aws-mssbst-portal   = "us-east-1b,us-east-1c"
    aws-ids-main        = "us-east-1d,us-east-1f"
    aws-ncaa-nonprod    = "us-east-1d,us-east-1f"
    aws-ncaa-prod       = "us-east-1a,us-east-1c"
    aws-turnerdatacloud = "us-east-1a,us-east-1c,us-east-1d,us-east-1e"
  }
}

variable "aws_zone_identifiers" {
  type = "map"

  default = {
    default             = "subnet-c5a3cf9d,subnet-7b0f9541,subnet-73dcbb59"                 # mpto
    aws-adultswim       = "subnet-587ab964,subnet-4b1dc110,subnet-30cc4779,subnet-2bdd0506"
    aws-cartoon-prod    = "subnet-3f9c6210,subnet-c9c76cf6"
    aws-digital-sandbox = "subnet-12f50a64,subnet-019d8b58"
    aws-digital-prod    = "subnet-00c4285b,subnet-36eb051b,subnet-8d38e6c4,subnet-503cde6c"
    aws-ent-prod        = "subnet-9a99c1ec,subnet-e81661b0,subnet-a3066f89,subnet-51bde66c"
    aws-mpto            = "subnet-c5a3cf9d,subnet-7b0f9541,subnet-73dcbb59"
    aws-news-prod       = "subnet-d9102bf3,subnet-8cc229c5,subnet-b5d0ebed,subnet-d4343ce9"
    aws-sports-prod     = "subnet-6609684c,subnet-e083d396,subnet-a083ecf8,subnet-37cf930a"
    aws-shared-services = "subnet-3c4b3964,subnet-88684fb5,subnet-eb4e689d,subnet-dc1265f6"
    aws-corp-prod       = "subnet-95026bbf,subnet-3c663e4a,subnet-18295e40,subnet-c6b8e3fb"
    aws-nbad-prod       = "subnet-f81d07b1,subnet-98d847fd"
    aws-sdata-prod      = "subnet-967199f2,subnet-9c5e26b0,subnet-1eabdb44"
    aws-mssbst-portal   = "subnet-04a5b68ec03e520ab,subnet-041faac393a4baf2e"
    aws-ids-main        = "subnet-008479c8f184dc7b8,subnet-073389de95a3f1c74,subnet-07a976ecfc104c5e2"
    aws-ncaa-nonprod    = "subnet-01c9095ba23a6000d,subnet-057fe1dc1d4d7024f"
    aws-ncaa-prod       = "subnet-094980632a1f31a73,subnet-09b25e57b7b0c3eb6"
    aws-turnerdatacloud = "subnet-61caf139,subnet-b80a3192,subnet-cac42f83,subnet-ea373fd7"
  }
}

variable "aws_external_zone_identifiers" {
  type = "map"

  default = {
    default             = "subnet-87ab1ede,subnet-1e0a7a24,subnet-a8f92983"                 # mpto
    aws-adultswim       = "subnet-04de0629,subnet-becd46f7,subnet-d61dc18d,subnet-3a7ab906"
    aws-cartoon-prod    = "subnet-c79c62e8,subnet-48c26977"
    aws-digital-sandbox = "subnet-eaf50a9c,subnet-d69d8b8f"
    aws-digital-prod    = "subnet-e9c428b2,subnet-31eb051c,subnet-5339e71a,subnet-553cde69"
    aws-ent-prod        = "subnet-8499c1f2,subnet-e91661b1,subnet-a6066f8c,subnet-55bde668"
    aws-mpto            = "subnet-87ab1ede,subnet-1e0a7a24,subnet-a8f92983"
    aws-news-prod       = "subnet-dc102bf6,subnet-8fc229c6,subnet-b4d0ebec,subnet-d5343ce8"
    aws-sports-prod     = "subnet-78096852,subnet-ef83d399,subnet-ae83ecf6,subnet-3ecf9303"
    aws-shared-services = "subnet-bd4c6acb,subnet-d81265f2,subnet-db4b3983,subnet-89684fb4"
    aws-corp-prod       = "subnet-ee026bc4,subnet-3d663e4b,subnet-1a295e42,subnet-c5b8e3f8"
    aws-nbad-prod       = "subnet-fa1d07b3,subnet-64d74801"
    aws-sdata-prod      = "subnet-ed719989,subnet-c75736eb"
    aws-mssbst-portal   = "subnet-04b11ec669aca3351,subnet-0c30c8a747b9bd991"
    aws-ids-main        = "subnet-06e45fe40a8a84b44,subnet-04c1e610975d117ce"
    aws-ncaa-nonprod    = "subnet-0b297f6e359f5aa1c,subnet-0db89ab83be16fec8"
    aws-ncaa-prod       = "subnet-0af8af644a5f1d206,subnet-0c79197adec771559"
    aws-turnerdatacloud = "subnet-67caf13f,subnet-bd0a3197,subnet-c8c42f81,subnet-e7373fda"
  }
}

variable "aws_vpc" {
  type = "map"

  default = {
    default             = "vpc-f4f05d91"          # mpto
    aws-adultswim       = "vpc-17d0c170"
    aws-cartoon-prod    = "vpc-777bc80f"
    aws-digital-sandbox = "vpc-d069efb4"
    aws-digital-prod    = "vpc-5babf63c"
    aws-ent-prod        = "vpc-0b94506c"
    aws-mpto            = "vpc-f4f05d91"
    aws-news-prod       = "vpc-76aacd11"
    aws-sports-prod     = "vpc-c441b3a3"
    aws-shared-services = "vpc-173af870"
    aws-corp-prod       = "vpc-868f4be1"
    aws-nbad-prod       = "vpc-d60147b0"
    aws-sdata-prod      = "vpc-c15326b8"
    aws-mssbst-portal   = "vpc-0b9b103f71ae95948"
    aws-ids-main        = "vpc-0933a4912da4962d7"
    aws-ncaa-nonprod    = "vpc-04154d0aca6fc43d0"
    aws-ncaa-prod       = "vpc-08d57402f4d319948"
    aws-turnerdatacloud = "vpc-4ab3d42d"
  }
}

# following variables are passed to this module
variable "name" {}

variable "aws_named_profile" {}

variable "contact-email" {}

variable "aws_account" {}

variable "description" {}

variable "customer" {}

# if the billing customer (TAG) is different than the Argo (IDB) customer
variable "billing-customer" {
  default = ""
}

variable "environment" {}

variable "products" {
  default = ""
}

variable "mkfs" {
  default = ""
}

variable "lvm" {
  default = ""
}

variable "aws_ami" {
  default = "ami-3728a521"
}

variable "aws_instance_type" {
  default = "t2.micro"
}

variable "package_size" {
  default = "1x1x0-t2"
}

variable "aws_root_volume_delete_on_termination" {
  default = "true"
}

variable "aws_root_volume_size_in_gigabytes" {
  default = "8"
}

variable "aws_root_volume_type" {
  default = "gp2"
}

variable "conftag" {
  default = "PROD"
}

variable "owner" {
  default = "ictops"
}

variable "team" {
  default = "ictops"
}

variable "nameservers" {
  default = ""
}

variable "asg_min_instances" {
  default = "0"
}

variable "asg_max_instances" {
  default = "4"
}

variable "asg_desired_instances" {
  default = "1"
}

# LB variables

# AWS defaults SSL Listener policies to this; override for enhanced security
variable "lb_ssl_listener_policy_name" {
  default = "ELBSecurityPolicy-2016-08"
}

variable "lb_health_check_timeout" {
  default = "5"
}

variable "lb_health_check_interval" {
  default = "30"
}

variable "lb_health_check_unhealthy_threshold" {
  default = "3"
}

variable "lb_health_check_healthy_threshold" {
  default = "3"
}

variable "lb_idle_timeout" {
  default = "60"
}

variable "lb_sticky_lb_port" {
  default = "80"
}

variable "lb_cookie_expiration" {
  default = "600"
}

variable "elb_health_check_timeout" {
  default = "5"
}

variable "elb_health_check_interval" {
  default = "30"
}

variable "elb_health_check_unhealthy_threshold" {
  default = "3"
}

variable "elb_health_check_healthy_threshold" {
  default = "3"
}

variable "elb_idle_timeout" {
  default = "60"
}

variable "elb_sticky_lb_port" {
  default = "80"
}

variable "elb_cookie_expiration" {
  default = "600"
}
