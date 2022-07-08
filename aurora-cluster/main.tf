resource "aws_rds_cluster_parameter_group" "aurora-postgresql_cluster_params" {
  name   = "${var.cluster_name}-parameter-group"
  family = var.aurora_family

  parameter {
    name  = "client_encoding"
    value = "utf8"
  }

  tags = var.tags
}

resource "aws_db_parameter_group" "aurora-postgresql_db_params" {
  name   = "${var.cluster_name}-db-parameter"
  family = var.aurora_family
  tags   = var.tags
}

resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier = var.cluster_name
  availability_zones = var.subnets_az
  database_name = var.db_name

  port                            = var.postgres_port
  master_username                 = var.master_username
  master_password                 = var.master_password
  engine                          = var.engine
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora-postgresql_cluster_params.id
  db_subnet_group_name            = aws_db_subnet_group.aurora_subnet_group.name
  vpc_security_group_ids          = [var.sg_id]
  final_snapshot_identifier       = "${var.cluster_name}-final-snapshot"
  backup_retention_period         = var.retention_days
  tags                            = var.tags
}

resource "aws_rds_cluster_instance" "aurora_cluster_instance" {
  count                           = var.desired_instances
  identifier                      = "${var.cluster_name}-instance-${count.index}"
  ca_cert_identifier              = var.rds_cluster_instance_ca_cert_identifier
  cluster_identifier              = aws_rds_cluster.aurora_cluster.id
  db_subnet_group_name            = aws_db_subnet_group.aurora_subnet_group.name
  instance_class                  = var.db_instance_class
  publicly_accessible             = false
  engine                          = "aurora-postgresql"
  db_parameter_group_name         = aws_db_parameter_group.aurora-postgresql_db_params.id
  performance_insights_enabled    = var.performance_insights_enabled
  performance_insights_kms_key_id = var.performance_insights_kms_key_id
  apply_immediately               = var.cluster_instance_apply_immediately
  tags                            = var.tags
}

resource "aws_db_subnet_group" "aurora_subnet_group" {
  name        = "${var.cluster_name}-db-subnet-group"
  description = "Allowed subnets for Aurora DB cluster instances"
  subnet_ids  = var.subnet_ids
  tags        = var.tags
}

