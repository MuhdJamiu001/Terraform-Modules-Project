variable "subnet_id" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "key_name" {
  type = string
  default = "wp_instance-key"
}

variable "instance_name" {
  type    = string
  default = "WP-Project"
}
