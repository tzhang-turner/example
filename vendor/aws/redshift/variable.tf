variable "region" {
  description = "Region"
  default     = "us-east-1"
}

variable "profile" {
  description = "Profile from credentials"
  default     = "default"
}

variable "tag_name" {}
variable "tag_application" {}
variable "tag_team" {}
variable "tag_environment" {}
variable "tag_contact_email" {}
variable "cluster_id" {}
variable "db_name" {}
variable "master_username" {}
variable "master_password" {}

variable "availability_zone" {
  default = "us-east-1a"
}

variable "encrypted" {
  default = false
}

variable "skip_final_snapshot" {
  default = true
}

variable "number_of_nodes" {
  default = 3
}

variable "cluster_type" {
  default = "multi-node"
}

variable "node_type" {
  default = "dc1.large"
}
