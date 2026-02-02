terraform {
  backend "s3" {
    bucket         = "terraform-state-test279"
    key            = "vpc/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true 
    # dynamodb_table = "terraform-locks"
  }
}
