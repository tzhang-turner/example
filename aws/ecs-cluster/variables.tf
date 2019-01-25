variable "custom_security_groups" {
  default = ""
}

variable "docker_version" {
  default = "docker-ce=17.12.1~ce-0~ubuntu"
}

variable "cluster_name" {
  default = ""
}

variable "iam_instance_role" {
  default = "ecsInstanceRole"
}
