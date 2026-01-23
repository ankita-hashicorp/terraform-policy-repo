policy {
}

resource_policy "aws_cloudtrail" "enable_log_file_validation" {
  enforce {
    condition     = attrs.enable_log_file_validation == true
    error_message = "attr value of this resource must be true"

  }
}