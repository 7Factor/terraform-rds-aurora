# Base variable requirements
variable vpc_id {
  description = "The ID of the VPC that we want to install things into."
}

# Database configuration
variable db_subnet_config {
  type        = "list"
  description = "A list of maps that describe the db subnets you want to create for the RDS."
}

variable db_name {
  description = "The name of the database to create."
}

variable db_size {
  description = "The size of the database (in GB) to provision."
}

variable db_security_groups {
  type        = "list"
  description = "Pass in a list of security groups that you want to assign to the database. Be smart with this."
}

variable db_instance_class {
  description = "The instance type to assign to the database."
}

variable db_username {
  description = "The username for accessing the database."
}

variable db_password {
  description = "The password to access the DB. This is usually a 'master' or 'root' password, so don't be dumb and pass this in as clear text or check it in somewhere."
}

variable db_port {
  description = "The port. Like, for the database. And stuff."
}
