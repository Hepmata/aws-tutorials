resource "aws_iam_role" "main_role" {
  name = "ec2_main_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow"
        Sid       = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_instance_profile" "main_instance_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.main_role.id
}

resource "aws_iam_role" "ec2_role" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = aws_iam_role.main_role.arn
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "ec2_role_policy" {
  name = "ec2_role_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*"
        ]
        Effect = "Allow"
        Resource = "*"
      }
    ]
  })
  role = aws_iam_role.main_role.id
}

output "ec2_role_arn" {
  value = aws_iam_role.ec2_role.arn
}

resource "aws_iam_role" "s3_role" {
  name = "s3_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = aws_iam_role.main_role.arn
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_role_policy" "s3_role_policy" {
  name = "s3_role_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*"
        ]
        Effect = "Allow"
        Resource = "*"
      }
    ]
  })
  role = aws_iam_role.s3_role.id
}

output "s3_role_arn" {
  value = aws_iam_role.s3_role.arn
}


