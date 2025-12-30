output "wp_db_instance_id" {
  description = "ID of the WordPress RDS instance."
  value       = aws_db_instance.wp_db.id
}

output "wp_db_address" {
  description = "Database hostname for WordPress to connect to (use this as DB_HOST)."
  value       = aws_db_instance.wp_db.address
}

output "wp_db_endpoint" {
  description = "Connection endpoint for the WordPress RDS instance (hostname:port)."
  value       = aws_db_instance.wp_db.endpoint
}

output "wp_db_port" {
  description = "Port of the WordPress RDS instance."
  value       = aws_db_instance.wp_db.port
}

output "wp_db_arn" {
  description = "ARN of the WordPress RDS instance."
  value       = aws_db_instance.wp_db.arn
}

output "wp_db_subnet_group_name" {
  description = "Name of the DB subnet group used by WordPress RDS."
  value       = aws_db_subnet_group.wp_db_subnet_group.name
}

output "wp_db_username" {
  description = "Master username for the RDS instance."
  value       = var.wp_db_username
}

output "wp_db_identifier" {
  description = "RDS instance identifier."
  value       = aws_db_instance.wp_db.id
}

output "wp_db_name" {
  description = "Database name used by the WordPress RDS module."
  value       = var.wp_db_name
}