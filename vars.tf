variable "amis" {
    type = map

    default = {
        "eu-central-1" = "ami-0caef02b518350c8b"
        "eu-west-1" = "ami-01cae1550c0adea9c"
    }
}