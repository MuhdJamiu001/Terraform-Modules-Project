output "wp_vpc_id" {
  description = "ID of the WordPress VPC."
  value       = aws_vpc.project.id
}

output "wp_public_subnet_ids" {
  description = "List of public subnet IDs for the WordPress VPC."
  value       = [
    aws_subnet.project-pub-1.id,
    aws_subnet.project-pub-2.id
  ]
}

output "wp_private_subnet_ids" {
  description = "List of private subnet IDs for the WordPress VPC."
  value       = [
    aws_subnet.project-priv-1.id,
    aws_subnet.project-priv-2.id
  ]
}

output "wp_internet_gateway_id" {
  description = "ID of the Internet Gateway attached to the WordPress VPC."
  value       = aws_internet_gateway.project-IGW.id
}

output "wp_public_route_table_id" {
  description = "ID of the public route table for the WordPress VPC."
  value       = aws_route_table.project-pub-RT.id
}
