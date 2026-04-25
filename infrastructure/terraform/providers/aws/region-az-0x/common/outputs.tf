output "state_bucket_name" {
  description = "S3 bucket name for Terraform state."
  value       = aws_s3_bucket.tfstate.bucket
}

output "state_bucket_arn" {
  description = "S3 bucket ARN for Terraform state."
  value       = aws_s3_bucket.tfstate.arn
}

output "state_kms_key_arn" {
  description = "KMS key ARN used for Terraform state encryption."
  value       = aws_kms_key.tfstate.arn
}

output "lock_table_name" {
  description = "DynamoDB table name for legacy Terraform state locking."
  value       = aws_dynamodb_table.tf_locks.name
}

