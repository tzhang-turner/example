variable "aws_account" {
  default = "aws-digital-sandbox"
}
variable "cluster_identifier" {
  default = ""
  description = "The identifier needs to be unique within the account."
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
variable "db_name" {
  default = ""
}
variable "instance_class" {
  default = "db.r3.large"
}
