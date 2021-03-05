# VPC

resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags {
    Name        = "${var.tag_name}-main"
    Type        = "${var.tag_type}"
    Environment = "${var.tag_environment}"
  }
}

resource "aws_subnet" "main-public" {
  cidr_block              = "${var.vpc_public_subnet_cidr}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.vpc_public_subnet_az}"

  tags {
    Name = "${var.tag_name}-public"
  }
}

resource "aws_subnet" "main-private" {
  cidr_block              = "${var.vpc_private_subnet_cidr}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.vpc_private_subnet_az}"

  tags {
    Name = "${var.tag_name}-private"
  }
}

# IGW

resource "aws_internet_gateway" "main_igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.tag_name}-igw"
  }
}

# Routing tables

resource "aws_route_table" "main_rt" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main_igw.id}"
  }

  tags {
    Name = "${var.tag_name}-rt"
  }
}

resource "aws_route_table_association" "main-public" {
  route_table_id = "${aws_route_table.main_rt.id}"
  subnet_id      = "${aws_subnet.main-public.id}"

}

resource "aws_instance" "instance1" {
  ami           = "${var.web_ami}"
  instance_type = "${var.web_instance_type}"
  subnet_id              = "${aws_subnet.main-public.id}"
  vpc_security_group_ids = ["${var.web_vpc_security_group_ids}"]
  key_name               = "${var.web_key_name}"
}

resource "aws_instance" "instance2" {
  ami           = "${var.web_ami}"
  instance_type = "${var.web_instance_type}"

  subnet_id              = "${var.web_subnet_id}"
  vpc_security_group_ids = ["${var.web_vpc_security_group_ids}"]
  key_name               = "${var.web_key_name}"

  user_data = "${var.web_user_data}"
}
resource "aws_db_instance" "db" {
  allocated_storage      = "${var.db_storage_size}"
  storage_type           = "${var.db_storage_type}"
  engine                 = "${var.db_engine}"
  engine_version         = "${var.db_engine_version}"
  instance_class         = "${var.db_instance_class}"
  name                   = "main_db"
  username               = "${var.db_username}"
  password               = "${var.db_password}"
  vpc_security_group_ids = []

  db_subnet_group_name = "${aws_db_subnet_group.main_subnet_grp.name}"

  final_snapshot_identifier = "main-db-final"
  skip_final_snapshot       = "true"

  tags {
    Name        = "${var.tag_name}"
    Type        = "${var.tag_type}"
    Environment = "${var.tag_environment}"
  }
}

resource "aws_db_subnet_group" "main_subnet_grp" {
  subnet_ids = ["${var.db_subnet_ids}"]
}
#create application load balancer type
resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.web_vpc_security_group_ids}"]
  subnets            = "${var.web_subnet_id}"

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:8080/"
  }
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "8080"
    instance_protocol = "http"
  }
}

  enable_deletion_protection = true

  access_logs {
    bucket  = aws_s3_bucket.lb_logs.bucket
    prefix  = "test-lb"
    enabled = true
  }

  tags = {
    Environment = "${var.tag_environment}"
  }
}

resource "aws_lb_target_group_attachment" "test" {
  target_id        = ${ "aws_instance.instance1.id"}
  port             = 80
}


data "aws_route53_zone" "selected" {
    name = "${var.domain}"
}

resource "aws_route53_record" "record" {
    zone_id = "${data.aws_route53_zone.selected.zone_id}"
    name    = "${var.subdomain}.${var.domain}"

    type    = "${var.type}"
    ttl     = "${var.ttl}"
    records = [ "${var.records}" ]
}
