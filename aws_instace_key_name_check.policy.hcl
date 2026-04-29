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