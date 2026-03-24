# Creation of VPC, Public Subnet, Private Subnet, Internet Gateway, Elastic IP for NAT, NAT Gateway,
# Public Route Table, Associate Public Subnet, Private Route Table, Associate Private Subnet,
# EC2 Instance, and Security Group

#VPC
resource "aws_vpc" "prod" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "VPC"
    
    }
}

#Public Subnet
resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.prod.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "Public-Subnet"
    }
}

#Private Subnet
resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.prod.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "Private-Subnet"
    }
}

#Internate Gateway
resource "aws_internet_gateway" "prod" {
    vpc_id = aws_vpc.prod.id
    tags = {
        Name = "Internet-Gateway"
    }
}

# Elastic IP for NAT 
resource "aws_eip" "nat_eip" {
    domain = "vpc"
    tags = {
      Name = "Elastic IP"
    }
}

# NAT Gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "Main-NAT-Gateway"
  }

  depends_on = [aws_internet_gateway.prod]
}

# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.prod.id
  tags = {
    Name = "Public Route Table"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod.id
}
}

# Associate Public Subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.prod.id
 tags = {
    Name = "Private Route Table"
  }
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
}

# Associate Private Subnet
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

#Security Group
resource "aws_security_group" "prod" {
    name = "prod-sg"
    description = "Allow SSH and HTTP traffic"
    vpc_id = aws_vpc.prod.id
    
    #Inbound rule to allow SSH traffic
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

    #Outbound rule to allow all traffic
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

#EC2 Instance
resource "aws_instance" "prod" {
    ami = "ami-02dfbd4ff395f2a1b"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public_subnet.id
    vpc_security_group_ids = [aws_security_group.prod.id]
    tags = {
        Name = "EC2-Instance"
    }
    
}