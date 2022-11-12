provider "aws" {
    region = "ap-northeast-2"
}


module "static_site" {
   source = "../common/static_site"
   bucket_name = var.bucket_name
   env = var.env
}