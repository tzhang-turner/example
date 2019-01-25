# DB Engine
variable "engine_version" {
  description = "Engine version"
  default = {
    aurora = "5.6"
  }
}
variable "db_parameter_group" {
  default = "default.aurora5.6"
}
variable "db_cluster_parameter_group_name" {
  default = "default.aurora5.6"                                                           
}

# storage_type
# "standard" (magnetic), "gp2" (general purpose SSD), 
# "io1" (provisioned IOPS SSD). 
variable "storage_type" {
  default = "gp2"
}
variable "apply_immediately" {
  default = "false"
}
variable "backup_retention_period" {
  default = "1"
}
variable "preferred_backup_window" {
  default = "00:00-01:00"
}
variable "cluster_instance_count" {
  default = "2"
}
variable "multi_az" {
  default = "true"
}
# Security
variable "aws_region" {
  default = "us-east-1"
}
variable "aws_vpc_security_group_ids" {
  type = "map"
  default = {
     default = "sg-e8ee6091"  # digital-sandbox
     aws-digital-sandbox = "sg-e8ee6091"
     aws-digital-prod = "sg-3c8d6241"
     aws-corp-sandbox = "sg-9662a4ec"
     aws-mpto = "sg-2fc1834a"
     aws-ent-prod = "sg-61e1d51a"
     aws-news-prod = "sg-d4de34ae"
     aws-sports-prod = "sg-eee0cb94"
  }
}
variable "aws_db_subnet_group_name" {
    type = "map"
    default = {
      default   =  "default-vpc-d069efb4"    # digital-sandbox
      aws-digital-sandbox   =  "default-vpc-d069efb4"
      aws-corp-sandbox      =  "default-vpc-0957a56e"
      aws-digital-prod      =  "dba-subnet-group"
      aws-mpto              =  "default-vpc-f4f05d91"
      aws-ent-prod          =  "dba-subnet-group"
      aws-news-prod         =  "dba-subnet-group"
      aws-sports-prod       =  "dba-subnet-group"
    }
}
variable "aws_availability_zones" {
    type = "map"
    default = {
      default   =  "us-east-1a,us-east-1b"    # digital-sandbox
      aws-digital-sandbox   =  "us-east-1a,us-east-1b"
      aws-corp-sandbox   =  "us-east-1b,us-east-1c,us-east-1e"
      aws-digital-prod      =  "us-east-1a,us-east-1c,us-east-1e"
      aws-mpto          =  "us-east-1b,us-east-1d,us-east-1e"
      aws-ent-prod      =  "us-east-1a,us-east-1b,us-east-1e"
      aws-news-prod         =  "us-east-1b,us-east-1c,us-east-1d"
      aws-sports-prod       =  "us-east-1a,us-east-1c,us-east-1e"
    }
}
# master user
variable "master_username" {                                                              
  default = "turnerdba"
}
variable "master_password" {
  default = ""
}
# db engine
variable "engine" {
  default = "aurora"
}
