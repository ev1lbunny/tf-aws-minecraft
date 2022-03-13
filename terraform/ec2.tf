resource "tls_private_key" "key_pair_config" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_server_keypair" {
  key_name   = "${var.prefix_identifier}-${var.key_pair_name}"
  public_key = tls_private_key.key_pair_config.public_key_openssh
  tags = merge(
    {},
    var.additional_tags,
  )
}

resource "aws_instance" "ec2" {
  count                  = var.enable_on_demand ? 1 : 0
  ami                    = data.aws_ami.al2.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.server_security_group.id]
  key_name               = "${var.prefix_identifier}-${var.key_pair_name}"
  root_block_device {
    volume_size = var.instance_volume_size
    tags = merge(
      {},
      var.additional_tags,
    )
  }
  iam_instance_profile = aws_iam_instance_profile.minecraft_s3_access_profile.name
  user_data            = data.template_file.user_data.rendered
  tags = merge(
    {},
    var.additional_tags,
  )
}

resource "aws_eip" "elastic_ip" {
  instance = aws_instance.ec2.*.id
  vpc      = true
  tags = merge(
    {},
    var.additional_tags,
  )
}
