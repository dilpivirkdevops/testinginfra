variable "vpc_cidr" {
  default = "0.0.0.0/0"
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
    description = "Domain used for the Route53 Hosted Zone"
}

variable "subdomain" {
    description = "The subdomain that you want to add as a new record"
}

variable "type" {
    description = "Type of the record (e.g. A, MX, CNAME..)"
    default = "A"
}

variable "ttl" {
    description = "Time to live of the record"
    default = 3600
}

variable "records" {
    description = "The list of records to be associated with the subdomain"
    type = "list"
}
