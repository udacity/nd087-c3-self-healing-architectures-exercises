module "project_eks" {
  source             = "./modules/eks"
  name               = local.name
  account            = data.aws_caller_identity.current.account_id
  private_subnet_ids = module.vpc.private_subnet_ids
  vpc_id             = module.vpc.vpc_id
  nodes_desired_size = 1  
  nodes_max_size     = 10  # Adjust this based on the requirements
  nodes_min_size     = 1

  depends_on = [
    module.vpc,
  ]
}