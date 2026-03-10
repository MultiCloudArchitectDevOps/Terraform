resource "aws_instance" "dev" { 
    ami = var.dev_ami_id
    instance_type = var.dev_instance_type
    tags = {
        name = "dev_ec2"
    }  
}
resource "aws_instance" "test" { 
    ami = var.test_ami_id
    instance_type = var.test_instance_type
    provider = aws.testenv
    tags = {
        name = "test_ec2"
    }  
}