output "db_name" {
  value       = aws_rds_cluster.aurora_cluster.database_name
  description = "The name of the database you asked us to create."
}

output "db_master_username" {
  value       = aws_rds_cluster.aurora_cluster.master_username
  description = "The master username for the aurora cluster."
}

output "db_port" {
  value       = aws_rds_cluster.aurora_cluster.port
  description = "The port the database is running on."
}

output "db_endpoint" {
  value       = aws_rds_cluster.aurora_cluster.endpoint
  description = "The endpoint of the database cluster."
}

output "db_cluster_id" {
  value       = aws_rds_cluster.aurora_cluster.id
  description = "The id of the database cluster."
}