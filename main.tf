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
  type = "ingress"
  from_port = -1
  to_port = -1
  protocol = "icmp"
  cidr_blocks = ["${var.cidr}"]
}
