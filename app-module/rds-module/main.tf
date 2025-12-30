resource "aws_db_subnet_group" "wp_db_subnet_group" {
  name        = var.wp_db_subnet_group_name
  description = var.wp_db_subnet_group_description
  subnet_ids  = var.wp_db_subnet_ids

  tags = {
    Name = var.wp_db_subnet_group_name
  }
}

resource "aws_db_instance" "wp_db" {
  identifier = var.wp_db_identifier

  engine         = var.wp_db_engine
  engine_version = var.wp_db_engine_version
  instance_class = var.wp_db_instance_class

  allocated_storage = var.wp_db_allocated_storage

  db_name  = var.wp_db_name
  username = var.wp_db_username
  password = var.wp_db_password
  port     = var.wp_db_port

  vpc_security_group_ids = var.wp_db_security_group_ids
  db_subnet_group_name   = aws_db_subnet_group.wp_db_subnet_group.name

  multi_az            = var.wp_db_multi_az
  publicly_accessible = var.wp_db_publicly_accessible

  storage_encrypted        = var.wp_db_storage_encrypted
  backup_retention_period  = var.wp_db_backup_retention_period
  deletion_protection      = var.wp_db_deletion_protection
  apply_immediately        = var.wp_db_apply_immediately
  skip_final_snapshot      = var.wp_db_skip_final_snapshot
  final_snapshot_identifier = var.wp_db_skip_final_snapshot ? null : "${var.wp_db_identifier}-final-snapshot"

  tags = {
    Name = var.wp_db_identifier
  }
}
