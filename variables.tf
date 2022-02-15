# Base variable requirements
variable "vpc_id" {
  description = "The ID of the VPC that we want to install things into."
}

# Database configuration
variable "primary_db_subnets" {
  type        = list(string)
  description = "A list of subnets to place your databases in. These should be private."
}

variable "additional_db_subnet_config" {
  type        = list(any)
  default     = []
  description = "An optional list of maps that describe the additional db subnets you want to create for the RDS. Make sure these don't collide with your primary subnets."
}

variable "db_instance_count" {
  default     = 1
  description = "The number of db instances to provision for the cluster. Defaults to 1."
}

variable "db_name" {
  description = "The name of a database to create."
}

variable "additional_db_sgs" {
  type        = list(string)
  default     = []
  description = "Pass in a list of security groups to assign to this aurora cluster."
}

variable "allow_db_access_sgs" {
  type        = list(string)
  default     = []
  description = "These security groups will be added to the primary DB access security group with access to the db port."
}

variable "db_instance_class" {
  description = "The instance type to assign to the database."
}

variable "db_master_username" {
  description = "The master username for accessing the database. Don't use this for your app."
}

variable "db_master_password" {
  description = "The password to access the DB. This is usually a 'master' or 'root' password, so don't be dumb and pass this in as clear text or check it in somewhere. Also don't use this for your app."
}

variable "db_port" {
  description = "The port. Like, for the database. And stuff."
}

variable "storage_encrypted" {
  default     = false
  description = "Switch to control encryption for the cluster. Defaults to false"
}

variable "deletion_protection" {
  default     = true
  description = "If you set this to false, there won't API level protection from deletion of data. Mostly here for testing."
}

variable "skip_final_snapshot" {
  default     = false
  description = "If you set this to true, it won't store a backup if the db is deleted. Mostly here for testing."
}

variable "engine" {
  default     = "aurora"
  description = "Engine name, defaults to aurora."
}

variable "engine_version" {
  default     = ""
  description = "This defaults to blank, but you'll need to sort which version of aurora you use along with the engine to give this a parameter it's ok with."
}

variable "cluster_parameter_group_name" {
  default     = null
  description = "A cluster parameter group to associate with the cluster."
}

variable "performance_insights_enabled" {
  default     = false
  description = "Enable performance insights on all database instances in the cluster. Defaults to false"
}

variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  default     = []
  description = "Set of log types to export to cloudwatch. If omitted, no logs will be exported. The following log types are supported: audit, error, general, slowquery, postgresql (PostgreSQL)"
}

variable "allow_major_version_upgrade" {
  type        = bool
  default     = false
  description = "Enable to allow major engine version upgrades when changing engine versions. Defaults to false"
}

variable "backup_retention_period" {
  type        = number
  default     = 1
  description = "The days to retain backups for. Default 1"
}

variable "preferred_backup_window" {
  type        = string
  default     = null
  description = "The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter. Time in UTC. Default: A 30-minute window selected at random from an 8-hour block of time per region. E.g. 04:00-09:00"
}
