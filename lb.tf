resource "aws_security_group" "app-lb" {
    name        = "app-lb"
    description = "Allow stageapp ELB connections."
    vpc_id      = "${var.vpc_id}"
    tags { 
      Name = "app-lb" 
    }
}

resource "aws_security_group_rule" "app-lb-in-any-http" {
  security_group_id = "${aws_security_group.app-lb.id}"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
}

resource "aws_security_group_rule" "app-lb-in-any-https" {
  security_group_id = "${aws_security_group.app-lb.id}"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
}

resource "aws_security_group_rule" "app-lb-out-app-http" {
  security_group_id        = "${aws_security_group.app-lb.id}"
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.appserver.id}"
}

resource "aws_security_group_rule" "app-lb-out-app-https" {
  security_group_id        = "${aws_security_group.app-lb.id}"
  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.appserver.id}"
}
