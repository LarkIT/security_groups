#resource "aws_security_group" "aurora-stagedb" {
#   name        = "aurora-stagedb"
#   description = "Allow stagedb connections."
#   vpc_id      = "${var.vpc_id}"
#   tags { 
#     Name = "aurora-stagedb"
#   }
#}
#
#resource "aws_security_group_rule" "aurora-stagedb-in-stageapp-psql" {
#  count                    = "${var.db_type == "postgres" ? 1 : 0 }"
#  security_group_id        = "${aws_security_group.aurora-stagedb.id}"
#  type                     = "ingress"
#  from_port                = 5432
#  to_port                  = 5432
#  protocol                 = "tcp"
#  source_security_group_id = "${aws_security_group.stageapp.id}"
#  }
#
#resource "aws_security_group_rule" "aurora-stagedb-in-stageapp-mysql" {
#  count                    = "${var.db_type == "mysql" ? 1 : 0 }"
#  security_group_id        = "${aws_security_group.aurora-stagedb.id}"
#  type                     = "ingress"
#  from_port                = 3306
#  to_port                  = 3306
#  protocol                 = "tcp"
#  source_security_group_id = "${aws_security_group.stageapp.id}"
#}
#
