variable "cluster_name" {
  type = string
}

variable "kubernetes_version" {
  type = string
}


variable "gcp_region" {
  type = string
}

variable "gcp_project" {
  type = string
}

variable "gcp_audience" {
  type = string
}

variable "gcp_service_account_email" {
  type = string
}

variable "jwt" {
  ephemeral = true
  type = string
}



