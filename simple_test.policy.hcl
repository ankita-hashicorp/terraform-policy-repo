policy {
}

resource_policy "aws_s3_bucket" "check_bucket_naming" {
  enforce {
    condition     = core::try(attrs.bucket == "test_bucket_name", false)
    info_message = "attr value of this resource must be true"
  }
}