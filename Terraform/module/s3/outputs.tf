output "endpoint_web" {
  value = aws_s3_bucket_website_configuration.hosting.website_endpoint
}
