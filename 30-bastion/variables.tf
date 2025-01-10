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

variable "bastion_tags" {
  default = {}
}