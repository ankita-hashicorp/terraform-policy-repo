policy {
}

locals {
  allowed_providers = ["azure", "google"]
  allowed_regions   = ["us-east-1", "us-west-2", "eu-west-1", "ap-south-1"]
}

input "approved_module_prefixes" {
  type    = list(string)
  default = ["./modules/", "registry.terraform.io/"]
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
resource_policy "aws_s3_bucket" "bucket_namespace_check" {
  enforcement_level = "mandatory_overridable"
  enforce {
    condition     = attrs.bucket_namespace == "global"
    info_message = "Bucket namespace is `${attrs.bucket_namespace}`. expected value is `global`"
  }
}

//provider policy
provider_policy "aws" "provider_type_validation" {
  enforce {
    condition    = core::contains(local.allowed_providers, meta.type)
    info_message = "provider type: ${meta.type} is valid"
  }
}

//module policy
module_policy "*" "module_source_check" {
  locals {
    source = core::try(meta.source, "")
    matches = [
      for prefix in input.approved_module_prefixes : prefix
      if core::length(core::regexall("^${prefix}", local.source)) > 0
    ]
  }

  enforce {
    condition     = core::length(local.matches) > 0
    error_message = "module source '${local.source}' is not from an approved prefix (${core::join(", ", input.approved_module_prefixes)})"
    info_message  = "module source '${local.source}' matches approved prefixes"
    test=true
  }
}

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

