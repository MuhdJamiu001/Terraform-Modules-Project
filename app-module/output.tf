output "wp_instance_public_ip" {
  description = "Public IP of the WordPress EC2 instance."
  value       = module.compute.wp_public_ip
}

output "wp_instance_public_dns" {
  description = "Public DNS of the WordPress EC2 instance."
  value       = module.compute.wp_public_dns
}

output "wp_db_endpoint" {
  description = "RDS endpoint for the WordPress database."
  value       = module.rds.wp_db_endpoint
}

output "wp_vpc_id" {
  description = "ID of the WordPress VPC."
  value       = module.vpc.wp_vpc_id
}
