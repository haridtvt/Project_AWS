resource "aws_vpc" "VPC" {
  cidr_block = var.cidr_block
  tags = {
    Terraform = "true"
    Environment = "Main_VPC"
  }
}

resource "aws_internet_gateway" "IGW_az1" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name = "main_IGW1"
  }
}

resource "aws_subnet" "public_az1" {
  vpc_id = aws_vpc.VPC.id
  cidr_block = var.cidr_block_public_1
  availability_zone = var.zone_1
  map_public_ip_on_launch = true
  tags = {
    Name = "Public_subnet-1"
  }
}

resource "aws_subnet" "public_az2" {
  vpc_id = aws_vpc.VPC.id
  cidr_block = var.cidr_block_public_2
  map_public_ip_on_launch = true
  availability_zone = var.zone_2
  tags = {
    Name = "Public_subnet-2"
  }
}

resource "aws_subnet" "private_az1" {
  vpc_id = aws_vpc.VPC.id
  cidr_block = var.cidr_block_private_1
  availability_zone = var.zone_1
  tags = {
    Name = "Private_subnet-1"
  }
}

resource "aws_subnet" "private_az2" {
  vpc_id = aws_vpc.VPC.id
  cidr_block = var.cidr_block_private_2
  availability_zone = var.zone_2
  tags = {
    Name = "Private_subnet-2"
  }
}

resource "aws_eip" "EIP_az1" {
  domain = "vpc"
}

resource "aws_eip" "EIP_az2" {
  domain = "vpc"
}

resource "aws_nat_gateway" "NAT_az1" {
  subnet_id = aws_subnet.public_az1.id
  allocation_id = aws_eip.EIP_az1.id
  tags = {
    Name = "Main_NAT1"
  }
}

resource "aws_nat_gateway" "NAT_az2" {
  subnet_id = aws_subnet.public_az2.id
  allocation_id = aws_eip.EIP_az2.id
  tags = {
    Name = "Main_NAT2"
  }
}

resource "aws_route_table" "public_az1" {
  vpc_id = aws_vpc.VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW_az1.id
  }
}

resource "aws_route_table" "public_az2" {
  vpc_id = aws_vpc.VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW_az1.id
  }
}

resource "aws_route_table_association" "ass_public_az1" {
  subnet_id = aws_subnet.public_az1.id
  route_table_id = aws_route_table.public_az1.id
}

resource "aws_route_table_association" "ass_public_az2" {
  subnet_id = aws_subnet.public_az2.id
  route_table_id = aws_route_table.public_az2.id
}

resource "aws_route_table" "private_to_nat1" {
  vpc_id = aws_vpc.VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT_az1.id
  }
}

resource "aws_route_table" "private_to_nat2" {
  vpc_id = aws_vpc.VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT_az2.id
  }
}

resource "aws_route_table_association" "ass_private_az1" {
  subnet_id = aws_subnet.private_az1.id
  route_table_id = aws_route_table.private_to_nat1.id
}

resource "aws_route_table_association" "ass_private_az2" {
  subnet_id = aws_subnet.private_az2.id
  route_table_id = aws_route_table.private_to_nat2.id
}