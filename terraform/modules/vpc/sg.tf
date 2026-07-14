# Security Group for ALB
resource "aws_security_group" "this" {
  name_prefix = "${var.vpc_name}-${var.env}-sg-"
  description = "Security Group for ${var.vpc_name}-${var.env} instances"
  vpc_id      = module.vpc.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.vpc_name}-${var.env}-sg"
  }
}

resource "aws_vpc_security_group_egress_rule" "this" {
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow egress"
  security_group_id = aws_security_group.this.id
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow ingress"
  security_group_id = aws_security_group.this.id
  from_port         = 80
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow ingress"
  security_group_id = aws_security_group.this.id
  from_port         = 443
  to_port           = 443
}
