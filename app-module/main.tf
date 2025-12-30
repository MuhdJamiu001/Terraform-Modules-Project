module "vpc" {
  source = "./vpc-module"

  wp_zone1 = var.wp_zone1
  wp_zone2 = var.wp_zone2
}

module "web_security_group" {
  source = "./web_security_group-module"

  wp_vpc_id   = module.vpc.wp_vpc_id
  wp_ssh_cidr = var.wp_ssh_cidr
}

module "compute" {
  source = "./compute-module"

  subnet_id          = module.vpc.wp_public_subnet_ids[0]
  security_group_ids = [module.web_security_group.wp_security_group_id]
  key_name           = var.wp_key_name


}

module "db_security_group" {
  source = "./db_security_group-module"

  wp_vpc_id    = module.vpc.wp_vpc_id
  wp_web_sg_id = module.web_security_group.wp_security_group_id
}

module "rds" {
  source = "./rds-module"

  wp_db_subnet_ids         = module.vpc.wp_private_subnet_ids
  wp_db_security_group_ids = [module.db_security_group.wp_db_security_group_id]

  wp_db_password = var.wp_db_password
}
