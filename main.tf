# creating aws nertworking for a project

resource "aws_vpc" "Rock_test-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "Rock_test-vpc"
  }
}

# creating public subnet

resource "aws_subnet" "Rock-test-pub-subnet1" {
  vpc_id     = aws_vpc.Rock_test-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Rock-test-pub-subnet1"
  }
}



resource "aws_subnet" "Rock-test-pub-subnet2" {
  vpc_id     = aws_vpc.Rock_test-vpc.id
  cidr_block = "10.0.2.0/24"
}


# creating private subnet

resource "aws_subnet" "Rock-test-priv-subnet1" {
  vpc_id     = aws_vpc.Rock_test-vpc.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "Rock-test-priv-subnet1"
  }
}


resource "aws_subnet" "Rock-test-priv-subnet2" {
  vpc_id     = aws_vpc.Rock_test-vpc.id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "Rock-test-priv-subnet2"
  }
}

# creating public route table

resource "aws_route_table" "Rock-test-pub-route1" {
  vpc_id = aws_vpc.Rock_test-vpc.id


  tags = {
    Name = "Rock-test-pub-route1"
  }
}

# creating private route table

resource "aws_route_table" "Rock-test-priv-route1" {
  vpc_id = aws_vpc.Rock_test-vpc.id


  tags = {
    Name = "Rock-test-priv-route1"
  }
}

# association public subnet with the public route table

resource "aws_route_table_association" "Rock-test-pub-association1" {
  subnet_id      = aws_subnet.Rock-test-pub-subnet1.id
  route_table_id = aws_route_table.Rock-test-pub-route1.id
}

resource "aws_route_table_association" "Rock-test-pub-association2" {
  subnet_id      = aws_subnet.Rock-test-pub-subnet2.id
  route_table_id = aws_route_table.Rock-test-pub-route1.id
}

# associating private subnet with the private route table

resource "aws_route_table_association" "Rock-test-priv-association1" {
  subnet_id      = aws_subnet.Rock-test-priv-subnet1.id
  route_table_id = aws_route_table.Rock-test-priv-route1.id
}

resource "aws_route_table_association" "Rock-test-priv-association2" {
  subnet_id      = aws_subnet.Rock-test-priv-subnet2.id
  route_table_id = aws_route_table.Rock-test-priv-route1.id
}

# internet gateway

resource "aws_internet_gateway" "Rock-test-IGW" {
  vpc_id = aws_vpc.Rock_test-vpc.id

  tags = {
    Name = "Rock-test-IGW"
  }
}

# association internert gateway to the public route table

resource "aws_route" "Rock-IGW-attachment" {
  route_table_id         = aws_route_table.Rock-test-pub-route1.id
  gateway_id             = aws_internet_gateway.Rock-test-IGW.id
  destination_cidr_block = "0.0.0.0/0"
}