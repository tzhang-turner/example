data "template_file" "bootstrap-ecs" {
  template = "${file("${path.module}/bootstrap-ecs.tpl")}"
  vars {
    conftag = "${var.conftag}"
    ecs_cluster_name = "${var.ecs_cluster_name}"
    ecs_docker_version = "${var.ecs_docker_version}"
    conftag = "${var.conftag}"
    customer = "${var.customer}"
    package_size = "${var.package_size}"
    products = "${var.products}"
    real_customer = "${var.real_customer}"
    owner = "${var.owner}"
    environment = "${var.environment}"
    chassis = "${var.chassis}"
    location = "${var.location}"
    network = "${var.network}"
    mkfs = "${var.mkfs}"
    lvm = "${var.lvm}"
    nameservers = "${var.nameservers}"
    ntpservers = "${var.ntpservers}"
    bootstrap_endpoint = "${var.bootstrap_endpoint}"
    idb_endpoint = "${var.idb_endpoint}"
    idb_rw_endpoint = "${var.idb_rw_endpoint}"
    deployit_endpoint = "${var.deployit_endpoint}"
  }
}

output "user_data" {
  value = "${data.template_file.bootstrap-ecs.rendered}"
}
