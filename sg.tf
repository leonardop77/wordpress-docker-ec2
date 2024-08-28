#SG Instancia EC2
resource "aws_security_group" "sg_public" {
  name        = "sg_public"
  description = "grupo de seguridad para la instancia EC2"
  vpc_id      = aws_vpc.vpc-proyecto.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "SG-Public"
  }
}

#SG RDS
resource "aws_security_group" "sg_rds" {
  name        = "sg_rds"
  description = "grupo de seguridad para la instancia RDS"
  vpc_id      = aws_vpc.vpc-proyecto.id
  #Reglas de Entrada
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_public.id]
  }

  tags = {
    Name = "SG_RDS"
  }
}