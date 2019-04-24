terraform {
  required_version = ">=0.10.7"
}

# Look up the primary VPC
data "aws_vpc" "primary_vpc" {
  id = "${var.vpc_id}"
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "concourse-rds-subnet-group"
  subnet_ids = "${aws_subnet.db_subnets.*.id}"

  tags {
    Name = "RDS Subnet Group for ${var.db_name}"
  }
}

resource "aws_db_instance" "concourse_db" {
  allocated_storage = "${var.db_size}"

  # Choosing not to parameterize these pieces. They're static.
  engine              = "aurora-mysql"
  storage_type        = "gp2"
  publicly_accessible = false

  # left blank
  engine_version = ""

  vpc_security_group_ids = "${var.db_security_groups}"
  db_subnet_group_name   = "${aws_db_subnet_group.rds_subnet_group.name}"

  name           = "${var.db_name}"
  instance_class = "${var.db_instance_class}"
  username       = "${var.db_username}"
  password       = "${var.db_password}"
  port           = "${var.db_port}"
}
