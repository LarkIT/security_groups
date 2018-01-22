resource "aws_security_group" "pulp" {
  name        = "pulp"
  description = "Allow pulp connections."
  vpc_id      = "${var.vpc_id}"
  tags { Name = "pulp" }
}

resource "aws_security_group_rule" "pulp-in-vpc-http" {
  security_group_id = "${aws_security_group.pulp.id}"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["${var.cidr}"]
}

resource "aws_security_group_rule" "pulp-in-vpc-https" {
  security_group_id = "${aws_security_group.pulp.id}"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["${var.cidr}"]
}

resource "aws_security_group_rule" "pulp-in-vpc-messagebus" {
  security_group_id = "${aws_security_group.pulp.id}"
  type              = "ingress"
  from_port         = 5671
  to_port           = 5672
  protocol          = "tcp"
  cidr_blocks       = ["${var.cidr}"]
}

resource "aws_security_group_rule" "pulp-out-any-http" {
  security_group_id = "${aws_security_group.pulp.id}"
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "pulp-out-any-https" {
  security_group_id = "${aws_security_group.pulp.id}"
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
