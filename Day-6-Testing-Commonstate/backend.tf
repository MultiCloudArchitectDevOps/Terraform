terraform {
  backend "s3" {
    bucket = "tf-5161-test-s3-yd"
    key    = "Day-1/terraform.tfstate"
    region = "us-east-1"
  }
}
