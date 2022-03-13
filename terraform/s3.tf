resource "random_id" "state_bucket_rand" {
  byte_length = 2
}

#tfsec:ignore:aws-s3-enable-bucket-encryption
#tfsec:ignore:aws-s3-encryption-customer-key
#tfsec:ignore:aws-s3-enable-bucket-logging
resource "aws_s3_bucket" "minecraft_data" {
  bucket = "${var.minecraft_bucket_name}-${random_id.state_bucket_rand.dec}"

  tags = {
    Name = "Terraform minecraft server Bucket"
  }
}

resource "aws_s3_object" "world_data" {
  bucket = aws_s3_bucket.minecraft_data.id
  key    = var.minecraft_bucket_world_directory_object
}

resource "aws_s3_object" "settings" {
  bucket = aws_s3_bucket.minecraft_data.id
  key    = var.minecraft_bucket_whitelist_directory_object
}

resource "aws_s3_bucket_acl" "minecraft_data" {
  bucket = aws_s3_bucket.minecraft_data.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "minecraft_data" {
  bucket = aws_s3_bucket.minecraft_data.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "minecraft_data" {
  bucket = aws_s3_bucket.minecraft_data.id
  versioning_configuration {
    status = "Enabled"
  }
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
