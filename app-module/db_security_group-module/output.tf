output "wp_db_security_group_id" {
  description = "ID of the WordPress database security group."
  value       = aws_security_group.wp_db_sg.id
}

output "wp_db_security_group_arn" {
  description = "ARN of the WordPress database security group."
  value       = aws_security_group.wp_db_sg.arn
}

output "wp_db_security_group_name" {
  description = "Name of the WordPress database security group."
  value       = aws_security_group.wp_db_sg.name
}
