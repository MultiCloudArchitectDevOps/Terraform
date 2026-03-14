terraform {
  backend "s3" {
    bucket = "tf-5161-test-s3-yd"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-state-lock-dynamodb"
  }
}
