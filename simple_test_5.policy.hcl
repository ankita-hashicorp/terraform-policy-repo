policy {
}

resource_policy "aws_instance" "monitoring_encrytption_check" {
  enforce {
    condition     = core::try(attrs.monitoring, false)
    info_message = "instance monitoring must be enabled in instanve"
  }

  enforce {
    condition     = core::try(attrs.root_block_device.encrypted != false, false)
    info_message = "root block device must be encrypted"
  }
}