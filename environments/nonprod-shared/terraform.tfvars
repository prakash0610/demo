environment          = "nonprod-shared"
aws_region           = "us-east-1"
project              = "demo"
vpc_cidr             = "10.0.0.0/24"
public_subnet_cidrs  = ["10.0.0.0/26", "10.0.0.64/26"]
private_subnet_cidrs = ["10.0.0.128/26", "10.0.0.192/26"]
azs                  = ["us-east-1a", "us-east-1b"]
