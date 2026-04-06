resource "aws_vpc" "Name" { 
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "1234"
  }
}
