module "vpc" {
  source                = "./modules/vpc"
  name                  = var.name
  vpc_cidr              = var.vpc_cidr
  private_subnet1_cidr  = var.private_subnet1_cidr
  private_subnet2_cidr  = var.private_subnet2_cidr
  public_subnet1_cidr   = var.public_subnet1_cidr
  public_subnet2_cidr   = var.public_subnet2_cidr
}

module "sg" {
    source              = "./modules/security_groups"
    name                = var.name
    vpc_id              = module.vpc.vpc_id
}

module "eks" {
    source              = "./modules/eks"
    name                = var.name
    subnet1             = module.vpc.private_subnet1_id
    subnet2             = module.vpc.private_subnet2_id
    host                = var.hostname
    filename            = var.filename
}

module "node_group" {
    source              = "./modules/eks_node_group"
    name                = var.name
    cluster_version     = var.cluster_version
    eks_cluster_name    = module.eks.cluster_name
    subnet1             = module.vpc.private_subnet1_id
    subnet2             = module.vpc.private_subnet2_id
    ami_type            = var.ami_type
    desired_size        = var.desired_size
    max_size            = var.max_size
    min_size            = var.min_size
    instance_type       = var.instance_type
}



