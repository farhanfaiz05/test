variable "region" {
  description = "Region to deploy"
  type        = string
  default     = "us-east-1"
}

variable "name" {
  description = "name prefix for resource"
  type        = string
  default     = "g2-interview"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnet1_cidr" {
  description = "Private subnet 1 CIDR"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet2_cidr" {
  description = "Private subnet 2 CIDR"
  type        = string
  default     = "10.0.2.0/24"
}

variable "public_subnet1_cidr" {
  description = "public subnet 1 CIDR"
  type        = string
  default     = "10.0.3.0/24"
}

variable "public_subnet2_cidr" {
  description = "public subnet 2 CIDR"
  type        = string
  default     = "10.0.4.0/24"
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.30"
}

variable "ami_type" {
  description = "Min number of instances in node group"
  type        = string
  default     = "AL2_x86_64"
}

variable "desired_size" {
  description = "Desired number of instances for node group"
  type        = string
  default     = "2"
}

variable "max_size" {
  description = "Max number of instances in node group"
  type        = string
  default     = "5"
}

variable "min_size" {
  description = "Min number of instances in node group"
  type        = string
  default     = "1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.medium"
}

variable "hostname" {
  description = "host domain"
  type        = string
  default     = "interview.devops.g2.com"
}

variable "filename" {
  description = "file name of code"
  type        = string
  default     = "index.html"
}

