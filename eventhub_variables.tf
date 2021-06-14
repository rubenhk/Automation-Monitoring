variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "eventhub_namespace" {
  type = string
}

variable "eventhub_name" {
  type = string
}

variable "partition_count" {
  type    = number
  default = 1
}

variable "message_retention" {
  type    = number
  default = 1
}

variable "sku" {
  type    = string
  default = "Standard"
}

variable "capacity" {
  type    = string
  default = "1"
}

variable "tags" {
  description = "Tags to be added"
  type        = map(string)
  default = {
    Environment = "prod"
  }
}
