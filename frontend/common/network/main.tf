resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "${var.env}-internet-gateway"
    }
}

# Public

# Public Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.env}-public-route-table"
  }
}


# public Subnets
resource "aws_subnet" "public_subnet" {
    count = var.public_subnet_count
    vpc_id = aws_vpc.vpc.id
    cidr_block = cidrsubnet(var.pulbic_subnet_cidr_block, 8, count.index)
    tags = {
        Name = "${var.env}-public-subnet-${count.index + 1}"
    }
}

# subnets <-> route table
resource "aws_route_table_association" "public_subnet_route_table" {
    count = var.public_subnet_count
    subnet_id = aws_subnet.public_subnet[count.index].id
    route_table_id = aws_route_table.public_route_table.id
}

# Private

# Private Route Table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.env}-private-route-table"
  }
}

# private Subnets
resource "aws_subnet" "private_subnet" {
    count = var.private_subnet_count
    vpc_id = aws_vpc.vpc.id
    cidr_block = cidrsubnet(var.private_subnet_cidr_block, 8, count.index * 10)

    tags = {
        Name = "${var.env}-private-subnet-${count.index + 1}"
    }
}

# subnets <-> route table
resource "aws_route_table_association" "private_subnet_route_table" {
    count = var.private_subnet_count
    subnet_id = aws_subnet.private_subnet[count.index].id
    route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route" "private_route" {
    route_table_id = aws_route_table.private_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
}

resource "aws_eip" "eip" {
    vpc = true

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_nat_gateway" "nat_gateway" {
    allocation_id = aws_eip.eip.id

    subnet_id = aws_subnet.private_subnet[0].id

    tags = {
        Name = "${var.env}-nat-gateway-${aws_subnet.private_subnet[0].id}"
    }
}