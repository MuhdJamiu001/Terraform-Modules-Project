variable "wp_backend_region" {
  description = "AWS region where the Terraform backend S3 bucket (and lock table) will be created."
  type        = string
  default     = "us-east-1"
}

variable "wp_tf_state_bucket_name" {
  description = "Name of the S3 bucket that will store Terraform state. Must be globally unique."
  type        = string
  default     = "wp-terraformstate4635"
}

variable "wp_tf_state_bucket_force_destroy" {
  description = "If true, Terraform can delete the bucket even if it has objects. Keep false for safety."
  type        = bool
  default     = true
}


variable "wp_backend_tags" {
  description = "Tags to apply to backend resources (S3 bucket)."
  type        = map(string)
  default = {
    Project = "wp-terraform-backend"
    Managed = "terraform"
  }
}
