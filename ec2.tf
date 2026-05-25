resource "aws_instance" "webserver" {
  ami           = "ami-00a9f44477dd83e3d"
  instance_type = "t3.micro"
  key_name   = "chavekey.pem"
 vpc_security_group_ids = [aws_security_group.website.id]
  iam_instance_profile = "infra"

tags = {
  Name = "webserver"
  Provisioned = "Terraform"
  Cliente = "Nave"
  }
}

resource "aws_security_group" "website" {
  name = "website"
  vpc_id = "vpc-0ddeca3a9898772f3"

  tags = {
    Name = "webserver"
    Provisioned = "Terraform"
    Cliente = "Elias"
  }

}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
    security_group_id = aws_security_group.website.id
    cidr_ipv4 = "200.172.5.243/32"
    from_port = 22
    ip_protocol = "tcp"
    to_port = 22

  
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
    security_group_id = aws_security_group.website.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 80
    ip_protocol = "tcp"
    to_port = 80

  
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
    security_group_id = aws_security_group.website.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 443
    ip_protocol = "tcp"
    to_port = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_all_outbound" {
    security_group_id = aws_security_group.website.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1"

}
