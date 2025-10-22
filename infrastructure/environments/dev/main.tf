provider "aws" {
  region = "us-west-2"
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", local.cluster_name]
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", local.cluster_name]
    }
  }
}

# Data sources
data "aws_availability_zones" "available" {
  state = "available"
}

# Locals
locals {
  project_name = "argocd-gitops"
  environment  = "dev"
  cluster_name = "${local.project_name}-${local.environment}-cluster"
  
  common_tags = {
    Project     = local.project_name
    Environment = local.environment
    ManagedBy   = "terraform"
  }
}

# S3 Backend
module "s3_backend" {
  source = "../../modules/s3-backend"
  
  bucket_prefix = "${local.project_name}-terraform-state"
  tags          = local.common_tags
}

# VPC Module
module "vpc" {
  source = "../../modules/vpc"
  
  name_prefix            = "${local.project_name}-${local.environment}"
  availability_zones     = data.aws_availability_zones.available.names
  tags                   = local.common_tags
}

# IAM Module
module "iam" {
  source = "../../modules/iam"
  
  cluster_name = local.cluster_name
  tags         = local.common_tags
}

# EKS Module
module "eks" {
  source = "../../modules/eks"
  
  cluster_name        = local.cluster_name
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  cluster_role_arn   = module.iam.eks_cluster_role_arn
  node_role_arn      = module.iam.eks_node_role_arn
  tags               = local.common_tags
}

# ArgoCD Module
module "argocd" {
  source = "../../modules/argocd"
  
  cluster_name = local.cluster_name
  tags         = local.common_tags
  
  depends_on = [module.eks]
}

# Monitoring Module
module "monitoring" {
  source = "../../modules/monitoring"
  
  cluster_name = local.cluster_name
  tags         = local.common_tags
  
  depends_on = [module.eks]
}