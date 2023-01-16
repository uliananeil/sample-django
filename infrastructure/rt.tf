resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.terraform.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "rta-1" {
  subnet_id      = aws_subnet.http-1.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "rta-2" {
  subnet_id      = aws_subnet.http-2.id
  route_table_id = aws_route_table.rt.id
}