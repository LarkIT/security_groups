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
  type        = "map"
  description = "AWS subnets for all dmz availability zones"
}

variable "db_type" {
  type = "string"
  default = "mysql"
  description = "Which database type (mysql, postgresql) we are using so we open the right ports"
}

variable "enable_mysql" {
  description = "Add mysql standalone firewall flows"
  default     = 0
}

variable "enable_postgres" {
  description = "Add postgres standalone firewall flows"
  default     = 0
}
