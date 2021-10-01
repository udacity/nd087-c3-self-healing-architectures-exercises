terraform {
  backend "s3" {
    bucket = "udacity-tf-emmanuel-student" # Update here with your S3 bucket
    key    = "terraform/lesson3-ex-2.tfstate"
    region = "us-east-2"
  }
}

provider "aws" {
  region = "us-east-2"

  default_tags {
    tags = local.tags
  }
}