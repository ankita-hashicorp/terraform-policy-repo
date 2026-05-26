policy {
}

locals {
  allowed_providers = ["azure","aws", "google"]
  allowed_regions   = ["us-east-1", "us-west-2", "eu-west-1", "ap-south-1"]
}

input "param1" {
  description = "The type of the instance"
  type        = string
  default     = "value1"
}

resource_policy "aws_s3_bucket" "bucket_name_check" {
  enforcement_level = "advisory"
  enforce {
    condition     = core::try(attrs.bucket == "test", false)
    error_message = "bucket must be present. Current value: ${attrs.bucket}"
    info_message = "Bucket must be present. Current bucket value: ${attrs.bucket}"
  }
}

resource_policy "aws_s3_bucket" "tag_name_check" {
  enforcement_level = "mandatory_overridable"
  enforce {
    condition     = core::try(attrs.tags.Name != "", false)
    error_message = "bucket must have a name tag. Current value: ${attrs.tags.Name}"
    info_message = "Bucket must have a name tag. Current name value: ${attrs.tags.Name}"
  }
}

//provider policy
provider_policy "aws" "provider_type_validation" {
  enforce {
    condition    = core::contains(local.allowed_providers, meta.type) && core::try(input.param1 == "value1", false)
    info_message = "provider version is `${meta.version}` and input param1 value is `${input.param1}`"
  }
}

//unknown policy
resource_policy "aws_s3_bucket" "bucket_namespace_check" {
  enforcement_level = "mandatory_overridable"
  enforce {
    condition     = attrs.bucket_namespace == "global"
    info_message = "Bucket namespace is `${attrs.bucket_namespace}`. expected value is `global`"
  }
}

