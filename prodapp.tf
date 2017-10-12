
resource "aws_security_group" "prodapp" {
    name = "prodapp"
    description = "Allow prodapp connections."
    vpc_id = "${var.vpc_id}"
    tags { Name = "prodapp" }
}

#resource "aws_security_group_rule" "prodapp-in-elb-http" {
#  security_group_id = "${aws_security_group.prodapp.id}"
#  type = "ingress"
#  from_port = 80
#  to_port = 80
#  protocol = "tcp"
#  source_security_group_id = "${aws_security_group.prodapp-lb.id}"
#}

#resource "aws_security_group_rule" "prodapp-in-elb-https" {
#  security_group_id = "${aws_security_group.prodapp.id}"
#  type = "ingress"
#  from_port = 443
#  to_port = 443
#  protocol = "tcp"
#  source_security_group_id = "${aws_security_group.prodapp-lb.id}"
#}

#resource "aws_security_group_rule" "prodreport-out-https" {
#  security_group_id = "${aws_security_group.prodapp.id}"
#  type = "egress"
#  from_port = 443
#  to_port = 443
#  protocol = "tcp"
#  source_security_group_id = "${aws_security_group.prodreport.id}"
#}

resource "aws_security_group_rule" "prodapp-in-vpn-http" {
  security_group_id = "${aws_security_group.prodapp.id}"
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.vpn.id}"
}

resource "aws_security_group_rule" "prodapp-in-jumphost-http" {
  security_group_id = "${aws_security_group.prodapp.id}"
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.ssh_jump.id}"
}

resource "aws_security_group_rule" "prodapp-in-vpn-https" {
  security_group_id = "${aws_security_group.prodapp.id}"
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.vpn.id}"
}

#resource "aws_security_group_rule" "prodapp-in-vpn-vhttps" {
#  security_group_id = "${aws_security_group.prodapp.id}"
#  type = "ingress"
#  from_port = 2001
#  to_port = 2010
#  protocol = "tcp"
#  source_security_group_id = "${aws_security_group.prodapp-lb.id}"
#}

#resource "aws_security_group_rule" "prodapp-in-jumphost-rdp" {
#  security_group_id = "${aws_security_group.prodapp.id}"
#  type = "ingress"
#  from_port = 3389
#  to_port = 3389
#  protocol = "tcp"
#  source_security_group_id = "${aws_security_group.ssh_jump.id}"
#}

resource "aws_security_group_rule" "prodapp-in-jumphost-https" {
  security_group_id = "${aws_security_group.prodapp.id}"
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.ssh_jump.id}"
}

resource "aws_security_group_rule" "prodapp-out-proddb-sql" {
  security_group_id = "${aws_security_group.prodapp.id}"
  type = "egress"
  from_port = 1433
  to_port = 1433
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.proddb.id}"
}

resource "aws_security_group_rule" "prodapp-out-proxy" {
  security_group_id = "${aws_security_group.prodapp.id}"
  type = "egress"
  from_port = 3128
  to_port = 3128
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.proxy.id}"
}

# # TEMPORARY - ALLOW ALL OUTBOUND TRAFFIC TO VPC
resource "aws_security_group_rule" "prodapp-out-all" {
  security_group_id = "${aws_security_group.prodapp.id}"
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["${var.cidr}","0.0.0.0/0"]
}

resource "aws_security_group_rule" "prodapp-out-proddb-psql" {
  security_group_id        = "${aws_security_group.prodapp.id}"
  type                     = "egress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.proddb.id}"
}

resource "aws_security_group" "proddb" {
    name = "proddb"
    description = "Allow proddb connections."
    tags { Name = "proddb" }
    vpc_id = "${var.vpc_id}"
}

resource "aws_security_group_rule" "proddb-in-prodapp-psql" {
  security_group_id        = "${aws_security_group.proddb.id}"
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.prodapp.id}"
}
