variable "conftag" {
  default = "PROD"
}
variable "chassis" {}
variable "location" {}
variable "customer" {}
variable "network" {}
variable "package_size" {}
variable "products" {}
variable "lvm" {
  default = ""
}
variable "mkfs" {
  default = ""
}
variable "nameservers" {
  default = ""
}
variable "ntpservers" {
  default = ""
}
variable "real_customer" {
  default = "none"
}
variable "environment" {}
variable "owner" {}
variable "bootstrap_endpoint" {
  default = "bootstrap.services.dmtio.net"
}
variable "idb_endpoint" {
  default = "http://idb.services.dmtio.net"
}
variable "idb_rw_endpoint" {
  default = "http://idb-api.ec2.dmtio.net"
}
variable "deployit_endpoint" {
  default = "http://deployit.services.dmtio.net"
}
