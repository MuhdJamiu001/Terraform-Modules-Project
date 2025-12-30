resource "aws_vpc" "project" {
  cidr_block           = var.wp_vpc_cidr
  instance_tenancy     = var.wp_instance_tenancy
  enable_dns_support   = var.wp_enable_dns_support
  enable_dns_hostnames = var.wp_enable_dns_hostnames

  tags = {
    Name = "${var.wp_project_name}-vpc"
  }
}

resource "aws_subnet" "project-pub-1" {
  vpc_id                  = aws_vpc.project.id
  cidr_block              = var.wp_public_subnet_1_cidr
  map_public_ip_on_launch = var.wp_map_public_ip_on_launch_public
  availability_zone       = var.wp_zone1

  tags = {
    Name = "${var.wp_project_name}-pub-1"
  }
}

resource "aws_subnet" "project-pub-2" {
  vpc_id                  = aws_vpc.project.id
  cidr_block              = var.wp_public_subnet_2_cidr
  map_public_ip_on_launch = var.wp_map_public_ip_on_launch_public
  availability_zone       = var.wp_zone2

  tags = {
    Name = "${var.wp_project_name}-pub-2"
  }
}

resource "aws_subnet" "project-priv-1" {
  vpc_id                  = aws_vpc.project.id
  cidr_block              = var.wp_private_subnet_1_cidr
  map_public_ip_on_launch = var.wp_map_public_ip_on_launch_private
  availability_zone       = var.wp_zone1

  tags = {
    Name = "${var.wp_project_name}-priv-1"
  }
}

resource "aws_subnet" "project-priv-2" {
  vpc_id                  = aws_vpc.project.id
  cidr_block              = var.wp_private_subnet_2_cidr
  map_public_ip_on_launch = var.wp_map_public_ip_on_launch_private
  availability_zone       = var.wp_zone2

  tags = {
    Name = "${var.wp_project_name}-priv-2"
  }
}

resource "aws_internet_gateway" "project-IGW" {
  vpc_id = aws_vpc.project.id

  tags = {
    Name = "${var.wp_project_name}-igw"
  }
}

resource "aws_route_table" "project-pub-RT" {
  vpc_id = aws_vpc.project.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project-IGW.id
  }

  tags = {
    Name = "${var.wp_project_name}-pub-rt"
  }
}

resource "aws_route_table_association" "project-pub-1a" {
  subnet_id      = aws_subnet.project-pub-1.id
  route_table_id = aws_route_table.project-pub-RT.id
}

resource "aws_route_table_association" "project-pub-2a" {
  subnet_id      = aws_subnet.project-pub-2.id
  route_table_id = aws_route_table.project-pub-RT.id
}
