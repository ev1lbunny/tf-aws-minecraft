data "aws_iam_policy_document" "minecraft_s3_access" {
  statement {
    actions = ["s3:*"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "minescraft_server_s3_access_role" {
  name               = "minescraft_server_s3_access_role"
  path               = "/system/"
  assume_role_policy = data.aws_iam_policy_document.minecraft_s3_access.json
}