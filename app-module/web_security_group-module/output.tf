output "wp_security_group_id" {
  description = "ID of the WordPress security group."
  value       = aws_security_group.wp_sg.id
}

output "wp_security_group_arn" {
  description = "ARN of the WordPress security group."
  value       = aws_security_group.wp_sg.arn
}

output "wp_security_group_name" {
  description = "Name of the WordPress security group."
  value       = aws_security_group.wp_sg.name
}
