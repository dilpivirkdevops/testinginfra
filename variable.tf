variable "vpc_cidr" {
  default = "1.0.0.0/0"
}

variable "vpc_public_subnet_cidr" {
  default = "0.0.0.0/0"
}

variable "vpc_private_subnet_cidr" {
  default = "0.0.0.0/0"
}

variable "vpc_public_subnet_az" {
  default = "us-east-1"
}

variable "vpc_private_subnet_az" {
  default = "us-east-1"
}

## Tags

variable "tag_name" {
  default = "demoforinterview"
}

variable "tag_type" {
  default = "networking"
}

variable "tag_environment" {
  default = "demoforinterview"

}


# EC2 webserver variables

variable "web_ami" {
  default = "ami-005e54dee72cc1d00"
}

variable "web_instance_type" {
  default = "t2.micro"
}

variable "web_vpc_security_group_ids" {
  default = []
  type    = "list"
}

variable "web_key_name" {
  default     = "change me"
  description = "SSH key name. A valid key name is required."
}

variable "db_storage_size" {
  default = 10
}

variable "db_storage_type" {
  default = "gp2"
}

variable "db_engine" {
  default = "postgres"
}

variable "db_engine_version" {
  default = ""
}

variable "db_instance_class" {
  default = "db.t2.small"
}

variable "dilpreetkaurvirk" {
  description = "root user"
}

variable "4324235y8fdgedfgt3et" {
  description = "root password"
}

variable "db_subnet_ids" {
  type = "list"
}

## Tags

variable "tag_name" {
  default = "demo"
}

variable "tag_type" {
  default = "database"
}

variable "tag_environment" {
  default = "dev"
}

##Route53

variable "domain" {
    description = "coinberry.com"
}

variable "subdomain" {
    description = "example"
}

variable "type" {
    default = "CNAME"
}

variable "ttl" {
    default = 3600
}

variable "records" {
   
    type = "list"
}

variable "sshkey" {
    descripiton="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}
