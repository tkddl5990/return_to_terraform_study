variable "vpc_cidr_block" {
    type = string
}

variable "env" {
    type = string
}

variable "public_subnet_count" {
  type = number
}

variable "pulbic_subnet_cidr_block" {
  type = string
}

variable "private_subnet_count" {
  type = number
}

variable "private_subnet_cidr_block" {
  type = string
}