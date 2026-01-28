policy {
}

resource_policy "aws_instance" "monitoring_env_check" {
  enforce {
    condition     = core::try(attrs.root_block_device.volume_type != "gp2", false)
    info_message = "instance monitoring must be enabled and not in dev environment"
  }

  enforce {
    condition     = core::try(attrs.tags["Environment"] == "dev", false)
    info_message = "tag Environment must be set to production and not dev"
  }
}