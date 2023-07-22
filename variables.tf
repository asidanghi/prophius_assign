variable "aws_region" {
  description = "AWS region where resources will be created."
  default     = "us-west-2"  # Change this to your desired region (e.g., us-west-2 for Oregon)
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_blocks" {
  description = "CIDR blocks for the subnets."
  default     = ["10.0.1.0/24", "10.0.2.0/24"]  # Add more subnets if needed
}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster."
  default     = "my-demo-eks-cluster"  # Change this to your desired cluster name
}

variable "ecr_repository_name" {
  description = "Name of the ECR repository."
  default     = "my-demo-ecr-repo"  # Change this to your desired repository name
}

variable "mysql_db_username" {
  description = "Username for the MySQL database."
  type        = string
  sensitive   = true
  default     = "demo_dbuser"  # Change this to your desired MySQL username
}

variable "mysql_db_password" {
  description = "Password for the MySQL database."
  type        = string
  sensitive   = true
  default     = "demo_dbpassword"  # Change this to your desired MySQL password
}
