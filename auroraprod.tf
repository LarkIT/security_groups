#resource "aws_security_group" "aurora-proddb" {
#   name        = "aurora-proddb"
#   description = "Allow proddb connections."
#   vpc_id      = "${var.vpc_id}"
#   tags { 
#     Name = "aurora-proddb"
#   }
#}
#
#resource "aws_security_group_rule" "aurora-proddb-in-stageapp-psql" {
# security_group_id        = "${aws_security_group.aurora-proddb.id}"
# type                     = "ingress"
# from_port                = 5432
# to_port                  = 5432
# protocol                 = "tcp"
# source_security_group_id = "${aws_security_group.prodapp.id}"
#}
#
#resource "aws_security_group_rule" "aurora-proddb-in-stageapp-mysql" {
# security_group_id        = "${aws_security_group.aurora-proddb.id}"
# type                     = "ingress"
# from_port                = 3306
# to_port                  = 3306
# protocol                 = "tcp"
# source_security_group_id = "${aws_security_group.prodapp.id}"
#}
#
