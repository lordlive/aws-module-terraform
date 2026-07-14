variable "bucket_name" {
  type        = string
  description = "S3 name"
  default     = "807291694811-default-bucket-name"
}

variable "environment" {
  type        = string
  description = "Environment to provision"
  default     = "dev"
}

variable "versioning" {
  type        = map(any)
  description = "S3 versioning"
  default = {
    enabled = false
  }
}

variable "block_public_acls" {
  type        = string
  description = "Block public acl"
  default     = true
}

variable "block_public_policy" {
  type        = string
  description = "Block public policy"
  default     = true
}

variable "ignore_public_acls" {
  type        = string
  description = "Ignore public acl"
  default     = true
}

variable "restrict_public_buckets" {
  type        = string
  description = "Restrict public buckets"
  default     = true
}
