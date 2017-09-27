output "general_id" {
  value = "${aws_security_group.general.id}"
}

output "ssh_jump_id" {
  value = "${aws_security_group.ssh_jump.id}"
}

output "group_id" {
  value = "${aws_security_group.general.id}"
}
