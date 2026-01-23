
resource_policy "aws_s3_bucket" "enable_log_file_validation" {
  enforce {
    condition     = core::try(attrs.enable_log_file_validation, false)
  }
}