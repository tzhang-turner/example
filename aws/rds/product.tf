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
variable "storage_encrypted" {
   default="false"
   description = "enable encryption at rest"
}
variable "allocated_storage" {
  default = "60"
  description = "Storage size in GB"
}
variable "engine" {
  default = "oracle-ee"
  description = "Engine type, example values mysql,mariadb,postgres,oracle-ee."
}
