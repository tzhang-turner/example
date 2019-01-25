provider "aws" {
  profile    = "${var.aws_account}"
  region     = "${var.aws_region}"
}
resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = "${var.cluster_instance_count}"
  identifier         = "${var.cluster_identifier}-${count.index}"
  instance_class     = "${var.instance_class}"
  cluster_identifier = "${aws_rds_cluster.default.id}"
  db_parameter_group_name = "${var.db_parameter_group}"
  tags {
     "application" = "${var.tag_application}"
     "team" = "${var.tag_team}"
     "environment" = "${var.tag_environment}"
     "contact-email" = "${var.tag_contact_email}"
     "customer" = "${var.tag_customer}"
     }
}
resource "aws_rds_cluster" "default" {
  cluster_identifier = "${var.cluster_identifier}"
  database_name = "${var.db_name}"
  master_username = "${var.master_username}"
  master_password = "${var.master_password}"
  db_cluster_parameter_group_name = "${var.db_cluster_parameter_group_name}"
  backup_retention_period = "${var.backup_retention_period}"
  vpc_security_group_ids = ["${lookup(var.aws_vpc_security_group_ids, var.aws_account)}"]
  db_subnet_group_name = "${lookup(var.aws_db_subnet_group_name, var.aws_account)}"
  availability_zones = ["${split( ",", lookup(var.aws_availability_zones, var.aws_account))}"]
}
