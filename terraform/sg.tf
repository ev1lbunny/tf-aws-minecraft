resource "aws_security_group" "server_security_group" {
  name        = "${var.prefix_identifier}-security-group"
  description = "Configures All rules required for ${var.prefix_identifier}-server instance access and management"

  ingress {
    description = "Home LAN SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.ingress_access_cidr}"]
  }

  ingress {
    description = "Home LAN MCRCON Access"
    from_port   = 25575
    to_port     = 25575
    protocol    = "tcp"
    cidr_blocks = ["${var.ingress_access_cidr}"]
  }

  #tfsec:ignore:aws-vpc-no-public-ingress-sgr
  ingress {
    description = "Minecraft Server Rule #1"
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #tfsec:ignore:aws-vpc-no-public-ingress-sgr
  ingress {
    description = "Minecraft Server Rule #2"
    from_port   = 25565
    to_port     = 25565
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #tfsec:ignore:aws-vpc-no-public-egress-sgr
  egress {
    description = "Minecraft Server Rule #3"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {},
    var.additional_tags,
  )
}
