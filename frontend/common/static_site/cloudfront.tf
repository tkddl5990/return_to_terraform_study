
# cloudfront origin access id 생성
resource "aws_cloudfront_origin_access_identity" "orign_access_id" {
  comment = "이것은 배포여"
}

# cloudfront 설정
resource "aws_cloudfront_distribution" "distribution" {

  # 원본 설정 여러 경우일 경우 하나 더 쓰면 됨.
  origin {
    domain_name = aws_s3_bucket.s3.bucket_domain_name
    origin_id   = aws_s3_bucket.s3.id

    # 이게 뭐지??
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.orign_access_id.cloudfront_access_identity_path
    }
  }

  http_version        = "http2"
  price_class         = "PriceClass_100"
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "이것은 배포여"
  default_root_object = "index.html"
#   aliases             = ["${var.bucket_name}"]

  viewer_certificate {
    # cloudfront_default_certificate = true
    # acm_certificate_arn = data.aws_acm_certificate.acm.arn
    minimum_protocol_version = "TLSv1.2_2021"
  }

  # 로깅 관련
  # logging_config {
  #     include_cookies = false
  #     bucket = aws_s3_bucket.s3.bucket
  #     prefix = "logginng_test"
  # }

  # 동작 관련 마찬가지로 여러일 경우 걍 하나 더 쓰면 됨.
  default_cache_behavior {
    target_origin_id       = aws_s3_bucket.s3.id
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    trusted_signers        = ["self"]


    # 캐시 키 및 원본 요청 이 부부인 것 같은데 조금 더 찾아봐야 할 것 같음...
    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      # locations        = ["US", "CA", "GB", "DE"]
    }
  }
}

# 사용자 ssl 불러오기
# data "aws_acm_certificate" "acm" {
#   domain = "*.test.com"
#   types = ["ISSUED"]
# }