resource "random_password" "mysql_password" {
  length           = 16
  lower            = true
  upper            = true
  numeric          = true
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_secretsmanager_secret" "mysql_db_credentials" {
  name = "${var.environment}-${var.project}-mysql-cred"
}

locals {
  mysql_username = "admin"
  mysql_password = random_password.mysql_password.result
}

resource "aws_secretsmanager_secret_version" "example" {
  secret_id = aws_secretsmanager_secret.mysql_db_credentials.id
  secret_string = jsonencode({
    username = local.mysql_username
    password = local.mysql_password
  })
}

resource "aws_db_instance" "mysql" {
  identifier             = "${var.environment}-${var.project}-mysql"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_name                = "demodb"
  username               = local.mysql_username
  password               = local.mysql_password
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true
  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.mysql_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  multi_az               = false
  storage_encrypted      = true

  tags = {
    Name = "${var.environment}-${var.project}-mysql"
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_cpu_high" {
  alarm_name          = "${var.environment}-${var.project}-rds-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "RDS instance CPU usage > 80%"
  #alarm_actions       = [var.alarm_sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.mysql.id
  }
}
