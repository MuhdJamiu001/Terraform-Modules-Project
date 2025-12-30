output "ubuntu_ami_id" {
  description = "AMI ID of Ubuntu instance"
  value       = data.aws_ami.amiID.id
}

output "instance_id" {
    description = "ID of the EC2 instance created by Terraform"
  value = aws_instance.wp.id
}

output "wp_public_ip" {
    description = "Public IPv4 address of the EC2 instance (only present if it’s in a public subnet)."
  value = aws_instance.wp.public_ip
}

output "wp_public_dns" {
    description = "Public DNS name of the EC2 instance (useful for SSH/HTTP if enabled)."
  value = aws_instance.wp.public_dns
}

output "private_ip" {
    description = "Private IPv4 address of the EC2 instance inside the VPC (used for internal communication)."
  value = aws_instance.wp.private_ip
}
