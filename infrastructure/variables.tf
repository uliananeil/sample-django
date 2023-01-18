variable "region" {
  type    = string
  default = "us-east-1"
}

variable "ecr_repo" {
  type    = string
  default = "django-repo"
}

variable "rds_passwd" {
  type    = string
  default = "password123"
}

variable "cluster_name" {
    type = string
    default = "django-cluster"
}

variable "service_name" {
    type = string
    default = "django-service"
}