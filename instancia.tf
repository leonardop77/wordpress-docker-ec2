#Instancia EC2
resource "aws_instance" "wordpress" {
  ami                         = "ami-031b2fee93f09355c"
  instance_type               = "t3a.small"
  key_name                    = "Instancia_ejm"
  subnet_id                   = aws_subnet.public-subnet.id
  security_groups             = [aws_security_group.sg_public.id]
  associate_public_ip_address = "false"

  tags = {
    Name = "wordpress"
  }
}

# Elastic IP
resource "aws_eip" "eip-proyecto" {
  domain = "vpc"
}

#Asociación IP elastica a EC2
resource "aws_eip_association" "eip_association" {
  instance_id   = aws_instance.wordpress.id
  allocation_id = aws_eip.eip-proyecto.id 
}

#Creación grupo de subredes para RDS
resource "aws_db_subnet_group" "gsub_rds_db" {
  name       = "gsub_rds_db"
  subnet_ids = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id, aws_subnet.private-subnet-3.id]
}

#Instancia RDS
resource "aws_db_instance" "restored_db" {
  identifier                = "db-la-huerta"
  instance_class            = "db.t3.micro"
  snapshot_identifier       = "snapshot-huerta"
  skip_final_snapshot       = true
  final_snapshot_identifier = "snapshot-rds"
  db_subnet_group_name      = aws_db_subnet_group.gsub_rds_db.id
  vpc_security_group_ids    = [aws_security_group.sg_rds.id]

  tags = {
    Name = "db-la-huerta"
  }
}
