resource "aws_ecr_repository" "repo" {
  for_each = var.name
  name     = each.value

  image_scanning_configuration {
    scan_on_push = true
  }
  
  tags = merge(var.tags)
}

resource "aws_ecr_lifecycle_policy" "repo" {
  depends_on = [aws_ecr_repository.repo]
  for_each = var.name
  repository = each.value

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 10,
            "description": "Remove old images",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["t"],
                "countType": "imageCountMoreThan",
                "countNumber": 100
            },
            "action": {
                "type": "expire"
            }
        },
        {
            "rulePriority": 20,
            "description": "Expire untagged images",
            "selection": {
                "tagStatus": "untagged",
                "countType": "imageCountMoreThan",
                "countNumber": 1
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
