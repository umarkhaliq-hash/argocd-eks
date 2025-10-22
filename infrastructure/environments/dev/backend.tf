terraform {
  backend "s3" {
    bucket  = "argocd-gitops-terraform-state-6rj5rnyo"
    key     = "environments/dev/terraform.tfstate"
    region  = "us-west-2"
    encrypt = true
  }
}