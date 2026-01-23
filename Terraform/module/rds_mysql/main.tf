resource "aws_db_subnet_group" "subnet_db" {
  subnet_ids = [var.db_subnet_1, var.db_subnet_2]
  name = "main-db-subnet"
}

resource "aws_secretsmanager_secret" "db_secret_1" {
  name = "backend/rds/mysql-credentials"
  recovery_window_in_days = 0
}

resource "aws_db_instance" "db_mysql" {
  instance_class = var.db_class
  db_name = "mysql_name"
  allocated_storage = 20
  engine = "mysql"
  engine_version = "8.0"
  username          = var.db_uname
  password          = var.db_pass
  db_subnet_group_name = aws_db_subnet_group.subnet_db.name
  vpc_security_group_ids = [var.sg_db_id]
  publicly_accessible = false
  skip_final_snapshot = true
  tags = {
    Name = "store information"
  }
}

resource "aws_secretsmanager_secret_version" "db_secret_val" {
  secret_id     = aws_secretsmanager_secret.db_secret_1.id
  secret_string = jsonencode({
    username = var.db_uname
    password = var.db_pass
    host     = aws_db_instance.db_mysql.address
    port     = 3306
  })
}