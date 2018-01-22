variable "enable_mysql" {
  description = "Add mysql standalone flows (i.e. not aurora)"
}

variable "stagedb_id" {
  description = "AWS ID for the stageapp servers"
}

variable "stageapp_id" {
  description = "AWS ID for the stageapp servers"
}

variable "proddb_id" {
  description = "AWS ID for the prodapp servers"
}

variable "prodapp_id" {
  description = "AWS ID for the prodapp servers"
}
