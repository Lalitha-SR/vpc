module "vpc" {
  source               = "./modules/vpc"
  project_name         = var.project_name
  managed_by           = var.managed_by
  vpc_cidr             = var.vpc_cidr

  public_subnet_cidrs  = local.public_subnet_cidrs
  private_subnet_cidrs = local.private_subnet_cidrs
}

module "security" {
  source       = "./modules/security"
  vpc_id       = module.vpc.vpc_id
  project_name = var.project_name
  ssh_cidr     = var.ssh_cidr
}

module "alb" {
  source       = "./modules/alb"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  subnets      = module.vpc.public_subnet_ids
  alb_sg_id    = module.security.alb_sg_id
}

module "dynamodb" {
  source       = "./modules/dynamodb"
  table_name   = "${var.project_name}-table"
  project_name = var.project_name
}

module "iam_dynamodb" {
  source             = "./modules/iam_dynamodb"
  project_name       = var.project_name
  dynamodb_table_arn = module.dynamodb.table_arn
}


module "dynamodb_endpoint" {
  source          = "./modules/vpc_endpoint"
  vpc_id          = module.vpc.vpc_id
  region          = var.region
  project_name    = var.project_name
  route_table_ids = [module.vpc.private_route_table_id]
}

module "user_data" {
  source = "./modules/user_data"
}

module "web_ec2" {
  source               = "./modules/ec2"
  ami                  = var.ami_id
  instance_type        = var.instance_type
  subnet_id            = module.vpc.public_subnet_ids[0]
  sg_id                = module.security.ec2_sg_id
  iam_instance_profile = module.iam_dynamodb.instance_profile_name
  user_data            = module.user_data.user_data
  key_name             = var.key_name
  public_ip            = true
  name = "${var.project_name}-${var.web_instance_name}"
}

