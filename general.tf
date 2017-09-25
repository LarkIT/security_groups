resource "aws_security_group" "general" {
  name        = "GENERAL"
  description = "Generic allows for ALL systems"
  vpc_id      = "${var.vpc_id}"
  tags { 
    Name = "GENERAL" 
  }
}
