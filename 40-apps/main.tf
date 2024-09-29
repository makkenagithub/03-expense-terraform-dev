# copied the code from open source module
# https://github.com/terraform-aws-modules/terraform-aws-ec2-instance

# by default it uses the git hub source for open source modules

module "mysql_ec2" {

    # by default it uses the git hub source for open source modules
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${local.resource_name}-mysql"

  ami = data.aws_ami.suresh.id

  instance_type          = "t3.micro"
  #key_name               = "user1"
  #monitoring             = true


  vpc_security_group_ids = [local.mysql_sg_id]
  subnet_id              = local.database_subnet_id

  tags = merge(
    var.common_tags,
    var.mysql_tags,
    {
        Name = "${local.resource_name}-mysql"
    }
  )
}

module "backend_ec2" {

    # by default it uses the git hub source for open source modules
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${local.resource_name}-backend"

  ami = data.aws_ami.suresh.id

  instance_type          = "t3.micro"
  #key_name               = "user1"
  #monitoring             = true


  vpc_security_group_ids = [local.backend_sg_id]
  subnet_id              = local.private_subnet_id

  tags = merge(
    var.common_tags,
    var.backend_tags,
    {
        Name =  "${local.resource_name}-backend"
    }
  )
}

module "frontend_ec2" {

    # by default it uses the git hub source for open source modules
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${local.resource_name}-frontend"

  ami = data.aws_ami.suresh.id

  instance_type          = "t3.micro"
  #key_name               = "user1"
  #monitoring             = true


  vpc_security_group_ids = [local.frontend_sg_id]
  subnet_id              = local.public_subnet_id

  tags = merge(
    var.common_tags,
    var.frontend_tags,
    {
        Name = "${local.resource_name}-frontend"
    }
  )
}