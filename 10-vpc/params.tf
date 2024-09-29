# store the vpc id to smm parameter store
# one  param store exists across AWS account
resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project_name}/${var.env}/vpc_id"
  type  = "String"
  value = module.vpc.vpc_id
}