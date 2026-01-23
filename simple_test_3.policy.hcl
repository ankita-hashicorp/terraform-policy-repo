policy {
}

resource_policy "aws_instance" "monitoring_subnet_check" {
  enforce {
    condition     = core::try(attrs.monitoring, false) && core::try(attrs.tags["Environment"] == "production", false)
    info_message = "instance monitoring must be enabled and not in non-production environment"
  }

  enforce {
    condition     = core::try(attrs.subnet_id != "", false)
    info_message = "subnet_id must be set for instance"
  }
}