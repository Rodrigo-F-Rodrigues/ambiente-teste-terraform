resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-IGW"
    }
  )
}

resource "aws_route_table" "main_public_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-RTB-PUB"
    }
  )
}