variable "cluster_name" {
}

variable "master_username" {
}

variable "master_password" {
}

variable "postgres_port" {
}

variable "db_name" {
}

variable "sg_id" {
}

variable "subnet_ids" {
  type = list(string)
}

variable "subnets_az" {
  type = list(string)
}

variable "aurora_family" {
  default = "aurora-postgresql10"
}

variable "engine_version" {
  default = "10.7"
}

variable "engine" {
  default = "aurora-postgresql"
}

variable "retention_days" {
}

variable "db_instance_class" {
}

variable "desired_instances" {
}

variable "critical_cpu_threshold" {
}

variable "should_create_alarms" {
}

variable "tags" {
  type = map(string)
}

variable "performance_insights_enabled" {
  default     = "false"
}

variable "performance_insights_kms_key_id" {
  default     = ""
  description = "The ARN for the KMS key"
}

variable "cluster_instance_apply_immediately" {
  default     = "false"
}

variable "rds_cluster_instance_ca_cert_identifier" {
  default     = "rds-ca-2019"
}
