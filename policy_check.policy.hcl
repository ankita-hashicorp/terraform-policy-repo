policy {}

input "param1" {
  type = string
  default = "val1"
}

resource_policy "random_id" "byte_length_check" {
  operations = [ "create" ]
  enforcement_level = "advisory"
  enforce {
    condition     = attrs.byte_length > 2 && input.param1 == "val1"
    info_message = "byte_length must be 8. Current value: ${attrs.byte_length} and input ${input.param1}"
  }
}

resource_policy "random_pet" "pet_length_check" {
  enforcement_level = "advisory"
  enforce {
    condition     = attrs.length == 3
    info_message = "length must be 3 and prefix must be 'dev'. Current values: length=${attrs.length}."
    error_message = "length must be 3 and prefix must be 'dev'. Current values: length=${attrs.length}."
  }
}

resource_policy "random_pet" "pet_prefix_check" {
  operations = [ "create", "update"]
  enforcement_level = "advisory"
  enforce {
    condition     = attrs.prefix == "dev"
    info_message = "current prefix=${attrs.prefix}."
    error_message = "current prefix=${attrs.prefix}."
  }
}

//unknown policy
resource_policy "random_id" "random_id_check" {
  enforcement_level = "advisory"
  enforce {
    condition     = attrs.id != ""
    info_message = "id must be present"
    error_message = "id must be present"
  }
}

resource_policy "random_password" "length_special_check" {
  enforcement_level = "advisory"
  enforce {
    condition     = attrs.length != 10 && attrs.special == true
    info_message = "length must be 10 and special must be true. Current values: length=${attrs.length}, special=${attrs.special}"
    error_message = "length must be 10 and special must be true. Current values: length=${attrs.length}, special=${attrs.special}"
  }
}

resource_policy "random_shuffle" "result_count_check" {
  enforcement_level = "advisory"
  enforce {
    condition     = core::try(attrs.result_count == 2, false) && core::try(core::length(attrs.input) != 0, false)
    info_message = "result_count must be 1 and input must not be empty. Current value: ${attrs.result_count}"
    error_message = "result_count must be 1 and input must not be empty. Current value: ${attrs.result_count}"
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

resource_policy "aws_instance" "aws_instance_key_name_check" {
  enforcement_level = "advisory"
  enforce {
    condition     = core::try(attrs.key_name == "example-key-3", false)
    info_message = "Current value: ${attrs.key_name}"
    error_message = "key_name must be example-key-3"
  }
}

resource_policy "aws_instance" "instance_type_check" {
  enforcement_level = "mandatory_overridable"
  enforce {
    condition     = core::try(attrs.instance_type == "t1.micro", false)
    error_message = "instance_type must be t2.micro. Current value: ${attrs.instance_type}"
    info_message = "Instance_type must be t2.micro. Current instance_type value: ${attrs.instance_type}"
  }
}

resource_policy "aws_s3_bucket" "bucket_name_check" {
  enforcement_level = "advisory"
  enforce {
    condition     = core::try(attrs.bucket == "test", false)
    error_message = "bucket must be present. Current value: ${attrs.bucket}"
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

//unknown policy
# resource_policy "aws_s3_bucket" "bucket_namespace_check" {
#   enforcement_level = "advisory"
#   enforce {
#     condition     = attrs.bucket_namespace == "global"
#   }
# }