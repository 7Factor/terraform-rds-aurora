resource "aws_db_subnet_group" "rds_subnet_group" {
  name = "${var.db_name}-rds-subnet-group"

  subnet_ids = flatten([
    aws_subnet.db_subnets.*.id,
    var.primary_db_subnets,
  ])

  tags = {
    Name = "RDS Subnet Group for ${var.db_name}"
  }
}

resource "aws_subnet" "db_subnets" {
  vpc_id            = data.aws_vpc.primary_vpc.id
  count             = length(var.additional_db_subnet_config)
  cidr_block        = lookup(var.additional_db_subnet_config[count.index], "cidr")
  availability_zone = lookup(var.additional_db_subnet_config[count.index], "az")

  tags = {
    Name = "Private Subnet (${lookup(var.additional_db_subnet_config[count.index], "az")})"
  }
}

