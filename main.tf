terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Random suffix for unique bucket name
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# S3 Bucket creation without ACL
resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "${var.bucket_prefix}-${random_id.bucket_suffix.hex}"

  tags = {
    Name        = "MyS3Bucket"
    Environment = var.environment
  }
}

# Ownership controls (disable ACL support)
resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.my_s3_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# Public access settings – allow public access
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.my_s3_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Bucket policy to allow public read access
resource "aws_s3_bucket_policy" "my_s3_bucket" {
  bucket = aws_s3_bucket.my_s3_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = ["s3:GetObject"],
        Resource  = ["arn:aws:s3:::${aws_s3_bucket.my_s3_bucket.bucket}/*"]
      }
    ]
  })
}

# Enable static website hosting
resource "aws_s3_bucket_website_configuration" "my_s3_bucket" {
  bucket = aws_s3_bucket.my_s3_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Upload all DevFolio site files
resource "aws_s3_object" "website_files" {
  for_each = fileset("${path.module}/DevFolio", "**")

  bucket       = aws_s3_bucket.my_s3_bucket.id
  key          = each.value
  source       = "${path.module}/DevFolio/${each.value}"
  content_type = lookup({
    html = "text/html"
    css  = "text/css"
    js   = "application/javascript"
    png  = "image/png"
    jpg  = "image/jpeg"
    jpeg = "image/jpeg"
    svg  = "image/svg+xml"
    ico  = "image/x-icon"
    json = "application/json"
    php  = "application/x-httpd-php"
    txt  = "text/plain"
    scss = "text/x-scss"
  }, lower(reverse(split(".", each.value))[0]), "application/octet-stream")
}

