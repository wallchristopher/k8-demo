variable "eks_name" {
  type        = string
  description = "The name of the EKS cluster"
  default     = "platform"
}

variable "eks_version" {
  type        = string
  description = "The version of the EKS cluster"
  default     = "1.30"
}

variable "vpc_name" {
  type        = string
  description = "The name of the VPC to deploy to"
  default     = "k8s-platform"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}
