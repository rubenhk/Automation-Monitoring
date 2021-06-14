variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "laws_name" {
  type = string
}

variable "sku" {
  type    = string
  default = "PerGB2018"
}

variable "retention_in_days" {
  type    = string
  default = "31"
}

variable "tags" {
  description = "Tags to be added"
  type        = map(string)
  default = {
    Environment = "prod"
  }
}
