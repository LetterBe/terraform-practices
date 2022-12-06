provider "aws" {
    version = "~> 4.44"
    region  = "eu-central-1"
}

provider "aws" {
  // criar aalias para o provider nao ter nome repetido
    alias = "eu-west-1"
    version = "~> 4.44"
    region  = "eu-west-1"
}

resource "aws_instance" "dev" { 
    // quantas instancias quero criar 
    count = 3
    //se é instance, preciso da ami, do tipo de instância, do nome da chave, do security group
    // imagem , sempre olhar a aim da região
    ami = var.amis["eu-central-1"]
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

resource "aws_instance" "dev4" { 
    ami = var.amis["eu-central-1"]
    instance_type = "t2.micro" 
    key_name = var.key_name
    tags = {    
        Name = "dev4"
    }
    vpc_security_group_ids = ["${aws_security_group.acess-ssh.id}"]
    // vincular o este recurso ao buket s3 recurso.nomeDaAws 
    // a criacao/exclusao de um implica no outro
    depends_on = [aws_s3_bucket.dev4]
}

resource "aws_instance" "dev5" { 
    ami = var.amis["eu-central-1"]
    instance_type = "t2.micro" 
    key_name = var.key_name
    tags = {    
        Name = "dev5"
    }
    vpc_security_group_ids = ["${aws_security_group.acess-ssh.id}"]
}
// esta instancia está em outra regiao, precisa portanto de outro sg, ami
resource "aws_instance" "dev6" { 
  // preciso especificar qual a regiao com o provider
    provider = "aws.eu-west-1"
    ami = var.amis["eu-west-1"]
    instance_type = "t2.micro" 
    key_name = var.key_name
    tags = {    
        Name = "dev6"
    }
    vpc_security_group_ids = ["${aws_security_group.access-ssh-eu-west-1.id}"]
    depends_on = ["aws_dynamodb_table.dynamodb-test"]
}

// na AWS o bucket é multiregional e o nome é global
resource "aws_s3_bucket" "dev4" {
  bucket = "aluralab-dev4"
  //access control list, quem pode acessar o bucket, default é private
  acl = "private"

  tags = {
    Name = "aluralab-dev4"
  }
}

resource "aws_dynamodb_table" "dynamodb-test" {
  provider       = "aws.eu-west-1"
  name           = "GameScores"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "UserId"
  range_key      = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }
}  