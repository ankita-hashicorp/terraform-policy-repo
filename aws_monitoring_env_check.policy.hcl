policy {
}

resource_policy "aws_instance" "monitoring_env_check" {
  enforce {
    condition     = core::try(attrs.monitoring == false, false)
  }
}