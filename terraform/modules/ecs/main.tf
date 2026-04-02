resource "aws_ecs_cluster" "cluster" {
  name = "${var.project_name}-cluster"
}
resource "aws_cloudwatch_log_group" "ecs" {
  name = "/ecs/devops-app"
}


resource "aws_ecs_task_definition" "task" {
  family                   = var.project_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"

  cpu    = "256"
  memory = "512"

  execution_role_arn = var.execution_role_arn

container_definitions = jsonencode([
    {
      name  = "backend"
      image = "${var.container_image}:latest"

      essential = true

      portMappings = [
        {
          containerPort = 8000
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/devops-app"
          awslogs-region        = "eu-central-1"
          awslogs-stream-prefix = "ecs"
        }
      }

      environment = [
        { name = "ENVIRONMENT", value = "production" },
        { name = "PROJECT_NAME", value = "DevOps App" },
        { name = "BACKEND_CORS_ORIGINS", value = "http://localhost,http://localhost:3000" },
        { name = "POSTGRES_SERVER", value = var.db_host },
        { name = "POSTGRES_USER", value = var.db_user },
        { name = "POSTGRES_DB", value = var.db_name },
        { name = "POSTGRES_PASSWORD", value = var.db_password }, 
        { name = "SECRET_KEY", value = "supersecretkey123" },
        { name = "FIRST_SUPERUSER", value = "admin@example.com" },
        { name = "FIRST_SUPERUSER_PASSWORD", value = "admin123" }

      ]
    }
  ])
}

resource "aws_ecs_service" "service" {
  name            = "${var.project_name}-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn

  desired_count = 2
  launch_type   = "FARGATE"

  network_configuration {
    subnets         = var.subnets
    security_groups = var.security_groups
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "backend"
    container_port   = 8000
  }
}