policy {
}

resource_policy "aws_instance" "volume_size_subnet_check" {
  enforce {
    condition     = core::try(attrs.instance_type == "t2.micro", false)
    error_message = "instance_type must be t2.micro for this check to be applicable. Current value: ${attrs.instance_type}"
  }

  enforce {
    condition     = core::try(attrs.subnet_id != "", false)
    info_message = "subnet_id must be set for instance"
  }
}