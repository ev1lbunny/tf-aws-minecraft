# Terraform Docs
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.5.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_hennge_split_spot_on_demand_asg"></a> [hennge\_split\_spot\_on\_demand\_asg](#module\_hennge\_split\_spot\_on\_demand\_asg) | HENNGE/autoscaling-mixed-instances/aws | 3.2.0 |

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
| [aws_s3_bucket_acl.minecraft_data](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_object.settings](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object) | resource |
| [aws_s3_bucket_object.world_data](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object) | resource |
| [aws_s3_bucket_policy.minecraft_data_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.minecraft_data](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_versioning.minecraft_data](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_security_group.server_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [random_id.state_bucket_rand](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [tls_private_key.key_pair_config](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [aws_ami.al2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_launch_template.launch_template](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/launch_template) | data source |
| [template_file.user_data](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tags"></a> [additional\_tags](#input\_additional\_tags) | Additional resource tags | `map(string)` | <pre>{<br>  "Name": "Minecraft"<br>}</pre> | no |
| <a name="input_asg_desired_capacity"></a> [asg\_desired\_capacity](#input\_asg\_desired\_capacity) | Autoscaling group desired capacity | `number` | `1` | no |
| <a name="input_asg_max_size"></a> [asg\_max\_size](#input\_asg\_max\_size) | Autoscaling group maximum size | `number` | `1` | no |
| <a name="input_asg_min_size"></a> [asg\_min\_size](#input\_asg\_min\_size) | Autoscaling group minimum size | `number` | `0` | no |
| <a name="input_asg_on_demand_base_capacity"></a> [asg\_on\_demand\_base\_capacity](#input\_asg\_on\_demand\_base\_capacity) | Absolute minimum amount of desired capacity that must be fulfilled by on-demand instances | `number` | `0` | no |
| <a name="input_asg_on_demand_percentage_above_base_capacity"></a> [asg\_on\_demand\_percentage\_above\_base\_capacity](#input\_asg\_on\_demand\_percentage\_above\_base\_capacity) | Percentage split between on-demand and Spot instances above the base on-demand capacity. Default will always assume you want 0% on demand above the base capacity | `number` | `0` | no |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | Associate a public ip address with the instances. | `bool` | `false` | no |
| <a name="input_aws_credentials_profile"></a> [aws\_credentials\_profile](#input\_aws\_credentials\_profile) | High level profile name that the terraform uses for aws access to create new role/policy/user for pihole deployment | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Region of aws to use | `string` | `"eu-west-2"` | no |
| <a name="input_enable_on_demand"></a> [enable\_on\_demand](#input\_enable\_on\_demand) | Determins if or not you want MC on on demand ec2 instance. | `bool` | `false` | no |
| <a name="input_enable_spot_fleet"></a> [enable\_spot\_fleet](#input\_enable\_spot\_fleet) | Determins if or not you want MC to run on spot fleet | `bool` | `true` | no |
| <a name="input_ingress_access_cidr"></a> [ingress\_access\_cidr](#input\_ingress\_access\_cidr) | Cidr block that you will ssh access the minecraft server from. All other inbound ssh access will be blocked. | `string` | n/a | yes |
| <a name="input_instance_hostname"></a> [instance\_hostname](#input\_instance\_hostname) | Requested Instance Hostname | `string` | `"aws-minecraft-server"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Requested Instance Type | `string` | `"t3.small"` | no |
| <a name="input_instance_types_array"></a> [instance\_types\_array](#input\_instance\_types\_array) | Requested Instance Types allows in spot fleet | `list(map(string))` | n/a | yes |
| <a name="input_instance_volume_size"></a> [instance\_volume\_size](#input\_instance\_volume\_size) | Requested Instance Volume Size | `number` | `8` | no |
| <a name="input_key_pair_name"></a> [key\_pair\_name](#input\_key\_pair\_name) | Name to give the generated keypair that will be associated with the minecraft server ec2 instance for ssh access | `string` | `"server-keypair"` | no |
| <a name="input_minecraft_bucket_name"></a> [minecraft\_bucket\_name](#input\_minecraft\_bucket\_name) | Name for the bucket where world data backups are stored | `string` | `"minecraft-server-world-data"` | no |
| <a name="input_minecraft_bucket_whitelist_directory_object"></a> [minecraft\_bucket\_whitelist\_directory\_object](#input\_minecraft\_bucket\_whitelist\_directory\_object) | Folder object in the bucket where world data backups are stored | `string` | `"minecraft/minecraft_server_settings_backups/"` | no |
| <a name="input_minecraft_bucket_world_directory_object"></a> [minecraft\_bucket\_world\_directory\_object](#input\_minecraft\_bucket\_world\_directory\_object) | Folder object in the bucket where world data backups are stored | `string` | `"minecraft/minecraft_server_word_data_backups/"` | no |
| <a name="input_minecraft_server_hardcore_mode"></a> [minecraft\_server\_hardcore\_mode](#input\_minecraft\_server\_hardcore\_mode) | Run server in permadeath mode | `string` | `"false"` | no |
| <a name="input_minecraft_server_max_players"></a> [minecraft\_server\_max\_players](#input\_minecraft\_server\_max\_players) | Max number of players allowed on server | `number` | `10` | no |
| <a name="input_minecraft_server_memory"></a> [minecraft\_server\_memory](#input\_minecraft\_server\_memory) | How much Heap Memory to dedicate to the jvm (in MB) | `string` | `"512"` | no |
| <a name="input_minecraft_server_motd"></a> [minecraft\_server\_motd](#input\_minecraft\_server\_motd) | Server Message of the Day | `string` | `"Welcome to Minecraft"` | no |
| <a name="input_minecraft_server_rcon"></a> [minecraft\_server\_rcon](#input\_minecraft\_server\_rcon) | Turn on and off the server rcon capability with true/false | `string` | `"false"` | no |
| <a name="input_minecraft_server_rcon_pass"></a> [minecraft\_server\_rcon\_pass](#input\_minecraft\_server\_rcon\_pass) | Server Rcon Password | `string` | `"please_change_me_if_using_rcon"` | no |
| <a name="input_minecraft_server_whitelist"></a> [minecraft\_server\_whitelist](#input\_minecraft\_server\_whitelist) | Turn on and off the server whitelist capability with true/false | `string` | `"false"` | no |
| <a name="input_minecraft_version_selector"></a> [minecraft\_version\_selector](#input\_minecraft\_version\_selector) | Version of Minecraft Server files to download | `map(any)` | <pre>{<br>  "1.17.1": "https://launcher.mojang.com/v1/objects/a16d67e5807f57fc4e550299cf20226194497dc2/server.jar",<br>  "1.18.2": "https://launcher.mojang.com/v1/objects/c8f83c5655308435b3dcf03c06d9fe8740a77469/server.jar"<br>}</pre> | no |
| <a name="input_prefix_identifier"></a> [prefix\_identifier](#input\_prefix\_identifier) | Prefix added to all resources in aws to differentiate between types of infra setup | `string` | `"mc"` | no |
| <a name="input_spot_allocation_strategy"></a> [spot\_allocation\_strategy](#input\_spot\_allocation\_strategy) | Strategy for spot allocation, either 'lowest-price' or 'capacity-optimized'. Defaults to 'capacity-optimized' for corporate longevity of spot | `string` | `"capacity-optimized"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | subnet ids for the asg to deploy into | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_generated_key"></a> [private\_generated\_key](#output\_private\_generated\_key) | The generated private key used to access the joint ec2 instances via ssh |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
