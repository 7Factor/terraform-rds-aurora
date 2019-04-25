output "db_name" {
  value       = "${aws_rds_cluster.aurora_cluster.database_name}"
  description = "The name of the database."
}

output "db_master_username" {
  value       = "${aws_rds_cluster.aurora_cluster.master_username}"
  description = "The master username for the aurora cluster."
}

output "db_port" {
  value = "${aws_rds_cluster.aurora_cluster.port}"
}
