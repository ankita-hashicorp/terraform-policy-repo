policy {
}

resource_policy "aws_cloudtrail" "enable_log_file_validation" {
  enforce {
    condition     = core::try(attrs.enable_log_file_validation, false)
    info_message = "attr value of this resource must be true"
  }
}