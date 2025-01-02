variable "project" {
  default = "Expense-EKS"
}

variable "envinronment" {
  default = "dev"
}

variable "common_tags" {
  default = {
    project = "Expense-EKS"
    envinronment = "dev"
    Terraform = true
    created-by = "HemanthKumar"
  }
}

variable "bastion_tags" {
  default = {}
}