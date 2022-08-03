provider "aws"{
    region = "sa-east-1"
}

resource "aws_instance" "vm-priv" {
  ami           = "ami-0800f9916b7655289" # São Paulo
  instance_type = "t2.micro"
  key_name = "pc-king"
  tags = {
    Name = "vm-priv"
  }
  vpc_security_group_ids = ["${aws_security_group.porta-priv.id}"]
  depends_on = [aws_security_group.porta-priv]
}

resource "aws_instance" "vm-plub" {
  ami           = "ami-0800f9916b7655289" # São Paulo
  instance_type = "t2.micro"
  key_name = "pc-king"
  tags = {
    Name = "vm-public"
  }
  vpc_security_group_ids = ["${aws_security_group.porta-publi.id}"]
  depends_on = [aws_security_group.porta-publi]
}

resource "aws_security_group" "porta-publi" {
  name        = "libera-porta-publ"
  description = "Liberando porta publica 80 "

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] # liberando porta public 
    // ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block] opcional
  }
}
resource "aws_security_group" "porta-priv" {
  name        = "libera-porta-priv"
  description = "Liberando porta publica 22 "

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["138.36.41.193/32"] # liberando porta privada  
  }

}