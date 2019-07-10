vpc_id = "VPC-ID"

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
db_size = 100

additional_db_security_groups = ["SG-1", "SG-2"]
db_instance_class             = "db.t2.micro"
db_username                   = "dude"
db_password                   = "DON'T PUT THIS IN HERE"
db_port                       = 3306
