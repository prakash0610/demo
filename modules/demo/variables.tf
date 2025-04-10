variable "environment" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "account_id" {
  type = string
}

variable "project" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ec2_sg" {
  type = string
}

variable "alb_sg" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "ami_id" {
  description = "AMI for EC2 instance"
  type        = string
}

variable "instance_type" {
  default = "t2.micro"
}

variable "logs_bucket" {
  type = string
}
