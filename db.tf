resource "aws_security_group" "stagedb" {
   name        = "stagedb"
   description = "Allow stagedb connections."
   vpc_id      = "${var.vpc_id}"
   tags { 
     Name = "stagedb"
   }
}

resource "aws_security_group" "proddb" {
    name        = "proddb"
    description = "Allow proddb connections."
    vpc_id      = "${var.vpc_id}"
    tags {
      Name = "proddb"
    }
}

module "postgres_sg" {
  source          = "./postgres"
  enable_postgres = "${var.enable_postgres}"
  stagedb_id      = "${aws_security_group.stagedb.id}"
  stageapp_id     = "${aws_security_group.stageapp.id}"
  proddb_id       = "${aws_security_group.proddb.id}"
  prodapp_id      = "${aws_security_group.prodapp.id}"
}

module "mysql_sg" {
  source       = "./mysql"
  enable_mysql = "${var.enable_mysql}"
  stagedb_id   = "${aws_security_group.stagedb.id}"
  stageapp_id  = "${aws_security_group.stageapp.id}"
  proddb_id       = "${aws_security_group.proddb.id}"
  prodapp_id      = "${aws_security_group.prodapp.id}"
}
