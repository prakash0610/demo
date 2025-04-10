data "terraform_remote_state" "nonprod-shared" {
  backend = "s3"
  config = {
    bucket = "657433765911-tfstate-bucket"
    key    = "tf-state/nonprod-shared.tfstate"
    region = "us-east-1"
  }
}