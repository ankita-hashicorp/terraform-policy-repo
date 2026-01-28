policy {
}

resource_policy "aws_instance" "monitoring_env_check" {
  enforce {
    condition     = core::try(attrs.monitoring, false)
  }

  enforce {
    condition     = core::try(attrs.tags["Environment"] == "production", false)
  }
}