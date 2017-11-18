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

output "stagedb_id" {
  value = "${aws_security_group.stagedb.id}"
}

output "stage-app-lb_id" {
  value = "${aws_security_group.stage-app-lb.id}"
}

output "prod-app-lb_id" {
  value = "${aws_security_group.prod-app-lb.id}"
}

output "vpn_id" {
  value = "${aws_security_group.vpn.id}"
}

output "stage-fusion_id" {
  value = "${aws_security_group.stage-fusion.id}"
}
