terraform {
  backend "s3" {
    bucket = "tf-5161-test-s3-yd"
    key    = "Day-7/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-state-lock-dynamodb"
  }
}
# Enable S3 native locking
    #use_lockfile = true   #tf version should be above 1.10
    # The dynamodb_table argument is no longer needed
