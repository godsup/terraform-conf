# VPC creations
resource "aws_vpc" "vpc" {
  #can be var
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = {
    Name = "vpc"
  }
}

# SUBNETS

# Public
resource "aws_subnet" "public-a" {
  vpc_id     = aws_vpc.vpc.id
  count      = length(var.subnet_cidrs_public)
  cidr_block = var.subnet_cidrs_public[count.index]
  #cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zones[count.index]
  #availability_zone = "eu-central-1a"
  tags = {
    Name = "subnet-public-a"
  }
}

# Private
resource "aws_subnet" "private-a" {
  vpc_id = aws_vpc.vpc.id
  #can be var
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = false
  #can be var
  availability_zone = "eu-central-1a"
  tags = {
    Name = "subnet-private-a"
  }
}

# IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "igw"
  }
}

# ROUTE TABLE
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    #can be var
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "rt"
  }
}

# Route associations
resource "aws_route_table_association" "public-a-1" {
  #subnet_id = aws_subnet.public-a.id
  count          = length(var.subnet_cidrs_public)
  route_table_id = aws_route_table.rt.id
  subnet_id      = element(aws_subnet.public-a.*.id, count.index)
}