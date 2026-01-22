output "rds_endpoint" {
  value       = aws_db_instance.db_mysql.endpoint
}
output "mysql_address" {
  value = aws_db_instance.db_mysql.address
}

output "secret_manager_name" {
  value       = aws_secretsmanager_secret.db_secret.name
}