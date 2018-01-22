resource "aws_security_group_rule" "stagedb-in-stageapp-mysql" {
  count                    = "${var.enable_mysql}"
  security_group_id        = "${var.stagedb_id}"
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = "${var.stageapp_id}"
}
