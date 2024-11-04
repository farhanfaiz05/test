### VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = var.name
  }
}

### To fetch availability zones in the required region
data "aws_availability_zones" "available" {}

### VPC Subnets
resource "aws_subnet" "private_subnet1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet1_cidr
  availability_zone = data.aws_availability_zones.available.names[0]  
  tags = {
    Name = "${var.name}-Private-Subnet1"
  }
  depends_on = [ aws_vpc.vpc ]
}

resource "aws_subnet" "private_subnet2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet2_cidr
  availability_zone = data.aws_availability_zones.available.names[1]  
  tags = {
    Name = "${var.name}-Private-Subnet2"
  }
  depends_on = [ aws_vpc.vpc ]
}

resource "aws_subnet" "public_subnet1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet1_cidr
  availability_zone = data.aws_availability_zones.available.names[1]  
  tags = {
    Name = "${var.name}-Public-Subnet2"
  }
  depends_on = [ aws_vpc.vpc ]
}

resource "aws_subnet" "public_subnet2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet2_cidr
  availability_zone = data.aws_availability_zones.available.names[1]  
  tags = {
    Name = "${var.name}-Private-Subnet2"
  }
}


### Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.name}-IGW"
  }
}

#Elastic IP for NAT gatewat
resource "aws_eip" "nat" {
    tags = {
    Name = "${var.name}-EIP"
  }
}

#NAT Gateway
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet1.id

  tags = {
    Name = "${var.name}-NAT"
  }
}

### Route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id  
  }

  tags = {
    Name = "${var.name}-Public-Route-Table"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "${var.name}-Private-Route-Table"
  }
}

### Route table assosciation
resource "aws_route_table_association" "private_subnet1_association" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet2_association" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "public_subnet1_association" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet2_association" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_route_table.id
}



