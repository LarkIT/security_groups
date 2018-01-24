resource "aws_security_group" "stage-fusion" {
    name        = "stage-fusion"
    description = "Allow stageapp connections to fusionstage"
    vpc_id      = "${var.vpc_id}"
    tags {
      Name = "stage_fusion"
    }
}

resource "aws_security_group_rule" "stage-fusion-api" {
  security_group_id        = "${aws_security_group.stage-fusion.id}"
  type                     = "ingress"
  from_port                = 8765
  to_port                  = 8765
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.stageapp.id}"
}

resource "aws_security_group_rule" "stage-fusion" {
  security_group_id        = "${aws_security_group.stage-fusion.id}"
  type                     = "ingress"
  from_port                = 8764
  to_port                  = 8764
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.stageapp.id}"
}

resource "aws_security_group_rule" "stage-fusion-solr" {
  security_group_id        = "${aws_security_group.stage-fusion.id}"
  type                     = "ingress"
  from_port                = 8983
  to_port                  = 8983
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.stageapp.id}"
}

resource "aws_security_group_rule" "stagefusion-out-ssl" {
  security_group_id = "${aws_security_group.stage-fusion.id}"
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "-1"
  cidr_blocks       = ["${var.cidr}","0.0.0.0/0"]
}
