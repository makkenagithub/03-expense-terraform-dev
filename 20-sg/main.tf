module "mysql_sg" {
    source = "../03-terraform-sg-module"

    project_name = var.project_name
    env = var.env
    sg_name = "mysql"
    vpc_id  = module.vpc.vpc_id
    common_tags = var.common_tags
    sg_tags = var.mysql_sg_tags
}