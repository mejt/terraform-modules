resource "aws_security_group_rule" "ingress_cidr" {
  count             = var.create_with_cidr ? 1 : 0
  type              = "ingress"
  to_port           = var.port
  from_port         = var.port
  protocol          = var.protocol
  cidr_blocks       = var.sg_cidr_blocks
  security_group_id = var.sg_id
}

resource "aws_security_group_rule" "ingress_sg" {
  count                    = var.create_with_sg ? 1 : 0
  type                     = "ingress"
  to_port                  = var.port
  from_port                = var.port
  protocol                 = var.protocol
  source_security_group_id = var.sg_target_id
  security_group_id        = var.sg_id
}

