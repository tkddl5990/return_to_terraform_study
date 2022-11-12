resource "aws_s3_bucket" "s3" {
    bucket = var.bucket_name

    tags = {
        Name = "${var.env}-${var.bucket_name}-bucket"
    }
}

# # s3 버전 관리
# resource "aws_s3_bucket_versioning" "s3_version" {
#   bucket = aws_s3_bucket.s3.id
#   versioning_configuration {
#     status = "Disabled"
#   }
# }

# s3 퍼블릭 엑세스 차단 여부
resource "aws_s3_bucket_public_access_block" "s3_public_access" {
  bucket = aws_s3_bucket.s3.id

  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
}

# s3 버킷 정책
resource "aws_s3_bucket_policy" "s3_policy" {
    bucket = aws_s3_bucket.s3.id
    policy = data.aws_iam_policy_document.s3_access_policy.json
}

# s3 버킷 정책 내용 data
data "aws_iam_policy_document" "s3_access_policy" {
    statement {
      effect = "Allow"
      principals {
        type = "AWS"
        identifiers = ["*"]
      }
      actions = [
        "s3:GetObject",
      ]
      resources = [
        "${aws_s3_bucket.example.arn}/*"
      ]
    }
}