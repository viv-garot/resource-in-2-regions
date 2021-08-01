provider "aws" {
  region = "eu-central-1"
}

provider "aws" {
  region = "eu-north-1"
  alias  = "euN"
}

resource "aws_vpc" "vpc-central" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_vpc" "vpc-north" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  provider             = aws.euN
}

output "vpc-central" {
  value = aws_vpc.vpc-central.id
}

output "vpc-north" {
  value = aws_vpc.vpc-north.id
}
