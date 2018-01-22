resource "aws_security_group" "general" {
  name        = "GENERAL"
  description = "Generic allows for ALL systems"
  vpc_id      = "${var.vpc_id}"
  tags { 
    Name = "GENERAL" 
  }
}

# Inbound/Ingress
resource "aws_security_group_rule" "general-in-vpc-ping" {
  security_group_id = "${aws_security_group.general.id}"
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["${var.cidr}"]
}

resource "aws_security_group_rule" "general-in-jumphost-ssh" {
  security_group_id        = "${aws_security_group.general.id}"
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.ssh_jump.id}"
}

resource "aws_security_group_rule" "general-in-vpn-ssh" {
  security_group_id = "${aws_security_group.general.id}"
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.vpn.id}"
}

# Outbound/egress
resource "aws_security_group_rule" "general-out-foreman-puppet" {
  security_group_id        = "${aws_security_group.general.id}"
  type                     = "egress"
  from_port                = 8140
  to_port                  = 8140
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.foreman.id}"
}

resource "aws_security_group_rule" "general-out-proxy-squid" {
  security_group_id        = "${aws_security_group.general.id}"
  type                     = "egress"
  from_port                = 3128
  to_port                  = 3128
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.proxy.id}"
}

# Allow outbound access to pulp server on http port
resource "aws_security_group_rule" "general-out-pulp-http" {
  security_group_id        = "${aws_security_group.general.id}"
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.pulp.id}"
}

# Allow outbound access to proxy server on https port
resource "aws_security_group_rule" "general-out-pulp-https" {
  security_group_id        = "${aws_security_group.general.id}"
  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.pulp.id}"
}

#Bidirectional UDP 123 access needed for NTP sync
resource "aws_security_group_rule" "general-out-ntp" {
  security_group_id = "${aws_security_group.general.id}"
  type              = "egress"
  from_port         = 123
  to_port           = 123
  protocol          = "udp"
  cidr_blocks       = ["162.213.2.253/32", "184.105.182.7/32", "23.239.24.67/32", "129.6.15.28/32"] #0.amazon.pool.ntp.org IPs
}

resource "aws_security_group_rule" "general-in-ntp" {
  security_group_id = "${aws_security_group.general.id}"
  type              = "ingress"
  from_port         = 123
  to_port           = 123
  protocol          = "udp"
  cidr_blocks       = ["162.213.2.253/32", "184.105.182.7/32", "23.239.24.67/32", "129.6.15.28/32"]
}
