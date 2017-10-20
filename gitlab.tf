resource "aws_security_group" "gitlab" {
  name        = "gitlab"
  description = "Allow  GitLab connections."
  vpc_id      = "${var.vpc_id}"
  tags { Name = "gitlab" }
}

resource "aws_security_group_rule" "gitlab-in-any-http" {
  security_group_id = "${aws_security_group.gitlab.id}"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["${var.infra_services_cidr[ "a" ]}"]
}

resource "aws_security_group_rule" "gitlab-in-any-https" {
  security_group_id = "${aws_security_group.gitlab.id}"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["${var.infra_services_cidr[ "a" ]}, ${var.infra_services_cidr[ "b" ]}, ${var.infra_services_cidr[ "c" ]}"]
}


resource "aws_security_group_rule" "gitlab-out-any" {
  security_group_id = "${aws_security_group.gitlab.id}"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["${var.cidr}"]
}

resource "aws_security_group_rule" "gitlab-in-foreman-ssh" {
  security_group_id        = "${aws_security_group.gitlab.id}"
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.foreman.id}"
}

resource "aws_security_group_rule" "gitlab-out-foreman-webhook" {
  security_group_id        = "${aws_security_group.gitlab.id}"
  type                     = "egress"
  from_port                = 8088
  to_port                  = 8088
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.foreman.id}"
}

### IF INITIAL STATE

resource "aws_security_group_rule" "gitlab-out-any-http" {
  security_group_id = "${aws_security_group.gitlab.id}"
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "gitlab-out-any-https" {
  security_group_id = "${aws_security_group.gitlab.id}"
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

### END IF INITIAL STATE
