resource "aws_security_group" "security_group" {
  name        = "${var.prefix_identifier}-security-group"
  description = "Configures All rules required for ${var.prefix_identifier}-server instance access and management"

  ingress {
    description = "Home LAN SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.ingress_access_ip_address}/32"]
  }

  ingress {
    description = "Open Ingress on Minecraft Server Port"
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS008
  }

  egress {
    description = "Open Egress for Minecraft Server"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS009
  }

  tags = merge(
    {},
    var.additional_tags,
  )
}
