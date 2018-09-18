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

resource "aws_security_group" "jump_security_group" {
  name        = "jump_security_group"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "local_file" "public_ssh_key" {
  filename = "${path.module}/tf_rsa.pub"
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh-key"
  public_key = "${data.local_file.public_ssh_key.content}"
}

resource "aws_instance" "jump_box" {
  ami           = "ami-0b0a60c0a2bd40612"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.ssh_key.key_name}"

  security_groups = ["${aws_security_group.jump_security_group.name}"]
}

output "website_url" {
  value = "${aws_s3_bucket.terraform_intro_demo_bucket.website_endpoint}"
}

output "instance_ip" {
  value = "${aws_instance.jump_box.public_ip}"
}
