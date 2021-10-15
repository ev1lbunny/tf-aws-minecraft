variable "aws_region" {
  description = "Region of aws to use"
  type        = string
  default     = "eu-west-2"
}

variable "aws_credentials_profile" {
  description = "High level profile name that the terraform uses for aws access to create new role/policy/user for pihole deployment"
  type        = string
}

variable "ingress_access_ip_address" {
  description = "Ip address that you will access the minecraft from. All other access will be locked."
  type        = string
}

variable "key_pair_name" {
  description = "Name to give the generated keypair that will be associated with the minecraft server ec2 instance for ssh access"
  type        = string
  default     = "server-keypair"
}

variable "additional_tags" {
  description = "Additional resource tags"
  type        = map(string)
  default     = { Name = "Minecraft" }
}

variable "prefix_identifier" {
  description = "Prefix added to all resources in aws to differentiate between types of infra setup"
  type        = string
  default     = "mc-"
}

variable "instance_type" {
  description = "Requested Instance Type"
  type        = string
  default     = "t2.small"
}

variable "instance_hostname" {
  description = "Requested Instance Hostname"
  type        = string
  default     = "aws-minecraft-server"
}

variable "instance_volume_size" {
  description = "Requested Instance Volume Size"
  type        = number
  default     = 8
}

variable "minecraft_version_selector" {
  description = "Version of Minecraft Server files to download"
  type        = map(any)
  default     = { "1.17.1" = "https://launcher.mojang.com/v1/objects/a16d67e5807f57fc4e550299cf20226194497dc2/server.jar" }
}

variable "minecraft_bucket_name" {
  description = "Name for the bucket where world data backups are stored"
  type        = string
  default     = "minecraft-server-world-data"
}

variable "minecraft_bucket_world_directory_object" {
  description = "Folder object in the bucket where world data backups are stored"
  type        = string
  default     = "minecraft/minecraft_server_word_data_backups/"
}

variable "minecraft_bucket_whitelist_directory_object" {
  description = "Folder object in the bucket where world data backups are stored"
  type        = string
  default     = "minecraft/minecraft_server_settings_backups/"
}

variable "minecraft_server_whitelist" {
  description = "Turn on and off the server whitelist capability with true/false"
  type        = string
  default     = "false"
}

variable "minecraft_server_rcon" {
  description = "Turn on and off the server rcon capability with true/false"
  type        = string
  default     = "false"
}

variable "minecraft_server_rcon_pass" {
  description = "Server Rcon Password"
  type        = string
  default     = "please_change_me_if_using_rcon"
}

variable "minecraft_server_max_players" {
  description = "Max number of players allowed on server"
  type        = number
  default     = 10
}

variable "minecraft_server_hardcore_mode" {
  description = "Run server in permadeath mode"
  type        = string
  default     = "false"
}

variable "minecraft_server_motd" {
  description = "Server Message of the Day"
  type        = string
  default     = "Welcome to Minecraft"
}
