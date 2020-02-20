variable "name" {
  type = set(string)
}

variable "tags" {
  type        = map
  description = "Tags for redis nodes"
  default     = {}
}
