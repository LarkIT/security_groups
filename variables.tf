
#variable "ssh_name" {
#  description = "The AWS region."
#}

variable "vpc_id" {
  description = "The AWS region."
}

variable "cidr" {
  description = "The AWS region."
}

variable "host_prefix" {
  description = "Hostname prefix (abc)"
}

variable "infra_services_cidr" {
  type        = map
  description = "AWS subnets for all dmz availability zones"
}
