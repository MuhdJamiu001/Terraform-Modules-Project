terraform {
  backend "s3" {
    bucket  = "wp-terraformstate4635"
    key     = "terraform/backend"
    region  = "us-east-1"
    encrypt = true
  }
}
