# s3 관련 정리를 위한 파일

# s3 acl이 정리 필요

# s3 cors 설정
# resource "aws_s3_bucket_cors_configuration" "s3_cors" {
#     bucket = aws_s3_bucket.s3.id

#     cors_rule {
#         allowed_headers = ["*"]
#         allowed_methods = ["PUT", "POST"]
#         allowed_origins = ["https://s3-website-test.hashicorp.com"]
#         expose_headers  = ["ETag"]
#         max_age_seconds = 3000
#     }

#     cors_rule {
#         allowed_methods = ["GET"]
#         allowed_origins = ["*"]
#     }
# }

# s3 정적 웹호스팅
# resource "aws_s3_bucket_website_configuration" "s3_web_hosting" {
#   bucket = aws_s3_bucket.s3.id

#   index_document {
#     suffix = "index.html"
#   }

#   error_document {
#     key = "index.html"
#   }

#   routing_rule {
#     condition {
#         key_prefix_equals = "docs"
#     }
#     redirect {
#        replace_key_prefix_with = "documents/"
#     }
#   }
# }