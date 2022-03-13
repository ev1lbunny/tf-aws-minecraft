module "hennge_split_spot_on_demand_asg" {
  count = var.enable_spot_fleet ? 1:0
  source  = "HENNGE/autoscaling-mixed-instances/aws"
  version = "3.2.0"

  name = "${var.prefix_identifier}-spot-asg"

  lt_name         = "${var.prefix_identifier}-server-launch-template"
  image_id        = data.aws_ami.al2.id
  security_groups = [aws_security_group.server_security_group.id]
  block_device_mappings = [
    {
      device_name = "/dev/sda1"
      ebs = [
        {
          volume_type = "gp2"
          volume_size = var.instance_volume_size
        },
      ]
      tags = merge(
        {},
        var.additional_tags,
      )
    },
  ]
  instance_types              = var.instance_types_array
  user_data                   = data.template_file.user_data.rendered
  key_name                    = "${var.prefix_identifier}-${var.key_pair_name}"
  enable_monitoring           = false
  associate_public_ip_address = true

  asg_name                                 = "${var.prefix_identifier}-asg"
  vpc_zone_identifier                      = var.subnet_ids
  health_check_type                        = "EC2"
  min_size                                 = var.asg_min_size
  max_size                                 = var.asg_max_size
  desired_capacity                         = var.asg_desired_capacity
  wait_for_capacity_timeout                = 0
  ignore_desired_capacity_changes          = true
  on_demand_base_capacity                  = var.asg_on_demand_base_capacity
  on_demand_percentage_above_base_capacity = var.asg_on_demand_percentage_above_base_capacity
  spot_allocation_strategy                 = var.spot_allocation_strategy

  tags = [
    merge({
      key                 = "Backup"
      value               = "true"
      propagate_at_launch = true
    }, var.additional_backup_tags),
  ]
  tags_as_map = var.additional_tags
}
