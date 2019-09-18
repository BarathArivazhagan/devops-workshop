
resource "aws_s3_bucket" "demo_s3_bucket" {
  bucket = var.bucket_name
  versioning {
    enabled = true
  }

}