output "s3_bucket_name" {
  value = module.persistent.bucket_name
}

output "vpc_id" {
  value = module.persistent.vpc_id
}

output "public_subnets" {
  value = module.persistent.public_subnets
}

output "private_subnets" {
  value = module.persistent.private_subnets
}

output "rds_sg" {
  value = module.persistent.rds_sg
}

output "ec2_sg" {
  value = module.persistent.ec2_sg
}

output "alb_sg" {
  value = module.persistent.alb_sg
}

output "db_endpoint" {
  value = module.persistent.db_endpoint
}

output "db_name" {
  value = module.persistent.db_name
}