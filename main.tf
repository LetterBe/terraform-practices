provider "aws" {
    version = "~> 4.44"
    region  = "eu-central-1"
}

resource "aws_instance" "dev" { 
    // quantas instancias quero criar 
    count = 3
    //se é instance, preciso da ami, do tipo de instância, do nome da chave, do security group
    // imagem , sempre olhar a aim da região
    ami = "ami-0caef02b518350c8b"
    // tipo da instância, no caso free tier
    instance_type = "t2.micro" 
    // criar uma chave no ec2, na mesma regiao da instancia
    key_name = "terraform-aws"
    //marcar e dar nome aos recursos
    tags = {
    // nome do recurso. Para que cada instancia receba um nome diferente, é preciso usar o count.index.    
        Name = "dev${count.index}"
    }
    // usar o id do grup, reference ${aws_security_group.name.id}
    vpc_security_group_ids = ["${aws_security_group.acess-ssh.id}"]
}

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
    cidr_blocks      = ["194.169.217.0/24"]
  }

  tags = {
    Name = "shh"
  }
}
// na AWS o bucket é multiregional e o nome é global
resource "aws_s3_bucket" "dev4" {
  bucket = "aluralab-dev4"
  //access control list, quem pode acessar o bucket, default é private
  acl = "private"

  tags = {
    Name        = "aluralab-dev4"
  }
}