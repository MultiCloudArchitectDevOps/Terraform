# Creation of VPC, Public Subnet, Private Subnet, Internet Gateway, Elastic IP for NAT, NAT Gateway,
# Public Route Table, Associate Public Subnet, Private Route Table, Associate Private Subnet,
# EC2 Instance, and Security Group

resource "aws_vpc" "prod" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "VPC"
    
    }
}

#public subnet
resource "aws_subnet" "public" {
    vpc_id = aws_vpc.prod.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "Public-Subnet"
    }
}

#private subnet
resource "aws_subnet" "private" {
    vpc_id = aws_vpc.prod.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "Private-Subnet"
    }
}

resource "aws_internet_gateway" "prod" {
    vpc_id = aws_vpc.prod.id
    tags = {
        Name = "Internet-Gateway"
    }
}

resource "aws_route_table" "prod" {
  vpc_id = aws_vpc.prod.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.prod.id

    }
}

resource "aws_route_table_association" "prod" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.prod.id
}

resource "aws_security_group" "prod" {
    name = "prod-sg"
    description = "Allow SSH and HTTP traffic"
    vpc_id = aws_vpc.prod.id
    
    #inbound rule to allow SSH traffic
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    #outbound rule to allow all traffic
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "prod" {
    ami = "ami-02dfbd4ff395f2a1b"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public.id
    vpc_security_group_ids = [aws_security_group.prod.id]
    tags = {
        Name = "EC2-Instance"
    }
    
}