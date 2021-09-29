terraform {
  required_version = ">=0.12.3"
}

# Look up the primary VPC
data "aws_vpc" "primary_vpc" {
  id = var.vpc_id
}

resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier = "${var.db_name}-aurora-cluster"
  engine             = var.engine
  engine_version     = var.engine_version
  storage_encrypted  = var.storage_encrypted

  final_snapshot_identifier = "${var.db_name}-aurora-final-snapshot-${formatdate("YYYY-MM-DD-hhmmssZ", timestamp())}"
  skip_final_snapshot       = var.skip_final_snapshot
  deletion_protection       = var.deletion_protection

  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name

  db_cluster_parameter_group_name = var.cluster_parameter_group_name

  vpc_security_group_ids = flatten([
    aws_security_group.allow_aurora_access.id,
    var.additional_db_sgs,
  ])

  database_name   = var.db_name
  master_username = var.db_master_username
  master_password = var.db_master_password
  port            = var.db_port
}

# why are there two instance blocks you might ask?
# well Timmy that's because Terraform parses and handles variables before interpolations can be processed
# dont ask me, I didn't design Terraform, and am not smart enough to anyways. 
# look here for more context: https://github.com/hashicorp/terraform/issues/10730
resource "aws_rds_cluster_instance" "aurora_db_delete" {
  count              = var.deletion_protection ? 0 : var.db_instance_count
  identifier         = "${var.db_name}-instance-${count.index + 1}"
  cluster_identifier = aws_rds_cluster.aurora_cluster.cluster_identifier

  publicly_accessible = false

  engine_version = var.engine_version
  engine         = var.engine

  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  instance_class       = var.db_instance_class

  lifecycle {
    prevent_destroy = false
    ignore_changes  = [engine_version]
  }
}

resource "aws_rds_cluster_instance" "aurora_db_no_delete" {
  count              = var.deletion_protection ? var.db_instance_count : 0
  identifier         = "${var.db_name}-instance-${count.index + 1}"
  cluster_identifier = aws_rds_cluster.aurora_cluster.cluster_identifier

  publicly_accessible = false

  engine_version = var.engine_version
  engine         = var.engine

  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  instance_class       = var.db_instance_class

  lifecycle {
    prevent_destroy = true
    ignore_changes  = [engine_version]
  }
}
