policy {
}

resource_policy "aws_instance" "root_encryption_env_check" {
  enforce {
    condition     = core::try(attrs.root_block_device.encrypted == true, false)
    info_message = "root block device must be encrypted"
  }

  enforce {
    condition     = core::try(attrs.tags["Environment"] == "production", false)
    info_message = "tag Environment must be set to production"
  }
}