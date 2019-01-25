output "db_instance_id" {
  value = "${aws_rds_cluster_instance.cluster_instances.id}"
}
output "db_instance_address" {
  value = "${aws_rds_cluster_instance.cluster_instances.address}"
}
