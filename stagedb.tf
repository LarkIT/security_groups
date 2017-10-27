resource "aws_security_group" "stagedb" {
    name        = "stagedb"
    description = "Allow stagedb connections."
    vpc_id      = "${var.vpc_id}"
    tags { 
      Name = "stagedb"
    }
}

resource "aws_security_group_rule" "stagedb-in-stageapp-psql" {
  security_group_id        = "${aws_security_group.stagedb.id}"
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.stageapp.id}"
}
