module "mysql_sg" {
    source = "../../03-terraform-sg-module"
    # to give source from module prepared in GITHUB
    # source = "git::https://github.com/makkenagithub/03-terraform-sg-module.git?ref=main"

    project_name = var.project_name
    env = var.env
    sg_name = "mysql"
    vpc_id  = local.vpc_id
    common_tags = var.common_tags
    sg_tags = var.mysql_sg_tags
}

module "backend_sg" {
    source = "../../03-terraform-sg-module"
    # to give source from module prepared in GITHUB
    # source = "git::https://github.com/makkenagithub/03-terraform-sg-module.git?ref=main"

    project_name = var.project_name
    env = var.env
    sg_name = "backend"
    vpc_id  = local.vpc_id
    common_tags = var.common_tags
    sg_tags = var.backend_sg_tags
}

module "frontend_sg" {
    source = "../../03-terraform-sg-module"
    # to give source from module prepared in GITHUB
    # source = "git::https://github.com/makkenagithub/03-terraform-sg-module.git?ref=main"

    project_name = var.project_name
    env = var.env
    sg_name = "frontend"
    vpc_id  = local.vpc_id
    common_tags = var.common_tags
    sg_tags = var.frontend_sg_tags
}

module "bastion_sg" {
    source = "../../03-terraform-sg-module"
    # to give source from module prepared in GITHUB
    # source = "git::https://github.com/makkenagithub/03-terraform-sg-module.git?ref=main"

    project_name = var.project_name
    env = var.env
    sg_name = "bastion"
    vpc_id  = local.vpc_id
    common_tags = var.common_tags
    sg_tags = var.bastion_sg_tags
}

module "ansible_sg" {
    source = "../../03-terraform-sg-module"
    # to give source from module prepared in GITHUB
    # source = "git::https://github.com/makkenagithub/03-terraform-sg-module.git?ref=main"

    project_name = var.project_name
    env = var.env
    sg_name = "ansible"
    vpc_id  = local.vpc_id
    common_tags = var.common_tags
    sg_tags = var.ansible_sg_tags
}

# mysql allowing connection on 3306 from instances attched to backed sg
resource "aws_security_group_rule" "mysql_backend" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  # accept connections from this source
  source_security_group_id = module.backend_sg.id
  #cidr_blocks       = [aws_vpc.example.cidr_block]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  
  # security group to apply this rule to
  security_group_id = module.mysql_sg.id
}


# backend allowing connection on 8080 from instances attched to frontend sg
resource "aws_security_group_rule" "backend_frontend" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  # accept connections from this source
  source_security_group_id = module.frontend_sg.id
  #cidr_blocks       = [aws_vpc.example.cidr_block]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  
  # security group to apply this rule to
  security_group_id = module.backend_sg.id
}

# frontend allowing connection on 80 from public
resource "aws_security_group_rule" "frontend_public" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  # accept connections from this source
  #source_security_group_id = module.frontend_sg.id

  cidr_blocks       = ["0.0.0.0/0"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  
  # security group to apply this rule to
  security_group_id = module.frontend_sg.id
}

# mysql allowing connection on 22 from bastion
resource "aws_security_group_rule" "mysql_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # accept connections from this source
  source_security_group_id = module.bastion_sg.id

  #cidr_blocks       = ["0.0.0.0/0"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  
  # security group to apply this rule to
  security_group_id = module.mysql_sg.id
}

# backend allowing connection on 22 from bastion
resource "aws_security_group_rule" "backend_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # accept connections from this source
  source_security_group_id = module.bastion_sg.id

  #cidr_blocks       = ["0.0.0.0/0"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  
  # security group to apply this rule to
  security_group_id = module.backend_sg.id
}

# frontend allowing connection on 22 from bastion
resource "aws_security_group_rule" "frontend_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # accept connections from this source
  source_security_group_id = module.bastion_sg.id

  #cidr_blocks       = ["0.0.0.0/0"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  
  # security group to apply this rule to
  security_group_id = module.frontend_sg.id
}

resource "aws_security_group_rule" "bastion_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # accept connections from this source
  #source_security_group_id = module.ansible_sg.id

  cidr_blocks       = ["0.0.0.0/0"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  
  # security group to apply this rule to
  security_group_id = module.bastion_sg.id
}


# mysql allowing connection on 22 from ansible
resource "aws_security_group_rule" "mysql_ansible" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # accept connections from this source
  source_security_group_id = module.ansible_sg.id

  #cidr_blocks       = ["0.0.0.0/0"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  
  # security group to apply this rule to
  security_group_id = module.mysql_sg.id
}

# backend allowing connection on 22 from ansible
resource "aws_security_group_rule" "backend_ansible" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # accept connections from this source
  source_security_group_id = module.ansible_sg.id

  #cidr_blocks       = ["0.0.0.0/0"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  
  # security group to apply this rule to
  security_group_id = module.backend_sg.id
}

# frontend allowing connection on 22 from ansible
resource "aws_security_group_rule" "frontend_ansible" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # accept connections from this source
  source_security_group_id = module.ansible_sg.id

  #cidr_blocks       = ["0.0.0.0/0"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  
  # security group to apply this rule to
  security_group_id = module.frontend_sg.id
}


resource "aws_security_group_rule" "ansible_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # accept connections from this source
  #source_security_group_id = module.ansible_sg.id

  cidr_blocks       = ["0.0.0.0/0"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  
  # security group to apply this rule to
  security_group_id = module.ansible_sg.id
}


