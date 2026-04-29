policy {
}

resource_policy "aws_instance" "aws_instance_key_name_check" {
  enforcement_level = "mandatory_overridable"
  enforce {
    condition     = core::try(attrs.key_name == "example-key-3", false)
    info_message = "Current value: ${attrs.key_name}"
    error_message = "key_name must be example-key-3"
  }
}

resource_policy "aws_instance" "instance_type_check" {
  enforcement_level = "mandatory_overridable"
  enforce {
    condition     = core::try(attrs.instance_type == "t2.micro", false)
    error_message = "instance_type must be t2.micro. Current value: ${attrs.instance_type}"
    info_message = "Instance_type must be t2.micro. Current instance_type value: ${attrs.instance_type}"
  }
}
 

provider_policy "aws" "provider_type_validation" {
  enforce {
    condition    = core::contains(local.allowed_providers, meta.type)
    info_message = "Provider type '${meta.type}' is allowed"
  }
}

resource_policy "aws_sqs_queue" "encryption_at_rest" {
  locals {
    sqs_managed_sse_enabled = core::try(attrs.sqs_managed_sse_enabled, false)
    kms_key                 = attrs.kms_master_key_id
  }

  enforce {
    condition     = attrs.name_prefix == "test"
    error_message = "Amazon SQS queues must be encrypted at rest using AWS KMS keys or SQS managed keys"
  }
}

resource_policy "random_id" "keepers_byte_length_check" {
  enforcement_level = "advisory"
  enforce {
    condition     = core::try(attrs.keepers["instance_type"] == "t3.micro", false)
    info_message = "Instance_type: ${attrs.keepers["instance_type"]}"
  }

  enforce {
    condition     = core::try(attrs.byte_length == 16, false)
    info_message = "random_id resource 'byte_length' must be 16. Current value: ${attrs.byte_length}"
  }

}