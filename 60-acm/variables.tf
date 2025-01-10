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


variable "zone_name" {
    default = "hemanthkumar.online"
}

variable "zone_id" {
    default = "Z05267743DLV8AUL24HBJ"
}
