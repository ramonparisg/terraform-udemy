terraform {
  backend "s3" {
    bucket = "terraform-backend-rjpg1"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}
