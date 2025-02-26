variable "project" {
  default = "expense-eks"
}

variable "envinronment" {
  default = "dev"
}

variable "common_tags" {
  default = {
    project = "expense-eks"
    envinronment = "dev"
    Terraform = true
    created-by = "HemanthKumar"
  }
}

variable "vpc_tags" {
  default = {
    number-of-subnets = 2
  }
}

variable "public_subnet_cidrblocks" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrblocks" {
  default = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "database_subnet_cidrblocks" {
  default = ["10.0.21.0/24", "10.0.22.0/24"]
}

# variable "is_peering_required" {
#   default = true
# }