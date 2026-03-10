provider "aws" {
}

provider "aws" {
    region = "us-east-2"
    profile = "test"
    alias = "testenv"
}