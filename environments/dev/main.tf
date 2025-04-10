data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
}

module "demo" {
  source          = "../../modules/demo"
  environment     = var.environment
  aws_region      = var.aws_region
  account_id      = local.account_id
  project         = var.project
  vpc_id          = data.terraform_remote_state.nonprod-shared.outputs.vpc_id
  ec2_sg          = data.terraform_remote_state.nonprod-shared.outputs.ec2_sg
  alb_sg          = data.terraform_remote_state.nonprod-shared.outputs.alb_sg
  public_subnets  = data.terraform_remote_state.nonprod-shared.outputs.public_subnets
  private_subnets = data.terraform_remote_state.nonprod-shared.outputs.private_subnets
  ami_id          = var.ami_id
  instance_type   = var.instance_type
  logs_bucket     = data.terraform_remote_state.nonprod-shared.outputs.s3_bucket_name
}
