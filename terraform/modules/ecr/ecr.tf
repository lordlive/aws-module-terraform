resource "aws_ecr_repository" "this" {
  for_each             = local.ecr_name
  name                 = each.value
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false # vulnerability analysis disable
  }

  encryption_configuration {
    encryption_type = "AES256" # AWS Standard Encryption by Default
  }
  force_delete = true
}

