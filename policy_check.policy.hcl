policy {
}

locals {
  allowed_providers = ["azure", "google"]
  allowed_regions   = ["us-east-1", "us-west-2", "eu-west-1"]
}

input "param1" {
  description = "The type of the instance"
  type        = string
  default     = "value1"
}

# resource_policy "aws_instance" "aws_instance_key_name_check" {
#   enforcement_level = "mandatory_overridable"
#   enforce {
#     condition     = core::try(attrs.key_name == "example-key-3", false)
#     info_message = "Current value: ${attrs.key_name}"
#     error_message = "key_name must be example-key-3"
#   }
# }

resource_policy "aws_instance" "instance_type_check" {
  enforce {
    condition     = core::try(attrs.instance_type == "t2.micro", false)
    error_message = "instance_type must be t2.micro. Current value: ${attrs.instance_type}"
    info_message = "Instance_type must be t2.micro. Current instance_type value: ${attrs.instance_type}"
  }
}

resource_policy "aws_s3_bucket" "bucket_name_check" {
  enforcement_level = "mandatory_overridable"
  enforce {
    condition     = core::try(attrs.bucket != "", false)
    error_message = "bucket must be present. Current value: ${attrs.bucket}"
    info_message = "Bucket must be present. Current bucket value: ${attrs.bucket}"
  }
}

//policy for random resource
resource_policy "random_id" "byte_length_check" {
  enforcement_level = "mandatory_overridable"
  enforce {
    condition     = attrs.byte_length == 8
    info_message = "byte_length must be 8. Current value: ${attrs.byte_length}"
  }
}

//provider policy
provider_policy "aws" "provider_type_validation" {
  enforcement_level = "mandatory_overridable"
  enforce {
    condition    = core::contains(local.allowed_providers, meta.type) && core::try(input.param1 == "value1", false)
    info_message = "provider version is `${meta.version}` and input param1 value is `${input.param1}`"
  }
}

//unknown policy
resource_policy "aws_instance" "instance_state_check" {
  enforcement_level = "mandatory_overridable"
  enforce {
    condition     = attrs.instance_state == "test"
    error_message = "Amazon SQS queues must be encrypted at rest using AWS KMS keys or SQS managed keys"
  }
}

resource_policy "aws_instance" "monitoring_and_availability_zone_check" {
  enforcement_level = "advisory"
  enforce {
    condition     = core::try(attrs.monitoring == false, false)
    info_message = "Monitoring enabled: ${attrs.monitoring}"
  }

  enforce {
    condition     = core::try(attrs.availability_zone == "us-north-1", false)
    info_message = "Availability zone must be us-north-1. Current value: ${attrs.availability_zone}"
  }

}