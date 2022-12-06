resource "aws_security_group" "acess-ssh" {
  name        = "acess-ssh"
  description = "acess-ssh"

// se fosse https seria 443 , protocolo tcp
  ingress {
    // port 22 é o ssh
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    // colocar meu ip de saída. groups of addresses that share the same prefix and contain the same number of bits
    cidr_blocks      = var.cdirs_remote_access
  }

  tags = {
    Name = "ssh"
  }
}

resource "aws_security_group" "access-ssh-eu-west-1" {
// provider especifica a regiao
  provider = "aws.eu-west-1"
  name        = "acess-ssh"
  description = "acess-ssh"

// se fosse https seria 443 , protocolo tcp
  ingress {
    // port 22 é o ssh
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    // colocar meu ip de saída. groups of addresses that share the same prefix and contain the same number of bits
    cidr_blocks      = var.cdirs_remote_access
  }

  tags = {
    Name = "ssh"
  }
}