policy {
    enforcement_level = advisory
}

resource_policy "aws_instance" "enable_log_file_validation" {
  enforce {
    condition     = core::try(attrs.enable_log_file_validation, false)
    error_message = "attr value of this resource must be true"
  }
}

provider_policy "aws" "simple_test" {
  enforce {
    condition     = core::try(attrs.region, "") == "us-east-1"
    error_message = "Region must be us-east-1 for AWS provider"
  }
}

module_policy "./modules/s3" "simple_test" {
  enforce {
    condition     = core::try(attrs.bucket_name, "") != ""
    error_message = "Bucket name must be provided for S3 module"
  }
}
