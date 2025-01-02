module "mysql_sg" {
  source = "git::https://github.com/HemanthKumar-75/terraform-aws-security-group.git?ref=main"
  # source = "../../terraform-aws-security-group"
  envinronment = var.envinronment
  project_name = var.project
  security_group = "Mysql"
  vpc_id = local.vpc_id.value
  common_tags = var.common_tags
  sg_tags = var.mysql_sg_tags
}

module "bastion_sg" {
  source = "git::https://github.com/HemanthKumar-75/terraform-aws-security-group.git?ref=main"
  # source = "../../terraform-aws-security-group"
  envinronment = var.envinronment
  project_name = var.project
  security_group = "bastion"
  vpc_id = local.vpc_id.value
  common_tags = var.common_tags
  sg_tags = var.bastion_sg_tags
}

module "node_sg" {
  source = "git::https://github.com/HemanthKumar-75/terraform-aws-security-group.git?ref=main"
  # source = "../../terraform-aws-security-group"
  envinronment = var.envinronment
  project_name = var.project
  security_group = "node"
  vpc_id = local.vpc_id.value
  common_tags = var.common_tags
  sg_tags = var.node_sg_tags
}

module "eks_control_plane_sg" {
  source = "git::https://github.com/HemanthKumar-75/terraform-aws-security-group.git?ref=main"
  # source = "../../terraform-aws-security-group"
  envinronment = var.envinronment
  project_name = var.project
  security_group = "eks-control-plane"
  vpc_id = local.vpc_id.value
  common_tags = var.common_tags
  sg_tags = var.eks_control_plane_sg_tags
}

module "ingress_alb_sg" {
  source = "git::https://github.com/HemanthKumar-75/terraform-aws-security-group.git?ref=main"
  # source = "../../terraform-aws-security-group"
  envinronment = var.envinronment
  project_name = var.project
  security_group = "ingress-alb"
  vpc_id = local.vpc_id.value
  common_tags = var.common_tags
  sg_tags = var.ingress_alb_sg_tags
}

# module "vpn_sg" {
#   source = "git::https://github.com/HemanthKumar-75/terraform-aws-security-group.git?ref=main"
#   # source = "../../terraform-aws-security-group"
#   envinronment = var.envinronment
#   project_name = var.project
#   security_group = "vpn"
#   vpc_id = local.vpc_id.value
#   common_tags = var.common_tags
# }

resource "aws_security_group_rule" "mysql_bastion" {
  type              = "ingress"
  from_port         = 22 #from RDS
  to_port           = 22 #from RDS
  protocol          = "tcp"
  source_security_group_id = module.bastion_sg.id
  security_group_id = module.mysql_sg.id
}

resource "aws_security_group_rule" "bastion_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"] # our organization IP details
  security_group_id = module.bastion_sg.id
}

# resource "aws_security_group_rule" "vpn_public" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   cidr_blocks = ["0.0.0.0/0"] # our organization IP details
#   security_group_id = module.vpn_sg.id
# }

# resource "aws_security_group_rule" "vpn_public_443" {
#   type              = "ingress"
#   from_port         = 443
#   to_port           = 443
#   protocol          = "tcp"
#   cidr_blocks = ["0.0.0.0/0"] # our organization IP details
#   security_group_id = module.vpn_sg.id
# }

# resource "aws_security_group_rule" "vpn_public_943" {
#   type              = "ingress"
#   from_port         = 943
#   to_port           = 943
#   protocol          = "tcp"
#   cidr_blocks = ["0.0.0.0/0"] # our organization IP details
#   security_group_id = module.vpn_sg.id
# }

# resource "aws_security_group_rule" "vpn_public_1194" {
#   type              = "ingress"
#   from_port         = 1194
#   to_port           = 1194
#   protocol          = "tcp"
#   cidr_blocks = ["0.0.0.0/0"] # our organization IP details
#   security_group_id = module.vpn_sg.id
# }

# resource "aws_security_group_rule" "ingress_alb_vpn" {
#   type              = "ingress"
#   from_port         = 30000
#   to_port           = 32767
#   protocol          = "tcp"
#   source_security_group_id = module.vpn_sg.id
#   security_group_id = module.ingress_alb_sg.id
# }

resource "aws_security_group_rule" "ingress_alb_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
  # source_security_group_id = module.vpn_sg.id
  security_group_id = module.ingress_alb_sg.id
}

resource "aws_security_group_rule" "ingress_alb_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
  # source_security_group_id = module.vpn_sg.id
  security_group_id = module.ingress_alb_sg.id
}

resource "aws_security_group_rule" "eks_control_plane_bastion" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  # cidr_blocks = [ "0.0.0.0/0" ]
  source_security_group_id = module.bastion_sg.id
  security_group_id = module.control_plane_sg.id
}

resource "aws_security_group_rule" "node_ingress_alb" {
  type              = "ingress"
  from_port         = 30000
  to_port           = 32767
  protocol          = "tcp"
  # cidr_blocks = [ "0.0.0.0/0" ]
  source_security_group_id = module.ingress_alb_sg.id
  security_group_id = module.node_sg.id
}

resource "aws_security_group_rule" "node_eks_control_plane" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  # cidr_blocks = [ "0.0.0.0/0" ]
  source_security_group_id = module.eks_control_plane_sg.id
  security_group_id = module.node_sg.id
}

resource "aws_security_group_rule" "eks_control_plane_node" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  # cidr_blocks = [ "0.0.0.0/0" ]
  source_security_group_id = module.node_sg.id
  security_group_id = module.eks_control_plane_sg.id
}

resource "aws_security_group_rule" "node_vpc" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks = [ "10.0.0.0/24" ]
  # source_security_group_id = module.node_sg.id
  security_group_id = module.node_sg.id
}

resource "aws_security_group_rule" "node_bastion" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  # cidr_blocks = [ "10.0.0.0/24" ]
  source_security_group_id = module.bastion_sg.id
  security_group_id = module.node_sg.id
}