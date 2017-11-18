
resource "aws_security_group" "stageapp" {
    name = "stageapp"
    description = "Allow stageapp connections."
    vpc_id = "${var.vpc_id}"
    tags { Name = "stageapp" }
}

#resource "aws_security_group_rule" "stageapp-in-elb-http" {
#  security_group_id = "${aws_security_group.stageapp.id}"
#  type = "ingress"
#  from_port = 80
#  to_port = 80
#  protocol = "tcp"
#  source_security_group_id = "${aws_security_group.stageapp-lb.id}"
#}

#resource "aws_security_group_rule" "stageapp-in-elb-https" {
#  security_group_id = "${aws_security_group.stageapp.id}"
#  type = "ingress"
#  from_port = 443
#  to_port = 443
#  protocol = "tcp"
#  source_security_group_id = "${aws_security_group.stageapp-lb.id}"
#}

#resource "aws_security_group_rule" "prodreport-out-https" {
#  security_group_id = "${aws_security_group.stageapp.id}"
#  type = "egress"
#  from_port = 443
#  to_port = 443
#  protocol = "tcp"
#  source_security_group_id = "${aws_security_group.prodreport.id}"
#}

resource "aws_security_group_rule" "stageapp-in-vpn-http" {
  security_group_id = "${aws_security_group.stageapp.id}"
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.vpn.id}"
}

resource "aws_security_group_rule" "stageapp-in-jumphost-http" {
  security_group_id = "${aws_security_group.stageapp.id}"
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.ssh_jump.id}"
}

resource "aws_security_group_rule" "stageapp-in-vpn-https" {
  security_group_id       = "${aws_security_group.stageapp.id}"
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.vpn.id}"
}

resource "aws_security_group_rule" "stageapp-in-jumphost-https" {
  security_group_id = "${aws_security_group.stageapp.id}"
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.ssh_jump.id}"
}

resource "aws_security_group_rule" "stageapp-out-proxy" {
  security_group_id = "${aws_security_group.stageapp.id}"
  type = "egress"
  from_port = 3128
  to_port = 3128
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.proxy.id}"
}

# # TEMPORARY - ALLOW ALL OUTBOUND TRAFFIC TO VPC
resource "aws_security_group_rule" "stageapp-out-all" {
  security_group_id = "${aws_security_group.stageapp.id}"
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["${var.cidr}","0.0.0.0/0"]
}

resource "aws_security_group_rule" "stageapp-to-fusionstage-api" {
  security_group_id        = "${aws_security_group.stageapp.id}"
  type                     = "egress"
  from_port                = 8765
  to_port                  = 8765
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.stage-fusion.id}"
}

resource "aws_security_group_rule" "stageapp-to-fusionstage" {
  security_group_id        = "${aws_security_group.stageapp.id}"
  type                     = "egress"
  from_port                = 8764
  to_port                  = 8764
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.stage-fusion.id}"
}

resource "aws_security_group_rule" "stageapp-to-fusionstage-solr" {
  security_group_id        = "${aws_security_group.stageapp.id}"
  type                     = "egress"
  from_port                = 8983
  to_port                  = 8983
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.stage-fusion.id}"
}
