variable "vpc_cidr" {
  description = "CIDR range for the VPC"
  type        = string
  default     = ""
}

variable "name" {
  description = "Name for the VPC"
  type        = string
  default     = ""
}

variable "private_subnet1_cidr" {
  description = "CIDR range for the private subnet 1"
  type        = string
  default     = ""
}

variable "private_subnet2_cidr" {
  description = "CIDR range for the private subnet 2"
  type        = string
  default     = ""
}

variable "public_subnet1_cidr" {
  description = "CIDR range for the public subnet 1"
  type        = string
  default     = ""
}

variable "public_subnet2_cidr" {
  description = "CIDR range for the public subnet 2"
  type        = string
  default     = ""
}