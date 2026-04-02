# =========================
# Backend Repository
# =========================
resource "aws_ecr_repository" "backend" {
  name = "${var.project_name}-backend"
}

# =========================
# Frontend Repository
# =========================
resource "aws_ecr_repository" "frontend" {
  name = "${var.project_name}-frontend"
}

# =========================
# Outputs
# =========================
output "backend_repo_url" {
  value = aws_ecr_repository.backend.repository_url
}

output "frontend_repo_url" {
  value = aws_ecr_repository.frontend.repository_url
}