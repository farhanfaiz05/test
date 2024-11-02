variable "name" {
  description = "Name of the environment"
  type        = string
  default     = ""
}

variable "subnet1" {
  description = "Id of private subnet1"
  type        = string
  default     = ""
}

variable "subnet2" {
  description = "Id of private subnet2"
  type        = string
  default     = ""
}

variable "host" {
  description = "host domain"
  type        = string
  default     = ""
}

variable "filename" {
  description = "filename of index.html"
  type        = string
  default     = ""
}