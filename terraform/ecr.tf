resource "random_string" "suffix_ecr" {
  length  = 8
  special = false
  upper   = false
}

resource "aws_ecr_repository" "ecr" {
  name = "demo"
}

resource "aws_ecr_repository_policy" "policy" {
  repository = aws_ecr_repository.ecr.name

  policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "allow-pull-push",
            "Effect": "Allow", 
            "Principal": "*", 
            "Action": [ 
               "ecr:GetDownloadUrlForLayer",
               "ecr:BatchGetImage",
               "ecr:BatchCheckLayerAvailability", 
               "ecr:PutImage", 
               "ecr:InitiateLayerUpload", 
               "ecr:UploadLayerPart",
               "ecr:CompleteLayerUpload" 
            ]
        }
    ]
}
EOF
}