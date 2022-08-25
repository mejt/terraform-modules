output "aurora_endpoint" {
  value = aws_rds_cluster.aurora_cluster.endpoint
}

output "aurora_reader_endpoint" {
  value = aws_rds_cluster.aurora_cluster.reader_endpoint
}

output "aurora_database_name" {
  value = aws_rds_cluster.aurora_cluster.database_name
}

output "aurora_username" {
  value = aws_rds_cluster.aurora_cluster.master_username
}

output "aurora_password" {
  value = aws_rds_cluster.aurora_cluster.master_password
}
