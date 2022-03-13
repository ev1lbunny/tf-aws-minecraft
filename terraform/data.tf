data "aws_ami" "al2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn*"]
  }

  filter {
    name   = "name"
    values = ["*kernel*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

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

data "template_file" "user_data" {
  template = file("${path.module}/templates/mc-init.tpl")
  vars = {
    instance_hostname                = var.instance_hostname
    minecraft_server_memory          = var.minecraft_server_memory
    minecraft_data_bucket_id         = aws_s3_bucket.minecraft_data.id
    minecraft_world_backup_object    = aws_s3_object.world_data.id
    minecraft_settings_backup_object = aws_s3_object.settings.id
    minecraft_server_whitelist       = var.minecraft_server_whitelist
    minecraft_server_rcon            = var.minecraft_server_rcon
    minecraft_server_rcon_pass       = var.minecraft_server_rcon_pass
    minecraft_server_max_players     = var.minecraft_server_max_players
    minecraft_server_hardcore_mode   = var.minecraft_server_hardcore_mode
    minecraft_server_motd            = var.minecraft_server_motd
    minecraft_version_download_link  = var.minecraft_version_selector["1.18.2"]
  }
}
