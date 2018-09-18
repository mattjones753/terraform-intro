provider "aws" {
  region = "eu-west-2"
}

resource "aws_s3_bucket" "terraform_intro_demo_bucket" {
  bucket = "terraform-intro-demo-bucket"
  acl    = "public-read"

  website {
    index_document = "index.html"
  }

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
    "Sid": "PublicReadForGetBucketObjects",
    "Effect": "Allow",
    "Principal": "*",
    "Action": "s3:GetObject",
    "Resource": ["arn:aws:s3:::terraform-intro-demo-bucket/*"]
  }]
}
EOF
}

resource "aws_s3_bucket_object" "river_island_tech_demo_index_html" {
  key          = "index.html"
  bucket       = "${aws_s3_bucket.terraform_intro_demo_bucket.bucket}"
  source       = "index.html"
  content_type = "text/html"
  etag         = "${md5(file("index.html"))}"
}
