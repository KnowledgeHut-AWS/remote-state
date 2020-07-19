resource "aws_s3_bucket" "terraform_state" {
  bucket = "devops-bootcamp-remote-state"
  # Versioning for full history
  versioning {
    enabled = true
  }

  # Encrypted for privacy
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  # Don't be deleting this by mistake
  lifecycle {
    prevent_destroy = true
  }
}
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "devops-bootcamp-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }

  # Don't be deleting this by mistake either
  lifecycle {
    prevent_destroy = true
  }
}
