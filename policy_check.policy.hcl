policy {
}

locals {
  allowed_providers = ["azure", "aws", "google"]
  allowed_regions   = ["us-east-1", "us-west-2", "eu-west-1", "ap-south-1"]
}

input "approved_module_prefixes" {
  type    = list(string)
  default = ["./modules/", "registry.terraform.io/"]
}

input "param1" {
  type    = string
  default = "value1"
}

resource_policy "aws_s3_bucket" "bucket_name_check_delete_policy" {
  operations = ["delete"]
  enforcement_level = "advisory"
  enforce {
    condition     = core::try(core::length(core::regexall("test", prior_attrs.bucket)) > 0, false)
    error_message = "Bucket name must contain 'test'. Current value: ${prior_attrs.bucket} with operation ${meta.operation}"
    info_message = "Bucket name must contain 'test'. Current bucket value: ${prior_attrs.bucket} with operation ${meta.operation}"
  }
}

resource_policy "aws_s3_bucket" "tag_name_check_create_policy" {
  operations = ["create"]
  enforcement_level = "mandatory_overridable"
  enforce {
    condition     = core::try(attrs.tags.Name == "test", false)
    error_message = "bucket must have a name tag. Current value: ${attrs.tags.Name} with operation ${meta.operation}"
    info_message = "Bucket must have a name tag. Current name value: ${attrs.tags.Name} with operation ${meta.operation}"
  }
}

resource_policy "aws_s3_bucket" "tag_owner_check_create_policy" {
  enforcement_level = "mandatory"
  operations = ["create"]
  enforce {
    condition     = core::try(attrs.tags.Owner == "test", false)
    error_message = "bucket must have an owner tag. Current value: ${attrs.tags.Owner} with operation ${meta.operation}"
    info_message = "Bucket must have an owner tag. Current owner value: ${attrs.tags.Owner} with operation ${meta.operation}"
  }
}

resource_policy "aws_s3_bucket" "feature_func_core_getresources" {
  enforce {
    condition    = core::length(core::getresources("aws_s3_bucket", { bucket = "lookup-me" })) >= 0
    info_message = "core::getresources executed"
  }
}

//unknown policy
resource_policy "aws_s3_bucket" "bucket_namespace_check" {
  enforcement_level = "mandatory"
  enforce {
    condition     = attrs.bucket_namespace == "global"
    info_message = "Bucket namespace is `${attrs.bucket_namespace}`. expected value is `global`"
  }
}

//provider policy
provider_policy "aws" "provider_type_validation" {
  operations = ["create", "update"]
  enforce {
    condition    = core::contains(local.allowed_providers, meta.type)
    info_message = "provider type: ${meta.type} is valid"
  }
}

# provider_policy "aws" "provider_type_format_validation" {
#   enforce {
#     condition     = core::try(core::length(core::regexall("test", meta.type)) > 0, false)
#     error_message = "provider type '${meta.type}' has an invalid format (must be lowercase and may contain only letters, digits, and '-')"
#     info_message  = "provider type '${meta.type}' has a valid format"
#   }
# }

//module policy
module_policy "*" "module_version_check" {
  filter = core::try(meta.version, "") != ""

  locals {
    version = core::try(meta.version, "0.0.0")
  }

  enforce {
    condition     = core::semverconstraint(local.version, ">= 1.0.0")
    error_message = "module version ${local.version} must be >= 1.0.0"
  }
}

resource_policy "random_id" "byte_length_check_create_policy" {
  operations = ["create"]
  enforcement_level = "mandatory_overridable"
  enforce {
    condition     = attrs.byte_length == 8
    info_message = "byte_length must be 8. Current value: ${attrs.byte_length} with operation ${meta.operation}"
  }
}

resource_policy "random_id" "byte_length_check_delete_policy" {
  operations = ["delete"]
  enforcement_level = "mandatory_overridable"
  enforce {
    condition     = prior_attrs.byte_length == 16
    info_message = "byte_length must be 16. Current value: ${prior_attrs.byte_length} with operation ${meta.operation}"
  }
}