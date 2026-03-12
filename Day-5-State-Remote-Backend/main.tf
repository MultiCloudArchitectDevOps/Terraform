resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/17"
  tags = {
    Name = "test-vpc"
  }
}