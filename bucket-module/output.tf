output "wp_tf_state_bucket_name" {
  description = "Name of the S3 bucket used for Terraform remote state."
  value       = aws_s3_bucket.wp_tf_state.bucket
}

output "wp_tf_state_bucket_arn" {
  description = "ARN of the S3 bucket used for Terraform remote state."
  value       = aws_s3_bucket.wp_tf_state.arn
}

