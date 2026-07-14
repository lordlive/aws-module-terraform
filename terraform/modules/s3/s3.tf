module "s3" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.0.1"

  bucket                  = var.bucket_name
  versioning              = var.versioning
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_object" "s3_folders" {
  provider     = aws
  bucket       = module.s3.s3_bucket_id
  acl          = "private"
  key          = "media/files/"
  content_type = "application/x-directory"
}
