module "same_account_roles" {
  source = "./modules/same_account"
}

output "ec2_role_arn" {
  value = module.same_account_roles.ec2_role_arn
}

output "s3_role_arn" {
  value = module.same_account_roles.s3_role_arn
}