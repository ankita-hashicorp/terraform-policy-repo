policy {
}

resource_policy "aws_instance" "instance_type_check" {
  enforcement_level = "mandatory_overridable"
  enforce {
    condition     = core::try(attrs.instance_type == "t2.micro", false)
    error_message = "instance_type must be t2.micro for this check to be applicable. Current value: ${attrs.instance_type}"
  }

 
}