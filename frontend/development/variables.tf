# variable "vpc_cidr_block" {
#     type = string
#     description = "develop vpc cidr_block"
# }

variable "env" {
  type        = string
  default     = "development"
  description = "develop environment"
}

# variable "public_subnet_count" {
#   type = number
#   description = "public subnet count"
# }

# variable "pulbic_subnet_cidr_block" {
#   type = string
#   description = "public subnet cidr_block"
# }

# variable "private_subnet_count" {
#   type = number
#   description = "private subnet count"
# }

# variable "private_subnet_cidr_block" {
#   type = string
#   description = "private subnet cidr_block"
# }

variable "bucket_name" {
  type        = string
  description = "s3 bucket name"
}