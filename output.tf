output "repository_name" {
  value = {
  for name in aws_ecr_repository.repo:
  name.name => name.name
  }
}
