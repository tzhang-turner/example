# DB engine
variable "engine" {
  default = "oracle-ee"
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
variable "backup_window" {
  default = "00:00-01:00"
}
# Security
variable "aws_region" {
  default = "us-east-1"
}
# snapshot
variable "copy_tags_to_snapshot" {
  default = "true"
}
# vpc
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
# subnet
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
# master user
variable "master_username" {
  default = "turnerdba"
}
variable "master_password" {
  default = ""
}
# DB port
variable "db_port" {
  default = {
    oracle-ee = "1530"
    mysql = "3306"
    mariadb = "3306"
    postgres = "5432"
  }
}
