#resource "aws_security_group" "proddb" {
#    name = "proddb"
#    description = "Allow proddb connections."
#    tags { Name = "proddb" }
#    vpc_id = "${var.vpc_id}"
#}
#
##resource "aws_security_group_rule" "proddb-in-prodapp-psql" {
##  security_group_id        = "${aws_security_group.proddb.id}"
##  type                     = "ingress"
##  from_port                = 5432
##  to_port                  = 5432
##  protocol                 = "tcp"
##  source_security_group_id = "${aws_security_group.prodapp.id}"
##}
#
#resource "aws_security_group_rule" "proddb-in-prodapp-mysql" {
#  security_group_id        = "${aws_security_group.proddb.id}"
#  type                     = "ingress"
#  from_port                = 3306
#  to_port                  = 3306
#  protocol                 = "tcp"
#  source_security_group_id = "${aws_security_group.prodapp.id}"
#}
