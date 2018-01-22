resource "aws_security_group" "foreman" {
    name        = "foreman"
    description = "Allow puppet and foreman connections."
    tags { Name = "foreman" }
    vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "foreman-in-vpc-puppet" {
  security_group_id = "${aws_security_group.foreman.id}"
  type              = "ingress"
  from_port         = 8140 # Puppet
  to_port           = 8140
  protocol          = "tcp"
  cidr_blocks       = [ "${var.cidr}" ]
}

resource "aws_security_group_rule" "foreman-in-jumphost-https" {
  security_group_id        = "${aws_security_group.foreman.id}"
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.ssh_jump.id}"
}

resource "aws_security_group_rule" "foreman-out-any-http" {
  security_group_id = "${aws_security_group.foreman.id}"
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "foreman-out-https-any" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.foreman.id}"
}

resource "aws_security_group_rule" "foreman-in-gitlab-webhook" {
  security_group_id        = "${aws_security_group.foreman.id}"
  type                     = "ingress"
  from_port                = 8088
  to_port                  = 8088
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.gitlab.id}"
}

resource "aws_security_group_rule" "foreman-out-gitlab-ssh" {
  security_group_id        = "${aws_security_group.foreman.id}"
  type                     = "egress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.gitlab.id}"
}

resource "aws_security_group_rule" "foreman-out-github-ssh" {
  security_group_id = "${aws_security_group.foreman.id}"
  type = "egress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["192.30.252.0/22", "185.199.108.0/22"]
}
