variable "aws_account" {
  default = "aws-digital-sandbox"
}
variable "multi_az" {
  default = "false"
  description = "Set it to true in prod."
}
variable "tag_application" {
  default = ""
}
variable "tag_team" {
  default = ""
}
variable "tag_environment" {
  default = ""
}
variable "tag_contact_email" {
  default = ""
}
variable "tag_customer" {
  default = ""
}
variable "identifier" {
  default = ""
  description = "Identifier for your rds, need to be unique within the account."
}
variable "db_name" {
  default = ""
}
variable "instance_class" {
  default = "db.t2.micro"
}
variable "allocated_storage" {
  default = "60"
  description = "Storage size in GB"
}
variable "engine_version" {
    default = "12.1.0.2.v5"
}
variable "db_parameter_group" {
  default = "default.oracle-ee-12.1"
}
variable "db_option_group_name" {
  default = ""
}
variable "major_engine_version" {
    default = "12.1"
}
