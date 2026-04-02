# =========================
# ECS Execution Role (existing)
# =========================
resource "aws_iam_role" "ecs_execution" {
  name = "${var.project_name}-ecs-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
  role       = aws_iam_role.ecs_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# =========================
# ECS Task Role (for app permissions)
# =========================
resource "aws_iam_role" "ecs_task" {
  name = "${var.project_name}-ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

# (Optional) Attach minimal permissions if needed later
# Example: S3 read access
# resource "aws_iam_role_policy_attachment" "ecs_task_s3" {
#   role       = aws_iam_role.ecs_task.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
# }

# =========================
# Read-Only Role (Assignment Requirement)
# =========================
resource "aws_iam_role" "readonly" {
  name = "${var.project_name}-readonly-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        AWS = "arn:aws:iam::951125265291:user/github-actions" 
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "readonly_cloudwatchs" {
  role       = aws_iam_role.readonly.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"
}


# =========================
# Outputs
# =========================
output "ecs_execution_role" {
  value = aws_iam_role.ecs_execution.arn
}

output "ecs_task_role" {
  value = aws_iam_role.ecs_task.arn
}

output "readonly_role" {
  value = aws_iam_role.readonly.arn
}