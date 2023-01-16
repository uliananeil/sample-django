resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.terraform.id
  tags = {
    Name = "internet-gateway"
  }
}