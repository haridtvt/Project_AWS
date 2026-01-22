output "endpoint_web" {
  value = aws_s3_bucket_website_configuration.hosting.website_endpoint
}

output "frontend_bucket_name" {
  value = aws_s3_bucket.s3_bucket.bucket
}