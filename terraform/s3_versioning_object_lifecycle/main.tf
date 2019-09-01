provider "aws" {

  region = var.aws_region

}

resource "aws_s3_bucket" "demo-bucket" {
  bucket = var.bucket_name
  acl = "private"
  versioning {
    enabled = true
  }

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  lifecycle_rule {
    enabled = true
    transition {
      storage_class = "STANDARD_IA"
      days = 30
    }

    transition {
      storage_class = "GLACIER"
      days = 90
    }

    expiration {
      days = 90
    }
  }
}