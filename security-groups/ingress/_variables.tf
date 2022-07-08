variable "port" {}
variable "protocol" {}

variable "sg_cidr_blocks" {
  default = []
  type    = list(string)
}

variable "sg_id" {}

variable "sg_target_id" {
  default = ""
}

variable "create_with_sg" {
  default = false
}

variable "create_with_cidr" {
  default = false
}

