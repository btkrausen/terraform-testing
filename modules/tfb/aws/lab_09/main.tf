# Main VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "main-vpc"
  }
}

# Subnets created with count
resource "aws_subnet" "subnet" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "subnet-${count.index + 1}"
    Tier = count.index < 1 ? "public" : "private"
  }
}

# Security groups created with count
resource "aws_security_group" "sg" {
  count       = 3
  name        = "${var.security_groups[count.index]}-sg"
  description = "Security group for ${var.security_groups[count.index]}"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${var.security_groups[count.index]}-sg"
  }
}

# Security group rules created with count
resource "aws_security_group_rule" "ingress" {
  count             = 3
  type              = "ingress"
  from_port         = var.sg_ports[count.index]
  to_port           = var.sg_ports[count.index]
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg[count.index].id
}

# Subnets created with for_each
resource "aws_subnet" "subnet_foreach" {
  for_each          = var.subnet_config
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = var.subnet_azs[each.key]

  tags = {
    Name = "subnet-${each.key}"
    Tier = "standard"
  }
}

# Security groups created with for_each
resource "aws_security_group" "sg_foreach" {
  for_each    = var.security_group_config
  name        = "${each.key}-sg-foreach"
  description = "Security group for ${each.key} servers"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${each.key}-sg-foreach"
  }
}

# Security group rules created with for_each
resource "aws_security_group_rule" "ingress_foreach" {
  for_each          = var.security_group_config
  type              = "ingress"
  from_port         = each.value
  to_port           = each.value
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_foreach[each.key].id
}

# Route tables created with for_each and a simple map
resource "aws_route_table" "rt" {
  for_each = var.route_tables
  vpc_id   = aws_vpc.main.id

  tags = {
    Name        = "${each.key}-rt"
    Description = each.value
  }
}