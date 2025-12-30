variable "wp_vpc_id" {
  description = "VPC ID where the WordPress database security group will be created."
  type        = string
}

variable "wp_web_sg_id" {
  description = "Security group ID of the WordPress web/app instance(s) that should be allowed to connect to the database."
  type        = string
}

variable "wp_db_port" {
  description = "Database port to allow from the WordPress web/app security group (MySQL for WordPress is typically 3306)."
  type        = number
  default     = 3306
}

variable "wp_db_sg_name" {
  description = "Name for the WordPress database security group."
  type        = string
  default     = "wp-db-sg"
}

variable "wp_db_sg_description" {
  description = "Description for the WordPress database security group."
  type        = string
  default     = "Database security group for WordPress (allows DB access only from the WP web/app SG)"
}

variable "wp_enable_ipv6_egress" {
  description = "Whether to allow outbound IPv6 traffic from the database security group. Set true only if you actively use IPv6."
  type        = bool
  default     = false
}
