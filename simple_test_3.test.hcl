policy {
}

resource_policy "aws_instance" "volume_size_subnet_check" {
  enforce {
    condition     = core::try(attrs.root_block_device.volume_size > 0, false)
    info_message = "root block device volume size must be greater than 0"
  }

  enforce {
    condition     = core::try(attrs.subnet_id != "", false)
    info_message = "subnet_id must be set for instance"
  }
}