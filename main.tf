resource "aws_security_group" "general" {
  name        = "GENERAL"
  description = "Generic allows for ALL systems"
  vpc_id      = "${var.vpc_id}"
  tags { 
    Name = "GENERAL" 
  }
}

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

resource "aws_security_group" "foreman" {
    name        = "foreman"
    description = "Allow puppet and foreman connections."
    tags { Name = "foreman" }
    vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "general-out-foreman-puppet" {
  security_group_id = "${aws_security_group.general.id}"
  type = "egress"
  from_port = 8140
  to_port = 8140
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.foreman.id}"
}

resource "aws_security_group_rule" "foreman-in-vpc-puppet" {
  security_group_id = "${aws_security_group.foreman.id}"
  type              = "ingress"
  from_port         = 8140 # Puppet
  to_port           = 8140
  protocol          = "tcp"
  cidr_blocks       = [ "${var.cidr}" ]
}
