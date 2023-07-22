# Initialize the AWS provider
provider "aws" {
  region = var.aws_region
}

# Create the Virtual Private Cloud (VPC)
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "my-vpc"
  }
}

# Create the Subnets within the VPC
resource "aws_subnet" "main" {
  count      = length(var.subnet_cidr_blocks)
  cidr_block = var.subnet_cidr_blocks[count.index]
  vpc_id     = aws_vpc.main.id

  tags = {
    Name = "my-subnet-${count.index + 1}"
  }
}

# Create the Elastic Kubernetes Service (EKS) Cluster
module "eks" {
  source = "terraform-aws-modules/eks/aws"
  
  cluster_name = var.eks_cluster_name
  subnets      = aws_subnet.main.*.id
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# Create the Private Docker Registry using AWS ECR
resource "aws_ecr_repository" "main" {
  name = var.ecr_repository_name
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# Create the MySQL Database using Amazon RDS
resource "aws_db_instance" "mysql" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "my-mysql-db"
  username             = var.mysql_db_username
  password             = var.mysql_db_password
  parameter_group_name = "default.mysql5.7"
  publicly_accessible  = false  # For private access

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
