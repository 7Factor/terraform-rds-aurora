resource "aws_subnet" "db_subnets" {
  vpc_id            = "${data.aws_vpc.primary_vpc.id}"
  count             = "${length(var.additional_db_subnet_config)}"
  cidr_block        = "${lookup(var.additional_db_subnet_config[count.index], "cidr")}"
  availability_zone = "${lookup(var.additional_db_subnet_config[count.index], "az")}"

  tags {
    Name = "Private Subnet (${lookup(var.additional_db_subnet_config[count.index], "az")})"
  }
}
