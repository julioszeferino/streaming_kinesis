provider "aws" {
  region = var.aws_region
}

terraform {
    backend "s3" {
        # esse bucket precisa existir no s3
        bucket = "terraform-state-igti-julio" 
        key    = "state/igti/edc/mod1/terraform.tfstate"
        region = "us-east-2"
    }
}