resource "aws_security_group" "allow_aurora_access" {
  name        = "allow-${var.db_name}-aurora-access"
  description = "Allow access to aurora instances."
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "TCP"
    security_groups = var.allow_db_access_sgs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow ${var.db_name} Aurora Access"
  }
}