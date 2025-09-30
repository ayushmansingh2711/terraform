terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.14.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# Random ID for unique bucket name
resource "random_id" "random-id" {
  byte_length = 4
}

# Create unique S3 bucket
resource "aws_s3_bucket" "demo-bucket" {
  bucket = "demo-bucket-${random_id.random-id.hex}"

  tags = {
    Name = "Demo Static Website"
  }
}

# Allow public access (must also disable Block Public Access in console)
resource "aws_s3_bucket_public_access_block" "demo" {
  bucket = aws_s3_bucket.demo-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Public read-only policy
resource "aws_s3_bucket_policy" "bucket-policy" {
  bucket = aws_s3_bucket.demo-bucket.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = "*",
        Action   = "s3:GetObject",
        Resource = "${aws_s3_bucket.demo-bucket.arn}/*"
      }
    ]
  })
}


resource "aws_s3_bucket_website_configuration" "demo-website" {
  bucket = aws_s3_bucket.demo-bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

#   routing_rule {
#     condition {
#       key_prefix_equals = "docs/"
#     }
#     redirect {
#       replace_key_prefix_with = "documents/"
#     }
#   }
}

# Upload index.html
resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.demo-bucket.bucket
  source = "./index.html"
  key    = "index.html"
  content_type = "text/html"
}

# Upload style.css
resource "aws_s3_object" "style" {
  bucket = aws_s3_bucket.demo-bucket.bucket
  source = "./css/style.css"
  key    = "./css/style.css"
  content_type = "text/css"
}

resource "aws_s3_object" "bootstrap" {
  bucket = aws_s3_bucket.demo-bucket.bucket
  source = "./css/bootstrap.min.css"
  key    = "./css/bootstrap.min.css"
  content_type = "text/css"
}

resource "aws_s3_object" "java-script" {
  bucket = aws_s3_bucket.demo-bucket.bucket
  source = "./js/main.js"
  key    = "./js/main.js"
    content_type = "application/javascript"
 
}


locals {
  img_files = fileset("./img", "*")
}

resource "aws_s3_object" "img" {
  for_each = { for file in local.img_files : file => file }

  bucket       = aws_s3_bucket.demo-bucket.bucket
  source       = "./img/${each.value}"
  key          = "img/${each.value}"   # <-- "./" हटा दिया
  content_type = "image/png"           # default रखा है
}



# Enable static website hosting
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.demo-bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

# Outputs
output "bucket_name" {
  value = aws_s3_bucket.demo-bucket.bucket
}

output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.website.website_endpoint
}
