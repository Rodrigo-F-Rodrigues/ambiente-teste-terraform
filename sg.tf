resource "aws_security_group" "main_sg" {
  vpc_id      = aws_vpc.main_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-SG"
    }
  )
}

resource "aws_security_group_rule" "subnet_ranges" {
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  type              = "ingress"
  description       = "Liberando trafego para a VPC"
  security_group_id = aws_security_group.main_sg.id
  cidr_blocks       = ["10.0.0.0/16"]  # Verifique se esta sub-rede está correta
}
