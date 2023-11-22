resource "aws_vpc" "rafs_tf_project" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "MyVPC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.rafs_tf_project.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a" 
  map_public_ip_on_launch = true
  tags = {
    Name = "PublicSubnet"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.rafs_tf_project.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.rafs_tf_project.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "PublicRouteTable"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}
