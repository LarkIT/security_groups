resource "aws_security_group" "proxy" {
    name        = "proxy"
    description = "Allow proxy connections."
    vpc_id      = "${var.vpc_id}"
    tags { Name = "proxy" }
}

resource "aws_security_group_rule" "proxy-in-general-squid" {
  security_group_id        = "${aws_security_group.proxy.id}"
  type                     = "ingress"
  from_port                = 3128
  to_port                  = 3128
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.general.id}"
}

resource "aws_security_group_rule" "proxy-out-any-http" {
  security_group_id = "${aws_security_group.proxy.id}"
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "proxy-out-any-https" {
  security_group_id = "${aws_security_group.proxy.id}"
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
