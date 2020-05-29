vpc_id = "VPC-ID"

primary_db_subnets = ["SUBNET-1", "SUBNET-2"]

# Private subnet for databases
additional_db_subnet_config = [
  {
    az   = "us-east-1c"
    cidr = "172.0.4.0/24"
    }, {
    az   = "us-east-1d"
    cidr = "172.0.5.0/24"
  }
]

db_name = "THE-NAME"

additional_db_security_groups = ["SG-1", "SG-2"]
db_instance_class             = "db.t2.small"
db_master_username            = "dude"
db_master_password            = "DON'T PUT THIS IN HERE"
db_port                       = 3306
