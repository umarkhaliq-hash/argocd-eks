variable "bucket_prefix" {
  description = "Prefix for S3 bucket name"
  type        = string
  default     = "terraform-state"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}