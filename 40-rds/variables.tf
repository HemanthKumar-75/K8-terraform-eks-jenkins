variable "project_name" {
    default = "expense-eks"
}

variable "environment" {
    default = "dev"
}

variable "common_tags" {
    default = {
        Project = "expense-eks"
        Terraform = "true"
        Environment = "dev"
    }
}

variable "rds_tags" {
    default = {
        Component = "mysql"
    }
}

variable "zone_name" {
    default = "hemanthkumar.online"
}
