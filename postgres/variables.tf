variable "enable_postgres" {
  description = "Add postgres standalone flows (i.e. not aurora)"
  default     = 0
}

variable "stagedb_id" {
  description = "AWS ID for the stageapp servers"
}

variable "stageapp_id" {
  description = "AWS ID for the stageapp servers"
}

variable "proddb_id" {
  description = "AWS ID for the proddb servers"
}

variable "prodapp_id" {
  description = "AWS ID for the prodapp servers"
}
