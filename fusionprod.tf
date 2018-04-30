resource "aws_security_group" "prod-fusion" {
    name        = "prod-fusion"
    description = "Allow prodapp connections to fusionprod"
    vpc_id      = "${var.vpc_id}"
    tags {
      Name = "prod_fusion"
    }
}

resource "aws_security_group_rule" "prod-fusion-api" {
  security_group_id        = "${aws_security_group.prod-fusion.id}"
  type                     = "ingress"
  from_port                = 8765
  to_port                  = 8765
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.prodapp.id}"
}

resource "aws_security_group_rule" "prod-fusion" {
  security_group_id        = "${aws_security_group.prod-fusion.id}"
  type                     = "ingress"
  from_port                = 8764
  to_port                  = 8764
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.prodapp.id}"
}

resource "aws_security_group_rule" "prod-fusion-ui" {
  security_group_id = "${aws_security_group.prod-fusion.id}"
  type              = "ingress"
  from_port         = 8764
  to_port           = 8764
  protocol          = "tcp"
  cidr_blocks       = ["172.22.40.0/24", "172.22.140.0/24", "172.22.240.0/24", "172.20.40.0/24", "172.20.40.100/32", "172.20.140.100/32", "172.20.240.100/32"]
}

resource "aws_security_group_rule" "prod-fusion-solr" {
  security_group_id        = "${aws_security_group.prod-fusion.id}"
  type                     = "ingress"
  from_port                = 8983
  to_port                  = 8983
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.prodapp.id}"
}

resource "aws_security_group_rule" "prodfusion-out-ssl" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.prod-fusion.id}"
}

resource "aws_security_group_rule" "prodfusion-out-nonssl" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.prod-fusion.id}"
}
