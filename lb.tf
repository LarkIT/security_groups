################################################
#
# Staging Security Group
#
################################################
resource "aws_security_group" "stage-app-lb" {
    name        = "stage-app-lb"
    description = "Allow stageapp ELB connections."
    vpc_id      = "${var.vpc_id}"
    tags { 
      Name = "stage-app-lb" 
    }
}

resource "aws_security_group_rule" "stage-app-lb-in-any-http" {
  security_group_id = "${aws_security_group.stage-app-lb.id}"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
}

resource "aws_security_group_rule" "stage-app-lb-in-any-https" {
  security_group_id = "${aws_security_group.stage-app-lb.id}"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
}

resource "aws_security_group_rule" "stage-app-lb-out-app-http" {
  security_group_id        = "${aws_security_group.stage-app-lb.id}"
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.stageapp.id}"
}

resource "aws_security_group_rule" "stage-app-lb-out-app-https" {
  security_group_id        = "${aws_security_group.stage-app-lb.id}"
  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.stageapp.id}"
}

################################################
#
# Production Security Group
#
################################################
resource "aws_security_group" "prod-app-lb" {
    name        = "prod-app-lb"
    description = "Allow prodapp ELB connections."
    vpc_id      = "${var.vpc_id}"
    tags {
      Name = "prod-app-lb"
    }
}


resource "aws_security_group_rule" "prod-app-lb-in-any-http" {
  security_group_id = "${aws_security_group.prod-app-lb.id}"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
}

resource "aws_security_group_rule" "prod-app-lb-in-any-https" {
  security_group_id = "${aws_security_group.prod-app-lb.id}"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
}

resource "aws_security_group_rule" "prod-app-lb-out-app-http" {
  security_group_id        = "${aws_security_group.prod-app-lb.id}"
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.prodapp.id}"
}

resource "aws_security_group_rule" "prod-app-lb-out-app-https" {
  security_group_id        = "${aws_security_group.prod-app-lb.id}"
  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.prodapp.id}"
}


################################################
#
# Demo Security Group
#
################################################
resource "aws_security_group" "demo-app-lb" {
    name        = "demo-app-lb"
    description = "Allow prodapp ELB connections."
    vpc_id      = "${var.vpc_id}"
    tags {
      Name = "demo-app-lb"
    }
}


resource "aws_security_group_rule" "demo-app-lb-in-any-http" {
  security_group_id = "${aws_security_group.demo-app-lb.id}"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
}

resource "aws_security_group_rule" "demo-app-lb-in-any-https" {
  security_group_id = "${aws_security_group.demo-app-lb.id}"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
}

resource "aws_security_group_rule" "demo-app-lb-out-app-http" {
  security_group_id        = "${aws_security_group.demo-app-lb.id}"
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.demo.id}"
}

resource "aws_security_group_rule" "demo-app-lb-out-app-https" {
  security_group_id        = "${aws_security_group.demo-app-lb.id}"
  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.demo.id}"
}

