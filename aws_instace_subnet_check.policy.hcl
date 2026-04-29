policy {
}

resource_policy "aws_instance" "aws_instance_subnet_check" {
  enforcement_level = "mandatory_overridable"
  enforce {
    condition     = core::try(attrs.subnet_id != "", false)
    info_message = "subnet_id must not be set for this check to be applicable. Current value: ${attrs.subnet_id}"
  }
}