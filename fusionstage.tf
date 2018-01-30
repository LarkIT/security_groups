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

resource "aws_security_group_rule" "stage-fusion-ui" {
  security_group_id = "${aws_security_group.stage-fusion.id}"
  type              = "ingress"
  from_port         = 8764
  to_port           = 8764
  protocol          = "tcp"
  cidr_blocks       = ["172.22.40.0/24", "172.22.140.0/24", "172.22.240.0/24"]
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
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.stage-fusion.id}"
}

resource "aws_security_group_rule" "stagefusion-out-nonssl" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.stage-fusion.id}"
}
