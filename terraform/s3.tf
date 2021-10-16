resource "random_id" "state_bucket_rand" {
  byte_length = 2
}

resource "aws_s3_bucket" "minecraft_data" {
  bucket = "${var.minecraft_bucket_name}-${random_id.state_bucket_rand.dec}"
  acl    = "private"

  versioning {
    enabled = true
  }
  logging {
    target_bucket = aws_s3_bucket.minecraft_data_log_bucket.id
    target_prefix = "log/"
  }

  tags = {
    Name = "Terraform minecraft server Bucket"
  }
}

resource "aws_s3_bucket" "minecraft_data_log_bucket" {
  bucket = "minecraft-server-world-data-log-bucket"
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket_object" "world_data" {
  bucket = aws_s3_bucket.minecraft_data.id
  key    = var.minecraft_bucket_world_directory_object
}

resource "aws_s3_bucket_object" "settings" {
  bucket = aws_s3_bucket.minecraft_data.id
  key    = var.minecraft_bucket_whitelist_directory_object
}

resource "aws_s3_bucket_policy" "minecraft_data_bucket_policy" {
  bucket = aws_s3_bucket.minecraft_data.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": ["s3:*"],
            "Effect": "Allow",
            "Resource": [
                "${aws_s3_bucket.minecraft_data.arn}",
                "${aws_s3_bucket.minecraft_data.arn}/*"
            ],
            "Principal": {
                "AWS": [
                    "${aws_iam_role.minecraft_sts_ec2_assume_role.arn}"
                ]
            }
        }
    ]
}
EOF
}
