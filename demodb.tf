resource "aws_security_group" "demodb" {
   name        = "demodb"
   description = "Allow demodb connections."
   vpc_id      = "${var.vpc_id}"
   tags { 
     Name = "demodb"
   }
}


resource "aws_security_group_rule" "demodb-in-stageapp-psql" {
 count                    = "${var.db_type == "postgres" ? 1 : 0 }"
 security_group_id        = "${aws_security_group.demodb.id}"
 type                     = "ingress"
 from_port                = 5432
 to_port                  = 5432
 protocol                 = "tcp"
 source_security_group_id = "${aws_security_group.demoapp.id}"
}

resource "aws_security_group_rule" "demodb-in-stageapp-mysql" {
 count                    = "${var.db_type == "mysql" ? 1 : 0 }"
 security_group_id        = "${aws_security_group.demodb.id}"
 type                     = "ingress"
 from_port                = 3306
 to_port                  = 3306
 protocol                 = "tcp"
 source_security_group_id = "${aws_security_group.demoapp.id}"
}



