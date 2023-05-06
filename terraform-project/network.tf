# create an IGW (Internet Gateway)
# It enables your vpc to connect to the internet
resource "aws_internet_gateway" "prod-igw" {
    vpc_id = "${aws_vpc.prod-vpc.id}"

    tags = {
        Name = "prod-igw"
    }
}

# create a custom route table for public subnets
# public subnets can reach to the internet buy using this
resource "aws_route_table" "prod-public-crt" {
    vpc_id = "${aws_vpc.prod-vpc.id}"
    route {
        cidr_block = "0.0.0.0/0" //associated subnet can reach everywhere
        gateway_id = "${aws_internet_gateway.prod-igw.id}" //CRT uses this IGW to reach internet
    }

    tags = {
        Name = "prod-public-crt"
    }
}

# route table association for the public subnets
resource "aws_route_table_association" "prod-crt-public-subnet-1" {
    subnet_id = "${aws_subnet.prod-subnet-public-1.id}"
    route_table_id = "${aws_route_table.prod-public-crt.id}"
}

# Elastic-IP (eip) for NAT
resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.prod-igw]
}

# NAT
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.prod-subnet-public-1.id

  tags = {
    Name        = "nat"
  }
}

# Routing tables to route traffic for Private Subnet
resource "aws_route_table" "prod-private-crt" {
 
  vpc_id = "${aws_vpc.prod-vpc.id}"

    tags = {
        Name = "prod-private-crt"
    }
}


resource "aws_route_table_association" "private" {

   subnet_id = "${aws_subnet.prod-subnet-private-1.id}"
   route_table_id = "${aws_route_table.prod-private-crt.id}"
}


############# security group  #############################################
resource "aws_security_group" "ssh-allowed" {

    vpc_id = "${aws_vpc.prod-vpc.id}"

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        
        // This means, all ip address are allowed to ssh !
        // Do not do it in the production. Put your office or home address in it!
        cidr_blocks = ["0.0.0.0/0"]
    }

    //If you do not add this rule, you can not reach the NGIX
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }  

    tags = {
        Name = "ssh-allowed"
    }
}
