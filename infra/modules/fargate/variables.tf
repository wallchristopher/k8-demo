variable "cluster_name" {
  type        = string
  description = "The name of the cluster"
  default     = "k8s-platform"
}

variable "cluster_version" {
  type        = string
  description = "The version of the cluster"
  default     = "1.19"
}

variable "azs" {
  type        = list(string)
  description = "The availability zones to deploy to"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_subnets" {
  description = "The IDs of the public subnets within the VPC"
  type        = list(string)
}

variable "private_subnets" {
  description = "The IDs of the private subnets within the VPC"
  type        = list(string)
}

variable "intra_subnets" {
  type        = list(string)
  description = "The IDs of the intra subnets within the VPC"
}

variable "thanos_s3_bucket_name" {
  type        = string
  description = "The name of the S3 bucket to store Thanos metrics (REQUIRED)"
}
