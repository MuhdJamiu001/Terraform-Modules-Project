variable "wp_db_subnet_ids" {
  description = "List of private subnet IDs for the RDS subnet group."
  type        = list(string)
}

variable "wp_db_security_group_ids" {
  description = "List of security group IDs to attach to the WordPress RDS instance (typically the WP DB SG)."
  type        = list(string)
}

variable "wp_db_identifier" {
  description = "Identifier/name for the WordPress RDS instance."
  type        = string
  default     = "wp-rds"
}

variable "wp_db_engine" {
  description = "Database engine for WordPress."
  type        = string
  default     = "mysql"
}

variable "wp_db_engine_version" {
  description = "Engine version for the chosen database engine."
  type        = string
  default     = "8.0"
}

variable "wp_db_instance_class" {
  description = "RDS instance class/size."
  type        = string
  default     = "db.t3.micro"
}

variable "wp_db_allocated_storage" {
  description = "Allocated storage (GiB) for the WordPress database."
  type        = number
  default     = 20
}

variable "wp_db_name" {
  description = "Initial database name to create."
  type        = string
  default     = "wordpress"
}

variable "wp_db_username" {
  description = "Master username for the WordPress database."
  type        = string
  default     = "wpadmin"
}

variable "wp_db_password" {
  description = "Master password for the WordPress database."
  type        = string
  sensitive   = true
}

variable "wp_db_port" {
  description = "Database port (MySQL is typically 3306)."
  type        = number
  default     = 3306
}

variable "wp_db_multi_az" {
  description = "Whether to enable Multi-AZ for higher availability."
  type        = bool
  default     = false
}

variable "wp_db_publicly_accessible" {
  description = "Whether the RDS instance should have a public endpoint. For best practice with WordPress, set false."
  type        = bool
  default     = false
}

variable "wp_db_storage_encrypted" {
  description = "Enable storage encryption for the RDS instance."
  type        = bool
  default     = true
}

variable "wp_db_backup_retention_period" {
  description = "Number of days to retain automated backups."
  type        = number
  default     = 7
}

variable "wp_db_deletion_protection" {
  description = "Prevent accidental deletion of the DB instance."
  type        = bool
  default     = false
}

variable "wp_db_apply_immediately" {
  description = "Apply changes immediately (true) or during the maintenance window (false)."
  type        = bool
  default     = true
}

variable "wp_db_skip_final_snapshot" {
  description = "Skip final snapshot on destroy. For dev, true is convenient. For production, set false."
  type        = bool
  default     = true
}

variable "wp_db_subnet_group_name" {
  description = "Name for the DB subnet group used by WordPress RDS."
  type        = string
  default     = "wp-db-subnet-group"
}

variable "wp_db_subnet_group_description" {
  description = "Description for the WordPress DB subnet group."
  type        = string
  default     = "Subnet group for WordPress RDS (private subnets)"
}
