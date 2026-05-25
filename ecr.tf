resource "aws_ecr_repository" "ecr-site" {
  name = "site_prod"
  image_tag_mutability = "MUTABLE"
}