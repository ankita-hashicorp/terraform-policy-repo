policy {
}

resource_policy "aws_instance" "aws_instance_key_name_check" {
  enforcement_level = "mandatory_overridable"
  enforce {
    condition     = core::try(attrs.key_name == "example-key-2", false)
    info_message = "key_name must be set to example-key-2. Current value: ${attrs.key_name}"
  }
}