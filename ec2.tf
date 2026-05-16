resource "aws_instance" "website_server" {
  
  ami                    = "ami-094860656b50c0c5d" #Verificar na imagem da aws
  instance_type          = "t3.micro"
  key_name               = "key"
  vpc_security_group_ids =  [aws_security_group.website_sg2.id]
  iam_instance_profile = "infra"

  
    tags = {
    Name        = "website-server"
    Provisioned = "Terraform"
    Cliente     = "Maria"
  }
} 

## Security Group
resource "aws_security_group" "website_sg2" {
  name   = "website-sg2"
  vpc_id = "vpc-0ddeca3a9898772f3" #Criar na aws
   
    tags = {
    Name        = "website-sg2"
    Provisioned = "Terraform"
    Cliente     = "Maria"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.website_sg2.id
  cidr_ipv4         = "220.172.5.243/32"
   #verificar seu IP na instancia da aws
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.website_sg2.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.website_sg2.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.website_sg2.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}

