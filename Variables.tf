variable "aws_region" {
  description = "AWS region for Floci simulation"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "subnet_cidr" {
  description = "Legacy subnet CIDR retained for existing tfvars"
  type        = string
  default     = "10.0.1.0/24"
}

variable "bucket_name" {
  description = "Unique bucket name within this Floci environment"
  type        = string
}
