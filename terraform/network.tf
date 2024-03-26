resource "aws_vpc" "vpc" {
  cidr_block = "172.16.0.0/22"

  tags = local.tags
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = local.tags
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = local.tags
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "172.16.0.0/24"

  tags = local.tags
}

resource "aws_subnet" "subnet_2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "172.16.1.0/24"
  availability_zone = "eu-west-1c"

  tags = local.tags
}

resource "aws_route_table_association" "route_table_association" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "route_table_association_2" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_default_network_acl" "network_acl" {
  default_network_acl_id = aws_vpc.vpc.default_network_acl_id
  subnet_ids = [aws_subnet.subnet.id,aws_subnet.subnet_2.id]

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0" #fixed cidr block
    from_port  = 0
    to_port    = 0
  }
}


resource "aws_security_group" "security_group" {
  vpc_id = aws_vpc.vpc.id

  ingress = [
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = ""
      from_port        = 22 
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    },
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = ""
      from_port        = 80 #fixed port
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 80 #fixed port
    }
  ]

  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]

  tags = local.tags
}

import {
  to = aws_vpc.vpc
  id = "vpc-07e9e323afbcf06b9"
}

import {
  to = aws_subnet.subnet
  id = "subnet-0919427541b97da27"
}

import {
  to = aws_internet_gateway.internet_gateway
  id = "igw-0e8925e77c9f61cf2"
}

import {
  to = aws_route_table.route_table
  id = "rtb-06eee48d38512f67c"
}

import {
  to = aws_route_table_association.route_table_association
  id = "subnet-0919427541b97da27/rtb-06eee48d38512f67c"
}

import {
  to = aws_default_network_acl.network_acl
  id = "acl-0c563866872235100"
}

import {
  to = aws_security_group.security_group
  id = "sg-0cd95a2ae75f6589d"
}