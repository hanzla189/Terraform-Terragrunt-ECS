output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "database_subnet_ids" {
  value = module.vpc.database_subnet_ids
}

output "database_subnet_group_name" {
  value = module.vpc.database_subnet_group_name
}

output "alb_security_group_id" {
  value = module.vpc.alb_security_group_id
}

output "ecs_app_security_group_id" {
  value = module.vpc.ecs_app_security_group_id
}

output "rds_security_group_id" {
  value = module.vpc.rds_security_group_id
}

output "redis_security_group_id" {
  value = module.vpc.redis_security_group_id
}

output "management_security_group_id" {
  value = module.vpc.management_security_group_id
}
