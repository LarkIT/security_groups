resource "aws_security_group" "ssh_jump" {
    name        = "${var.ssh_name}"
    vpc_id      = "${var.vpc_id}"
    description = "SSH Jump Host - Temporary Access"

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 1022
        to_port     = 1022
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress { # TEMPORARY - ALLOW ALL OUTBOUND TRAFFIC TO VPC
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["${var.cidr}"]
    }

    tags {
        Name = "${var.ssh_name}"
    }
}
