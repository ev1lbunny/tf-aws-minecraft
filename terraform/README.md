# Terraform Docs
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.62.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 3.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.elastic_ip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_iam_instance_profile.minecraft_s3_access_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.minecraft_s3_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.minecraft_sts_ec2_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.minecraft_s3_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_instance.ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_key_pair.generated_server_keypair](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_s3_bucket.minecraft_data](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.minecraft_data_log_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_object.settings](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object) | resource |
| [aws_s3_bucket_object.world_data](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object) | resource |
| [aws_s3_bucket_policy.minecraft_data_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_security_group.security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [random_id.state_bucket_rand](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [tls_private_key.key_pair_config](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [aws_ami.Al2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [template_file.user_data](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tags"></a> [additional\_tags](#input\_additional\_tags) | Additional resource tags | `map(string)` | <pre>{<br>  "Name": "Minecraft"<br>}</pre> | no |
| <a name="input_aws_credentials_profile"></a> [aws\_credentials\_profile](#input\_aws\_credentials\_profile) | High level profile name that the terraform uses for aws access to create new role/policy/user for pihole deployment | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Region of aws to use | `string` | `"eu-west-2"` | no |
| <a name="input_ingress_access_ip_address"></a> [ingress\_access\_ip\_address](#input\_ingress\_access\_ip\_address) | Ip address that you will access the minecraft from. All other access will be locked. | `string` | n/a | yes |
| <a name="input_instance_hostname"></a> [instance\_hostname](#input\_instance\_hostname) | Requested Instance Hostname | `string` | `"aws-minecraft-server"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Requested Instance Type | `string` | `"t3.micro"` | no |
| <a name="input_instance_volume_size"></a> [instance\_volume\_size](#input\_instance\_volume\_size) | Requested Instance Volume Size | `number` | `8` | no |
| <a name="input_key_pair_name"></a> [key\_pair\_name](#input\_key\_pair\_name) | Name to give the generated keypair that will be associated with the minecraft server ec2 instance for ssh access | `string` | `"server-keypair"` | no |
| <a name="input_minecraft_bucket_name"></a> [minecraft\_bucket\_name](#input\_minecraft\_bucket\_name) | Name for the bucket where world data backups are stored | `string` | `"minecraft-server-world-data"` | no |
| <a name="input_minecraft_bucket_whitelist_directory_object"></a> [minecraft\_bucket\_whitelist\_directory\_object](#input\_minecraft\_bucket\_whitelist\_directory\_object) | Folder object in the bucket where world data backups are stored | `string` | `"minecraft/minecraft_server_settings_backups"` | no |
| <a name="input_minecraft_bucket_world_directory_object"></a> [minecraft\_bucket\_world\_directory\_object](#input\_minecraft\_bucket\_world\_directory\_object) | Folder object in the bucket where world data backups are stored | `string` | `"minecraft/minecraft_server_word_data_backups"` | no |
| <a name="input_minecraft_server_hardcore_mode"></a> [minecraft\_server\_hardcore\_mode](#input\_minecraft\_server\_hardcore\_mode) | Run server in permadeath mode | `string` | `"false"` | no |
| <a name="input_minecraft_server_max_players"></a> [minecraft\_server\_max\_players](#input\_minecraft\_server\_max\_players) | Max number of players allowed on server | `number` | `10` | no |
| <a name="input_minecraft_server_motd"></a> [minecraft\_server\_motd](#input\_minecraft\_server\_motd) | Server Message of the Day | `string` | `"Welcome to the ############ Minecraft Server"` | no |
| <a name="input_minecraft_server_rcon"></a> [minecraft\_server\_rcon](#input\_minecraft\_server\_rcon) | Turn on and off the server rcon capability with true/false | `string` | `"false"` | no |
| <a name="input_minecraft_server_rcon_pass"></a> [minecraft\_server\_rcon\_pass](#input\_minecraft\_server\_rcon\_pass) | Server Rcon Password | `string` | `"please_change_me_if_using_rcon"` | no |
| <a name="input_minecraft_server_whitelist"></a> [minecraft\_server\_whitelist](#input\_minecraft\_server\_whitelist) | Turn on and off the server whitelist capability with true/false | `string` | `"false"` | no |
| <a name="input_minecraft_version_selector"></a> [minecraft\_version\_selector](#input\_minecraft\_version\_selector) | Version of Minecraft Server files to download | `map(any)` | <pre>{<br>  "1.17.1": "https://launcher.mojang.com/v1/objects/a16d67e5807f57fc4e550299cf20226194497dc2/server.jar"<br>}</pre> | no |
| <a name="input_prefix_identifier"></a> [prefix\_identifier](#input\_prefix\_identifier) | Prefix added to all resources in aws to differentiate between types of infra setup | `string` | `"mc-"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_generated_key"></a> [private\_generated\_key](#output\_private\_generated\_key) | The generated private key used to access the joint ec2 instances via ssh |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
