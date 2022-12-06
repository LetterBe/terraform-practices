variable "amis" {
    type = map

    default = {
        "eu-central-1" = "ami-0caef02b518350c8b"
        "eu-west-1" = "ami-01cae1550c0adea9c"
    }
}

variable "cdirs_remote_access" {
    type = list

    default = ["194.169.217.0/24","45.0.0.0/8"]
}

variable "key_name" {
    // se nao type, o valor default é uma string
    default = "terraform-aws"
}