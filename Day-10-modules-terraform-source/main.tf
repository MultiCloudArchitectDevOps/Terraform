module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  instance_type = "t3.micro"
  subnet_id     = "subnet-037f16a676bc117eb"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}