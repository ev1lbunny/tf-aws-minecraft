variable "additional_tags" {
  description = "Additional resource tags"
  type        = map(string)
  default     = { Name = "Minecraft" }
}

variable "asg_desired_capacity" {
  description = "Autoscaling group desired capacity"
  type        = number
  default     = 1
}

variable "asg_on_demand_base_capacity" {
  description = "Absolute minimum amount of desired capacity that must be fulfilled by on-demand instances"
  type        = number
  default     = 0
}

variable "asg_on_demand_percentage_above_base_capacity" {
  description = "Percentage split between on-demand and Spot instances above the base on-demand capacity. Default will always assume you want 0% on demand above the base capacity"
  type        = number
  default     = 0
}

variable "asg_max_size" {
  description = "Autoscaling group maximum size"
  type        = number
  default     = 1
}

variable "asg_min_size" {
  description = "Autoscaling group minimum size"
  type        = number
  default     = 0
}

variable "associate_public_ip_address" {
  description = "Associate a public ip address with the instances."
  type        = bool
  default     = false
}

variable "aws_credentials_profile" {
  description = "High level profile name that the terraform uses for aws access to create new role/policy/user for pihole deployment"
  type        = string
}

variable "aws_region" {
  description = "Region of aws to use"
  type        = string
  default     = "eu-west-2"
}

variable "enable_on_demand" {
  description = "Determins if or not you want MC on on demand ec2 instance."
  type        = bool
  default     = false
}

variable "enable_spot_fleet" {
  description = "Determins if or not you want MC to run on spot fleet"
  type        = bool
  default     = true
}

variable "ingress_access_cidr" {
  description = "Cidr block that you will ssh access the minecraft server from. All other inbound ssh access will be blocked."
  type        = string
}

variable "instance_hostname" {
  description = "Requested Instance Hostname"
  type        = string
  default     = "aws-minecraft-server"
}

variable "instance_type" {
  description = "Requested Instance Type"
  type        = string
  default     = "t3.small"
}

variable "instance_types_array" {
  description = "Requested Instance Types allows in spot fleet"
  type        = list(map(string))
}

variable "instance_volume_size" {
  description = "Requested Instance Volume Size"
  type        = number
  default     = 8
}

variable "key_pair_name" {
  description = "Name to give the generated keypair that will be associated with the minecraft server ec2 instance for ssh access"
  type        = string
  default     = "server-keypair"
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

variable "minecraft_server_memory" {
  description = "How much Heap Memory to dedicate to the jvm (in MB)"
  type        = string
  default     = "512"
}

variable "minecraft_version_selector" {
  description = "Version of Minecraft Server files to download"
  type        = map(any)
  default = {
    "1.17.1" = "https://launcher.mojang.com/v1/objects/a16d67e5807f57fc4e550299cf20226194497dc2/server.jar",
    "1.18.2" = "https://launcher.mojang.com/v1/objects/c8f83c5655308435b3dcf03c06d9fe8740a77469/server.jar"
  }
}

variable "prefix_identifier" {
  description = "Prefix added to all resources in aws to differentiate between types of infra setup"
  type        = string
  default     = "mc"
}

variable "spot_allocation_strategy" {
  description = "Strategy for spot allocation, either 'lowest-price' or 'capacity-optimized'. Defaults to 'capacity-optimized' for corporate longevity of spot"
  type        = string
  default     = "capacity-optimized"
}

variable "subnet_ids" {
  description = "subnet ids for the asg to deploy into "
  type        = list(string)
}
