policy {
}

resource_policy "aws_instance" "monitoring_env_check" {
  enforce {
    condition     = core::try(attrs.monitoring, false)
    info_message = "instance monitoring must be enabled"
  }

  enforce {
    condition     = core::try(attrs.tags["Environment"] == "production", false)
    info_message = "tag Environment must be set to production"
  }
}