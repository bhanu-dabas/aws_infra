provider "aws" {
  region = "us-east-1"
}

# vpc
resource "aws_vpc" "deploy_vpc" {
  cidr_block       = "10.0.0.0/20"
  instance_tenancy = "default"

  tags = {
    Name = "sonarqube"
  }
}

# internet gateway

resource "aws_internet_gateway" "deploy_igw" {
  vpc_id = aws_vpc.deploy_vpc.id

  tags = {
    Name = "sonar-igw"
  }
}

# elastic ip address

resource "aws_eip" "deploy_elasticip" {
  domain = "vpc"
  tags = {
    Name = "sonar-elasticip"
  }
}

# nat gateway

resource "aws_nat_gateway" "deploy_nat_gateway" {
  allocation_id = aws_eip.deploy_elasticip.id
  subnet_id     = aws_subnet.deploy_subnet_public.id

  tags = {
    Name = "sonar-nat-gateway"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPCaws_internet_gateway.
  depends_on = [aws_internet_gateway.deploy_igw]
}


# data block for existing vpc

data "aws_vpc" "selected" {
  id = "vpc-0245854b4a435e0da"
}

data "aws_subnet" "selected" {
  id = "subnet-039ee64352aed0598"
}







