resource "aws_vpc" "prod-vpc" {
    cidr_block = var.VPC_CIDR
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    #enable_classiclink = "false"
    instance_tenancy = "default"

    tags = {
        Name = var.VPC_NAME

    }
}

resource "aws_subnet" "prod-subnet-public-1" {
    vpc_id = "${aws_vpc.prod-vpc.id}"
    cidr_block = var.SUBNET_CIDR[0]
    map_public_ip_on_launch = "true" //it makes this a public subnet
    availability_zone = "ap-south-1a"

    tags = {
        Name = "prod-subnet-public-1"
    }
}

resource "aws_subnet" "prod-subnet-public-2" {
    vpc_id = "${aws_vpc.prod-vpc.id}"
    cidr_block = var.SUBNET_CIDR[1]
    map_public_ip_on_launch = "true" //it makes this a public subnet
    availability_zone = "ap-south-1b"

    tags = {
        Name = "prod-subnet-public-2"
    }
}

resource "aws_subnet" "prod-subnet-private-1" {
  vpc_id = "${aws_vpc.prod-vpc.id}"
  cidr_block = var.SUBNET_CIDR[2]
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = false

  tags = {
        Name = "prod-subnet-private-1"
    }
}
