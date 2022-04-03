variable "user_name" {
  type = string
}

variable "policy_arn" {
  type = string
}

variable "rotation_days" {
  type    = number
  default = 7
}

variable "always_rotate" {
  type    = bool
  default = false
}
