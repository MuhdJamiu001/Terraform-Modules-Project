variable "wp_vpc_id" {
  description = "VPC ID where the WordPress security group will be created."
  type        = string
}

variable "wp_sg_name" {
  description = "Name for the WordPress security group."
  type        = string
  default     = "wp-project-sg"
}

variable "wp_sg_description" {
  description = "Description for the WordPress security group."
  type        = string
  default     = "Security group for WordPress web instance"
}

variable "wp_ssh_cidr" {
  description = "IPv4 CIDR allowed to SSH into the instance. Use your public IP/32 for safer access."
  type        = string
  default     = "0.0.0.0/0"
}

variable "wp_http_cidr" {
  description = "IPv4 CIDR allowed to access HTTP (port 80). Usually 0.0.0.0/0 for public websites."
  type        = string
  default     = "0.0.0.0/0"
}

variable "wp_https_cidr" {
  description = "IPv4 CIDR allowed to access HTTPS (port 443). Usually 0.0.0.0/0 for public websites."
  type        = string
  default     = "0.0.0.0/0"
}

variable "wp_ssh_port" {
  description = "Port used for SSH access."
  type        = number
  default     = 22
}

variable "wp_http_port" {
  description = "Port used for HTTP traffic."
  type        = number
  default     = 80
}

variable "wp_https_port" {
  description = "Port used for HTTPS traffic."
  type        = number
  default     = 443
}

variable "wp_allow_https" {
  description = "Whether to allow inbound HTTPS (port 443)."
  type        = bool
  default     = true
}
