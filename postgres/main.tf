resource "aws_security_group_rule" "stagedb-in-stageapp-psql" {
  count                    = "${var.enable_postgres}"
  security_group_id        = "${var.stagedb_id}"
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = "${var.stageapp_id}"
}

resource "aws_security_group_rule" "proddb-in-prodapp-psql" {
  count                    = "${var.enable_postgres}"
  security_group_id        = "${var.proddb_id}"
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = "${var.prodapp_id}"
}
