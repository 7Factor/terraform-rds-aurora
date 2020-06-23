terraform {
  required_version = ">=0.12.3"
}

# Look up the primary VPC
data "aws_vpc" "primary_vpc" {
  id = var.vpc_id
}

resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier = "${var.db_name}-aurora-cluster"
  engine             = "aurora"
  storage_encrypted  = var.storage_encrypted

  final_snapshot_identifier = "${var.db_name}-aurora-final-snapshot"
  skip_final_snapshot       = var.skip_final_snapshot
  deletion_protection       = var.deletion_protection

  db_subnet_group_name            = aws_db_subnet_group.rds_subnet_group.name

  vpc_security_group_ids = flatten([
    aws_security_group.allow_aurora_access.id,
    var.allow_db_access_sgs,
  ])

  database_name   = var.db_name
  master_username = var.db_master_username
  master_password = var.db_master_password
  port            = var.db_port
}

resource "aws_rds_cluster_instance" "aurora_db" {
  count              = var.db_instance_count
  identifier         = "${var.db_name}-instance-${count.index + 1}"
  cluster_identifier = aws_rds_cluster.aurora_cluster.cluster_identifier

  publicly_accessible = false

  engine_version = ""
  engine         = var.engine

  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  instance_class       = var.db_instance_class
}
