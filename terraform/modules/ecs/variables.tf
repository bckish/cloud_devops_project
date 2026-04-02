variable "project_name" {}
variable "subnets" {}
variable "security_groups" {}
variable "target_group_arn" {}
variable "container_image" {}
variable "execution_role_arn" {}
variable "db_host" {}
variable "db_user" {}
variable "db_name" {}

variable "db_password" {
  description = "Database password"
  type        = string
}

variable "task_role_arn" {
  description = "ECS task role ARN"
  type        = string
}

variable "frontend_image" {
  description = "Frontend ECR image"
  type        = string
}

variable "frontend_target_group_arn" {
  description = "Frontend ALB target group"
  type        = string
}