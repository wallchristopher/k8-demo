variable "eks_name" {
  type        = string
  description = "The name of the EKS cluster"
  default     = "k8s-platform"
}

variable "eks_version" {
  type        = string
  description = "The version of the EKS cluster"
  default     = "1.31"
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

variable "vpc_one_nat_gateway_per_az" {
  type        = bool
  description = <<EOF
    Should be true if you want only one NAT Gateway per availability zone.
    Requires `var.azs` to be set, and the number of `public_subnets` created to be greater than or equal to the number of availability zones
    specified in `var.azs` of the underlying VPC module.
  EOF
  default     = false
}

variable "vpc_single_nat_gateway" {
  type        = bool
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  default     = false
}
