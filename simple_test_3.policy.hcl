policy {
}

resource_policy "aws_instance" "volume_size_subnet_check" {
  enforce {
    condition     = core::try(attrs.instance_type == "", false)
    info_message = "instance_type must not be set for instance"
  }

  enforce {
    condition     = core::try(attrs.subnet_id != "", false)
    info_message = "subnet_id must be set for instance"
  }
}