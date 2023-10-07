resource "aws_db_parameter_group" "rds_pg" {
  name   = "scenario8rsds-pg"
  family = "postgres14"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

resource "aws_db_subnet_group" "sbg" {
  name       = "scenario8rds-sbg"
  subnet_ids = [aws_subnet.pub_sbn_a.id, aws_subnet.pub_sbn_b.id]

  tags = {
    Name = "${var.prefix}-sbg"
  }
}

resource "aws_db_instance" "rds_ins" {
  identifier             = "scenario8rds-id"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "14.3"
  username               = "rdsuser"
  password               = "rdspassword"
  db_subnet_group_name   = aws_db_subnet_group.sbg.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  parameter_group_name   = aws_db_parameter_group.rds_pg.name
  publicly_accessible    = true
  skip_final_snapshot    = true
  tags = {
    Name = "${var.prefix}-rds-ins"
  }  
}
