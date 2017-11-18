resource "aws_security_group" "stage_fusion" {
    name        = "stage_fusion"
    description = "Allow stageapp connections to fusionstage"
    vpc_id      = "${var.vpc_id}"
    tags {
      Name = "stage_fusion"
    }
}

resource "aws_security_group_rule" "stage_fusion_api" {
  security_group_id        = "${aws_security_group.stage_fusion.id}"
  type                     = "ingress"
  from_port                = 8765
  to_port                  = 8765
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.stageapp.id}"
}

resource "aws_security_group_rule" "stage_fusion" {
  security_group_id        = "${aws_security_group.stage_fusion.id}"
  type                     = "ingress"
  from_port                = 8764
  to_port                  = 8764
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.stage.id}"
}
