# Output the website URL
output "website_url" {
  value = aws_s3_bucket_website_configuration.my_s3_bucket.website_endpoint
}