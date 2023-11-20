/*the aws_iam_user and aws_iam_policy resources to create an IAM user and policy, and then use the aws_iam_user_policy_attachment resource to attach the policy to the user*/


provider "aws" {
  # Configure your AWS provider settings here
  region = "us-east-1" # Change this to your desired region
}

resource "aws_iam_user" "s3_read_only_user" {
  name = "s3-read-only-user"
}

resource "aws_iam_policy" "s3_read_only_policy" {
  name        = "s3-read-only-policy"
  description = "Policy for read-only access to rafs_test_bucket"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::rafs_test_bucket",
                "arn:aws:s3:::rafs_test_bucket/*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_user_policy_attachment" "s3_read_only_attachment" {
  user       = aws_iam_user.s3_read_only_user.name
  policy_arn = aws_iam_policy.s3_read_only_policy.arn
}
