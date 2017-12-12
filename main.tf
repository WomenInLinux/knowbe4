provider "aws" {
	region = "${var.region}"
}

resource "aws_security_group" "knowbe4-sg" {
    name = "vpc_rules"
    description = "Allow traffic to pass from the private subnet to the internet"
        
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] 
    }   
    ingress {
        from_port = 443
        to_port = 443 
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

#module "vpc" {
#  source = "terraform-aws-modules/vpc/aws"
#  name = "knowbe4-dev"
#  cidr = "10.0.0.0/16"
#}

resource "aws_vpc" "knowbe4-dev" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_hostnames = true
  instance_tenancy = "dedicated"
  tags {
    Name = "knowbe4-dev"
  }
}

resource "aws_subnet" "knowbe4-dev-public" {
  vpc_id     = "${aws_vpc.knowbe4-dev.id}"
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags {
    Name = "knowbe4-dev-public"
  }
}

resource "aws_subnet" "knowbe4-dev-private" {
  vpc_id     = "${aws_vpc.knowbe4-dev.id}"
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1a"

  tags {
    Name = "knowbe4-dev-private"
  }
}

resource  "aws_ecs_cluster" "knowbe4-setup" {
	name = "knowbe4-dev"
}

resource "aws_instance" "knowbe4ami" {
	ami = "ami-fad25980"
	instance_type = "${var.instance_type}"
	associate_public_ip_address = true
	availability_zone = "us-east-1a"
	subnet_id = "${aws_subnet.knowbe4-dev-public.id}"
}

#resource "aws_instance" "knowbe4ami" {
#	ami = "ami-fad25980"
#	instance_type = "${var.instance_type}" 
#	associate_public_ip_address =  true
#	subnet_id = "${aws_subnet.knowbe4-dev-public.id}"
#	#security_groups = ["${aws_security_group.knowbe4-sg.id}"]
#	tags {
#    Name = "knowbe4-dev-insta"
#  }
#}
#
#resource "aws_eip" "base" {
#        instance = "${aws_instance.knowbe4ami.id}"
#        vpc = true
#}

