resource "aws_security_group" "wp_db_sg" {
  name        = var.wp_db_sg_name
  description = var.wp_db_sg_description
  vpc_id      = var.wp_vpc_id

  tags = {
    Name = var.wp_db_sg_name
  }
}

# Allow database connections ONLY from the WordPress web/app security group
resource "aws_vpc_security_group_ingress_rule" "db_from_wp_web_sg" {
  security_group_id            = aws_security_group.wp_db_sg.id
  referenced_security_group_id = var.wp_web_sg_id
  from_port                    = var.wp_db_port
  to_port                      = var.wp_db_port
  ip_protocol                  = "tcp"
}

# Outbound is generally kept open for simplicity (SGs are stateful anyway).
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_ipv4" {
  security_group_id = aws_security_group.wp_db_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_ipv6" {
  count             = var.wp_enable_ipv6_egress ? 1 : 0
  security_group_id = aws_security_group.wp_db_sg.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1"
}
