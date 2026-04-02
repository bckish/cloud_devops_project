module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  project_name = var.project_name
}

module "ecr" {
  source = "./modules/ecr"
  project_name = var.project_name
}

module "iam" {
  source = "./modules/iam"
  project_name = var.project_name
}

module "alb" {
  source = "./modules/alb"
  vpc_id = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  alb_sg = module.vpc.alb_sg
  project_name = var.project_name
}

module "rds" {
  source = "./modules/rds"
  private_subnets = module.vpc.private_subnets
  db_username = var.db_username
  db_password = var.db_password
  vpc_id = module.vpc.vpc_id
  ecs_sg = module.vpc.ecs_sg
}

module "ecs" {
  source = "./modules/ecs"

  project_name = var.project_name

  # Networking
  subnets         = module.vpc.public_subnets
  security_groups = [module.vpc.ecs_sg]

  # Backend (existing)
  container_image = module.ecr.backend_repo_url
  target_group_arn = module.alb.backend_tg

  # Frontend (NEW)
  frontend_image             = module.ecr.frontend_repo_url
  frontend_target_group_arn  = module.alb.frontend_tg

  # IAM
  execution_role_arn = module.iam.ecs_execution_role
  task_role_arn      = module.iam.ecs_task_role

  # Database
  db_host     = split(":", module.rds.db_endpoint)[0]
  db_user     = var.db_username
  db_password = var.db_password
  db_name     = "app"
}

module "frontend" {
  source = "./modules/frontend"
  project_name = var.project_name
}