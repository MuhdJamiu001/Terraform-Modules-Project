variable "wp_project_name" {
  description = "Name prefix used for tagging WordPress infrastructure resources (VPC, subnets, route tables, etc.)."
  type        = string
  default     = "wp-project"
}

variable "wp_vpc_cidr" {
  description = "CIDR block for the WordPress VPC (the private network range for all subnets)."
  type        = string
  default     = "10.0.0.0/16"
}

variable "wp_instance_tenancy" {
  description = "VPC tenancy setting. 'default' uses shared hardware. Use 'dedicated' only if you specifically need dedicated tenancy."
  type        = string
  default     = "default"
}

variable "wp_enable_dns_support" {
  description = "Enable DNS resolution within the VPC. Required for instances/RDS to resolve domain names."
  type        = bool
  default     = true
}

variable "wp_enable_dns_hostnames" {
  description = "Assign DNS hostnames to instances in the VPC. Useful for easier internal naming and many AWS-managed services."
  type        = bool
  default     = true
}

variable "wp_public_subnet_1_cidr" {
  description = "CIDR block for WordPress public subnet 1."
  type        = string
  default     = "10.0.1.0/24"
}

variable "wp_public_subnet_2_cidr" {
  description = "CIDR block for WordPress public subnet 2."
  type        = string
  default     = "10.0.2.0/24"
}

variable "wp_private_subnet_1_cidr" {
  description = "CIDR block for WordPress private subnet 1."
  type        = string
  default     = "10.0.4.0/24"
}

variable "wp_private_subnet_2_cidr" {
  description = "CIDR block for WordPress private subnet 2."
  type        = string
  default     = "10.0.5.0/24"
}

variable "wp_zone1" {
  description = "Availability Zone for WordPress subnet set 1 (e.g., us-east-1a)."
  type        = string
}

variable "wp_zone2" {
  description = "Availability Zone for WordPress subnet set 2 (e.g., us-east-1b)."
  type        = string
}

variable "wp_map_public_ip_on_launch_public" {
  description = "Whether instances launched in public subnets should automatically get a public IPv4 address."
  type        = bool
  default     = true
}

variable "wp_map_public_ip_on_launch_private" {
  description = "Whether instances launched in private subnets should automatically get a public IPv4 address. For true private subnets, set this to false."
  type        = bool
  default     = false
}
