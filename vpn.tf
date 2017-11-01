resource "aws_security_group" "vpn" {
  name        = "vpn"
  description = "Allow vpn connections."
  vpc_id      = "${var.vpc_id}"
  tags { Name = "vpn" }
}

resource "aws_security_group_rule" "vpn-in-any-http" {
  security_group_id = "${aws_security_group.vpn.id}"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "vpn-in-any-https" {
  security_group_id = "${aws_security_group.vpn.id}"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "vpn-in-any-https" {
  security_group_id = "${aws_security_group.vpn.id}"
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "vpn-in-any-ovpn" {
  security_group_id = "${aws_security_group.vpn.id}"
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "vpn-out-vpc-any" {
  security_group_id = "${aws_security_group.vpn.id}"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["${var.cidr}"]
}
