#Creación VPC
resource "aws_vpc" "vpc-proyecto" {
  cidr_block = "10.20.0.0/16"
  tags = {
    Name = "VPC-Proyecto"
  }
}

#Creación Subnet Publica
resource "aws_subnet" "public-subnet" {
  vpc_id            = aws_vpc.vpc-proyecto.id
  cidr_block        = "10.20.4.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Public-subnet"
  }
}

#Creación Subnets Privadas
resource "aws_subnet" "private-subnet-1" {
  vpc_id            = aws_vpc.vpc-proyecto.id
  cidr_block        = "10.20.5.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Private-subnet-1"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id            = aws_vpc.vpc-proyecto.id
  cidr_block        = "10.20.6.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Private-subnet-2"
  }
}

resource "aws_subnet" "private-subnet-3" {
  vpc_id            = aws_vpc.vpc-proyecto.id
  cidr_block        = "10.20.7.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "Private-subnet-3"
  }
}

#Creación Internet Gateway
resource "aws_internet_gateway" "gw-proyecto" {
  vpc_id = aws_vpc.vpc-proyecto.id

  tags = {
    Name = "Gw-proyecto"
  }
}

#Route Table Publica
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc-proyecto.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw-proyecto.id
  }

  tags = {
    Name = "Public-RT"
  }
}

#Route Table Privada
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.vpc-proyecto.id

  tags = {
    Name = "Private-RT"
  }
}

#Asociación tablas de enrutamiento
resource "aws_route_table_association" "public-1" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "private-1" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "private-2" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "private-3" {
  subnet_id      = aws_subnet.private-subnet-3.id
  route_table_id = aws_route_table.private-rt.id
}