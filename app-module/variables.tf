variable "region" {
  default = "us-east-1"
}

variable "wp_zone1" {
  description = "Availability Zone for WordPress stack (AZ1) used by the VPC module (e.g., us-east-1a)."
  type        = string
}

variable "wp_zone2" {
  description = "Availability Zone for WordPress stack (AZ2) used by the VPC module (e.g., us-east-1b)."
  type        = string
}

variable "wp_ssh_cidr" {
  description = "CIDR allowed to SSH into the WordPress EC2 instance (use your IP/32 in real projects)."
  type        = string
  default     = "0.0.0.0/0"
}

variable "wp_key_name" {
  description = "Existing AWS EC2 key pair name used for SSH access."
  type        = string
  default     = "wp_instance-key"
}

variable "wp_db_password" {
  description = "Master password for the WordPress RDS database (set in terraform.tfvars; keep secret)."
  type        = string
  sensitive   = true
}

