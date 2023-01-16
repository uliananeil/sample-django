resource "aws_subnet" "http-1" {
  vpc_id     = aws_vpc.terraform.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "subnet-http-1"
  }
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_subnet" "http-2" {
  vpc_id     = aws_vpc.terraform.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "subnet-http-2"
  }
  depends_on = [aws_internet_gateway.gw]
}
