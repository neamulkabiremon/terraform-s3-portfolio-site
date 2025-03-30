variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "bucket_prefix" {
  description = "Prefix for the S3 bucket name"
  type        = string
  default     = "mywebapp-bucket"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "Dev"
}