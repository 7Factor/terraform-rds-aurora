terraform {
  required_version = ">=0.10.7"
}

# Look up the primary VPC
data "aws_vpc" "primary_vpc" {
  id = "${var.vpc_id}"
}

resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier  = "${var.db_name}-aurora-cluster"
  deletion_protection = true
  engine              = "${var.db_engine}"

  final_snapshot_identifier = "${var.db_name}-aurora-final-snapshot"

  db_subnet_group_name = "${aws_db_subnet_group.rds_subnet_group.name}"

  vpc_security_group_ids = [
    "${aws_security_group.allow_aurora_access.id}",
    "${var.db_security_groups}",
  ]

  database_name   = "${var.db_name}"
  master_username = "${var.db_username}"
  master_password = "${var.db_password}"
  port            = "${var.db_port}"
}

resource "aws_rds_cluster_instance" "aurora_db" {
  count              = "${var.db_instance_count}"
  identifier         = "${var.db_name}-instance"
  cluster_identifier = "${aws_rds_cluster.aurora_cluster.cluster_identifier}"

  engine              = "${var.db_engine}"
  publicly_accessible = false

  # left blank
  engine_version = ""

  db_subnet_group_name = "${aws_db_subnet_group.rds_subnet_group.name}"
  instance_class       = "${var.db_instance_class}"

  # adding this as an extra precaution.
  # an explicit deletion protection does not exist for instances
  lifecycle {
    prevent_destroy = true
  }
}
