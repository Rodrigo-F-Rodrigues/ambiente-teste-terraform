resource "aws_eip" "main_ngw_eip_1a" {
  domain = "vpc"

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-EIP-1A"
    }
  )
}

resource "aws_eip" "main_ngw_eip_1b" {
  domain = "vpc"

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-EIP-1B"
    }
  )
}

resource "aws_nat_gateway" "main_ngw_1a" {
  allocation_id = aws_eip.main_ngw_eip_1a.id
  subnet_id     = aws_subnet.main_subnet_public_1a.id

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-NGW-1A"
    }
  )
}

resource "aws_nat_gateway" "main_ngw_1b" {
  allocation_id = aws_eip.main_ngw_eip_1b.id
  subnet_id     = aws_subnet.main_subnet_public_1b.id

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-NGW-1B"
    }
  )
}

resource "aws_route_table" "main_private_route_table_1a" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main_ngw_1a.id
  }

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-RTB-PRIV-1A"
    }
  )
}

resource "aws_route_table" "main_private_route_table_1b" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main_ngw_1b.id
  }

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-RTB-PRIV-1B"
    }
  )
}
