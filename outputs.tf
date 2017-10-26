output "general_id" {
  value = "${aws_security_group.general.id}"
}

output "ssh_jump_id" {
  value = "${aws_security_group.ssh_jump.id}"
}

output "group_id" {
  value = "${aws_security_group.general.id}"
}

output "foreman_id" {
  value = "${aws_security_group.foreman.id}"
}

output "prodapp_id" {
  value = "${aws_security_group.prodapp.id}"
}

output "proddb_id" {
  value = "${aws_security_group.proddb.id}"
}

output "gitlab_id" {
  value = "${aws_security_group.gitlab.id}"
}

output "stageapp_id" {
  value = "${aws_security_group.stageapp.id}"
}

output "app-lb_id" {
  value = "${aws_security_group.app-lb.id}"
}
