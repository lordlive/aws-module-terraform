output "repository_id" {
  value = {
    for k, repo in aws_ecr_repository.this : k => repo.registry_id
  }
}

output "repository_name" {
  value = {
    for k, repo in aws_ecr_repository.this : k => repo.repository_url
  }
}

output "repository_arn" {
  description = "The ARN of the ECR repository"
  value = {
    for k, repo in aws_ecr_repository.this : k => repo.arn
  }
}
