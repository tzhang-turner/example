provider "aws" {
  region  = "us-east-1"
  profile = "corp-sandbox"
}

module "harbor" {
  source = "git::ssh://git@bitbucket.org/EATurner/harbor-terraform?ref=v1.2//corp-sandbox"
}

resource "aws_elasticache_subnet_group" "default" {
  name        = "subnet-group-cloud-arch-poc-redis-ha"
  description = "Private subnets for the ElastiCache instances"
  subnet_ids  = "${module.harbor.subnets_array}"
}

# multi-az with automatic failover
resource "aws_elasticache_replication_group" "redis" {
  replication_group_id          = "poc-redis-ha"
  replication_group_description = "Test HA multi-az cluster with automatic failover"
  node_type                     = "cache.m3.medium"
  number_cache_clusters         = 4
  port                          = 6379
  engine_version                = "3.2.4"
  parameter_group_name          = "default.redis3.2"
  availability_zones            = "${module.harbor.availability_zones}"
  automatic_failover_enabled    = true

  tags {
    team          = "cloud-arch"
    application   = "poc-redis-ha"
    environment   = "dev"
    contact-email = "john.ritsema@turner.com"
    customer      = "turner"
  }
}
