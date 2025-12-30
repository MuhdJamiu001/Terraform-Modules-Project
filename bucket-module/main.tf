resource "aws_s3_bucket" "wp_tf_state" {
  bucket        = var.wp_tf_state_bucket_name
  force_destroy = var.wp_tf_state_bucket_force_destroy

  tags = var.wp_backend_tags

  lifecycle {
    prevent_destroy = false
  }
}


resource "aws_s3_bucket_server_side_encryption_configuration" "wp_tf_state" {
  bucket = aws_s3_bucket.wp_tf_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "wp_tf_state" {
  bucket = aws_s3_bucket.wp_tf_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
