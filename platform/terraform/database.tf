module "aurora_postgresql_serverless" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "~> 9.0"

  name            = "k8s-platform"
  engine          = "aurora-postgresql"
  engine_mode     = "provisioned"
  engine_version  = 16.4
  master_username = "root"

  vpc_id               = module.vpc.vpc_id
  db_subnet_group_name = module.vpc.database_subnet_group_name
  security_group_rules = {
    vpc_ingress = {
      cidr_blocks = module.vpc.private_subnets_cidr_blocks
    }
  }

  monitoring_interval = 60

  apply_immediately   = true
  skip_final_snapshot = true

  enable_http_endpoint = true

  serverlessv2_scaling_configuration = {
    auto_pause   = true
    min_capacity = 0.5
    max_capacity = 5
  }

  instance_class = "db.serverless"
  instances = {
    1 = {}
    2 = {}
  }
}
