resource "aws_iam_instance_profile" "minecraft_s3_access_profile" {
  name = "minecraft_s3_access_profile"
  role = aws_iam_role.minecraft_sts_ec2_assume_role.name
}

resource "aws_iam_role" "minecraft_sts_ec2_assume_role" {
  name                 = "minecraft_sts_ec2_assume_role"
  permissions_boundary = "arn:aws:iam::aws:policy/AmazonS3FullAccess"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = merge(
    {},
    var.additional_tags,
  )
}

resource "aws_iam_role_policy" "minecraft_s3_access_policy" {
  name = "minecraft_s3_access_policy"
  role = aws_iam_role.minecraft_sts_ec2_assume_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:ListBucket"],
      "Resource": ["${aws_s3_bucket.minecraft_data.arn}"]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject"
      ],
      "Resource": ["${aws_s3_bucket.minecraft_data.arn}/*"]
    }
  ]
}
EOF
}
