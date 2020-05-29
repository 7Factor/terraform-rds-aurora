# Base variable requirements
variable vpc_id {
  description = "The ID of the VPC that we want to install things into."
}

# Database configuration
variable primary_db_subnets {
  type        = list(string)
  description = "A list of subnets to place your databases in. These should be private."
}

variable additional_db_subnet_config {
  type        = list
  default     = []
  description = "An optional list of maps that describe the additional db subnets you want to create for the RDS. Make sure these don't collide with your primary subnets."
}

variable db_instance_count {
  default     = 1
  description = "The number of db instances to provision for the cluster. Defaults to 1."
}

variable db_name {
  description = "The name of a database to create."
}

variable allow_db_access_sgs {
  type        = list(string)
  default     = []
  description = "Pass in a list of security groups that will have access to your Aurora cluser. Be smart with this."
}

variable additional_db_security_groups {
  type        = list(string)
  default     = []
  description = "Pass in a list of additional security groups that you want to assign to the database. This is a good place to allow bastion access for example."
}

variable db_instance_class {
  description = "The instance type to assign to the database."
}

variable db_master_username {
  description = "The master username for accessing the database. Don't use this for your app."
}

variable db_master_password {
  description = "The password to access the DB. This is usually a 'master' or 'root' password, so don't be dumb and pass this in as clear text or check it in somewhere. Also don't use this for your app."
}

variable db_port {
  description = "The port. Like, for the database. And stuff."
}

variable db_cluster_parameter_group_name {
  default     = ""
  description = "The name of a custom parameter group for the database cluster."
}

variable "storage_encrypted" {
  default     = false
  description = "Switch to control encryption for the cluster. Defaults to false"
}
