output "bucket_name" {
  value = aws_s3_bucket.private_docs.id
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = aws_subnet.public[*].id
}

output "private_subnets" {
  value = aws_subnet.private[*].id
}

output "rds_sg" {
  value = aws_security_group.rds_sg.id
}

output "ec2_sg" {
  value = aws_security_group.ec2_sg.id
}

output "alb_sg" {
  value = aws_security_group.alb_sg.id
}

output "db_endpoint" {
  value = aws_db_instance.mysql.endpoint
}

output "db_name" {
  value = aws_db_instance.mysql.db_name
}
