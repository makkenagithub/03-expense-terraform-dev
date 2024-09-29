locals {
    #expense-dev
    resource_name = "${var.project_name}-${var.env}"
    # fetch the sg id from aws param store
    mysql_sg_id = data.aws_ssm_parameter.mysql_sg_id.value
    backend_sg_id = data.aws_ssm_parameter.backend_sg_id.value
    frontend_sg_id = data.aws_ssm_parameter.frontend_sg_id.value
    ansible_sg_id = data.aws_ssm_parameter.ansible_sg_id.value

        # conver string list to list and use first subnet ID
    public_subnet_id = split(",", data.aws_ssm_parameter.public_subnet_ids)[0]
    private_subnet_id = split(",", data.aws_ssm_parameter.private_subnet_ids)[0]
    database_subnet_id = split(",", data.aws_ssm_parameter.database_subnet_ids)[0]
}