resource "tls_private_key" "key_pair_config" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_server_keypair" {
  key_name   = "${var.prefix_identifier}${var.key_pair_name}"
  public_key = tls_private_key.key_pair_config.public_key_openssh
  tags = merge(
    {},
    var.additional_tags,
  )
}

data "aws_ami" "Al2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"]
}

resource "aws_instance" "ec2" {
  ami                    = data.aws_ami.Al2.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.security_group.id]
  key_name               = "${var.prefix_identifier}${var.key_pair_name}"
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
  instance = aws_instance.ec2.id
  vpc      = true
  tags = merge(
    {},
    var.additional_tags,
  )
}

data "template_file" "user_data" {
  template = file("templates/mc-init.tpl")
  vars = {
    instance_hostname                = var.instance_hostname
    minecraft_server_memory          = var.minecraft_server_memory
    minecraft_data_bucket_id         = aws_s3_bucket.minecraft_data.id
    minecraft_world_backup_object    = aws_s3_bucket_object.world_data.id
    minecraft_settings_backup_object = aws_s3_bucket_object.settings.id
    minecraft_server_whitelist       = var.minecraft_server_whitelist
    minecraft_server_rcon            = var.minecraft_server_rcon
    minecraft_server_rcon_pass       = var.minecraft_server_rcon_pass
    minecraft_server_max_players     = var.minecraft_server_max_players
    minecraft_server_hardcore_mode   = var.minecraft_server_hardcore_mode
    minecraft_server_motd            = var.minecraft_server_motd
    minecraft_version_download_link  = var.minecraft_version_selector["1.17.1"]
  }
}
