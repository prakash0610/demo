variable "environment" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "project" {
  type = string
}

variable "ami_id" {
  description = "AMI for EC2 instance"
  type        = string
}

variable "instance_type" {
  default = "t2.micro"
}

