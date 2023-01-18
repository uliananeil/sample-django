resource "aws_db_instance" "rds" {
  allocated_storage      = 3
  db_name                = "djangodb"
  engine                 = "postgres"
  instance_class         = "db.t3.micro"
  username               = "postgres"
  password               = var.rds_passwd
  vpc_security_group_ids = [aws_security_group.db-sg.id]
  db_subnet_group_name   = aws_db_subnet_group.vpc-db.id
  skip_final_snapshot    = true
  publicly_accessible    = true
}
##
resource "aws_db_subnet_group" "vpc-db" {
  name       = "subnetgroup"
  subnet_ids = [aws_subnet.http-1.id, aws_subnet.http-2.id]

}
