policy {
}

# -----------------------------------------------------------------------------
# Policy: Encryption at Rest
# Ensures SQS queues are encrypted using either:
#   - SQS managed SSE (sqs_managed_sse_enabled = true)
#   - Customer managed KMS key (kms_master_key_id is set)
#
# Reference: AWS Security Hub control [SQS.1]
# -----------------------------------------------------------------------------
resource_policy "aws_sqs_queue" "encryption_at_rest" {
  locals {
    sqs_managed_sse_enabled = core::try(attrs.sqs_managed_sse_enabled, false)
    kms_key                 = attrs.kms_master_key_id
  }

  enforce {
    condition     = local.sqs_managed_sse_enabled || local.kms_key
    error_message = "Amazon SQS queues must be encrypted at rest using AWS KMS keys or SQS managed keys"
  }
}
