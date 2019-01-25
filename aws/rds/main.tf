provider "aws" {
  profile    = "${var.aws_account}"
  region     = "${var.aws_region}"
}
resource "aws_db_instance" "default" {
 identifier = "${var.identifier}"
 allocated_storage = "${var.allocated_storage}"
 engine = "${var.engine}"
 engine_version = "${lookup(var.engine_version, var.engine)}"
 instance_class = "${var.instance_class}"
 storage_type = "${var.storage_type}"
 storage_encrypted="${var.storage_encrypted}"
 multi_az = "${var.multi_az}"
 copy_tags_to_snapshot = "${var.copy_tags_to_snapshot}"
 backup_retention_period = "${var.backup_retention_period}"
 backup_window = "${var.backup_window}"
 name = "${var.db_name}"
 port = "${lookup(var.db_port, var.engine)}"
 username = "${var.master_username}"
 password = "${var.master_password}"
 vpc_security_group_ids = ["${lookup(var.aws_vpc_security_group_ids, var.aws_account)}"]
 db_subnet_group_name = "${lookup(var.aws_db_subnet_group_name, var.aws_account)}"
 parameter_group_name = "${lookup(var.db_parameter_group_name,var.engine)}"
tags {
     "application" = "${var.tag_application}"
     "team" = "${var.tag_team}"
     "environment" = "${var.tag_environment}"
     "contact-email" = "${var.tag_contact_email}"
     "customer" = "${var.tag_customer}"
     }
}
