# -------------------------
# DB SUBNET GROUP
# -------------------------
resource "aws_db_subnet_group" "db" {
  name       = "rds-subnet-group"
  subnet_ids = var.private_subnets
}

# -------------------------
# RDS SECURITY GROUP
# -------------------------
resource "aws_security_group" "rds" {
  vpc_id = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.ecs_sg]  # only ECS can access DB
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# -------------------------
# RDS INSTANCE
# -------------------------
resource "aws_db_instance" "db" {
  engine            = "postgres"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  username = var.db_username   # make sure not "admin"
  password = var.db_password

  db_name = "app"              

  port = 5432

  vpc_security_group_ids = [aws_security_group.rds.id]

  db_subnet_group_name = aws_db_subnet_group.db.name

  skip_final_snapshot = true
  publicly_accessible = false
}