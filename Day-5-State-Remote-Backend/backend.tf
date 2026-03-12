terraform {
  backend "s3" {
    bucket = "tf-5161-test-s3"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
