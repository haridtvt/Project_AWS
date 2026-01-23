output "rds_endpoint" {
  value  = aws_db_instance.db_mysql.endpoint
}

output "rds_endpoint_port" {
  value  = aws_db_instance.db_mysql.port
}

output "mysql_address" {
  value = aws_db_instance.db_mysql.address
}

output "secret_manager_name" {
  value       = aws_secretsmanager_secret.db_secret_1.name
}

output "secret_manager_arn" {
  value       = aws_secretsmanager_secret.db_secret_1.arn
}