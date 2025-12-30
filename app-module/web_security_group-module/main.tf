resource "aws_security_group" "wp_sg" {
  name        = var.wp_sg_name
  vpc_id      = var.wp_vpc_id
  description = var.wp_sg_description

  tags = {
    Name = var.wp_sg_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh_from_ip" {
  security_group_id = aws_security_group.wp_sg.id
  cidr_ipv4         = var.wp_ssh_cidr
  from_port         = var.wp_ssh_port
  ip_protocol       = "tcp"
  to_port           = var.wp_ssh_port
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.wp_sg.id
  cidr_ipv4         = var.wp_http_cidr
  from_port         = var.wp_http_port
  ip_protocol       = "tcp"
  to_port           = var.wp_http_port
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  count             = var.wp_allow_https ? 1 : 0
  security_group_id = aws_security_group.wp_sg.id
  cidr_ipv4         = var.wp_https_cidr
  from_port         = var.wp_https_port
  ip_protocol       = "tcp"
  to_port           = var.wp_https_port
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_ipv4" {
  security_group_id = aws_security_group.wp_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
