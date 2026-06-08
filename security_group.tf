resource "aws_security_group" "alb_sg" {
  name        = "HamzaBlertin-master-alb-sg"
  description = "Security group for public Application Load Balancer"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "HamzaBlertin-master-alb-sg"
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "HamzaBlertin-master-ec2-sg"
  description = "Security group for private EC2 instances"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "HamzaBlertin-master-ec2-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb_allow_http_ipv4" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "alb_allow_all_outbound_ipv4" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
resource "aws_vpc_security_group_ingress_rule" "ec2_allow_http_from_alb" {
  security_group_id            = aws_security_group.ec2_sg.id
  description                  = "Allow HTTP only from ALB security group"
  referenced_security_group_id = aws_security_group.alb_sg.id
  from_port                    = 80
  ip_protocol                  = "tcp"
  to_port                      = 80
}

resource "aws_vpc_security_group_egress_rule" "ec2_allow_all_outbound_ipv4" {
  security_group_id = aws_security_group.ec2_sg.id
  description       = "Allow all outbound traffic"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

