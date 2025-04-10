terraform {
  required_version = "1.9.2"
  backend "s3" {
    bucket         = "657433765911-tfstate-bucket"
    key            = "tf-state/dev.tfstate"
    region         = "us-east-1"
    dynamodb_table = "657433765911-terraform-state-lock"
    encrypt        = true
  }
}