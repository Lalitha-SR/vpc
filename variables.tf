variable "project_name" {}
variable "managed_by" {}
variable "region" {}

variable "vpc_cidr" {}

# variable "public_subnet_cidrs" {
#   type = list(string)
# }

# variable "private_subnet_cidrs" {
#   type = list(string)
# }

variable "ssh_cidr" {}

variable "ami_id" {}
variable "instance_type" {}
variable "key_name" {}
variable "web_instance_name" {
  description = "Name tag for web EC2 instance"
  type        = string
}


variable "dynamodb_table_arn" {}
