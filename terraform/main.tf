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
  subnets = module.vpc.private_subnets
  security_groups = [module.vpc.ecs_sg]

  target_group_arn = module.alb.target_group_arn
  container_image = module.ecr.repo_url
  execution_role_arn = module.iam.ecs_role
  db_host = module.rds.db_endpoint   
  db_user = var.db_username          
  db_name = "app"  
}

module "frontend" {
  source = "./modules/frontend"
  project_name = var.project_name
}