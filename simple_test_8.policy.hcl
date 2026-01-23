policy {
}

resource_policy "aws_instance" "root_encryption_owner_check" {
  enforce {
    condition     = core::try(attrs.root_block_device.encrypted == true, false)
    info_message = "root block device must be encrypted"
  }

  enforce {
    condition     = core::try(attrs.tags["Owner"] != "", false)
    info_message = "tag Owner must be set for ${attr.key_name} instance"
  }
}