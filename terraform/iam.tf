resource "aws_iam_role" "minecraft_sts_ec2_assume_role" {
  name                 = "minecraft_sts_ec2_assume_role"
  permissions_boundary = "arn:aws:iam::aws:policy/AmazonS3FullAccess"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = merge(
    {},
    var.additional_tags,
  )
}

resource "aws_iam_policy" "minecraft_s3_access_policy" {
  name        = "minecraft_s3_access_policy"
  description = "allow access to specific minecraft backup bucket"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:*"],
      "Resource": ["${aws_s3_bucket.minecraft_data.arn}"]
    },
    {

        "Effect": "Allow",
        "Action": ["s3:*Object*"],
        "Resource": ["${aws_s3_bucket.minecraft_data.arn}/*"]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "minecraft_s3_policy_attachment" {
  role       = aws_iam_role.minecraft_sts_ec2_assume_role.name
  policy_arn = aws_iam_policy.minecraft_s3_access_policy.arn
}

resource "aws_iam_instance_profile" "minecraft_s3_access_profile" {
  name = "minecraft_s3_access_profile"
  role = aws_iam_role.minecraft_sts_ec2_assume_role.name
}
