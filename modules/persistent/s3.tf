resource "aws_s3_bucket" "private_docs" {
  bucket = "${var.account_id}-private-docs"

  tags = {
    Name = "${var.account_id}-private-docs"
  }
}

resource "aws_s3_bucket_public_access_block" "private_docs_block" {
  bucket = aws_s3_bucket.private_docs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "private_docs_versioning" {
  bucket = aws_s3_bucket.private_docs.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "private_docs_encryption" {
  bucket = aws_s3_bucket.private_docs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

