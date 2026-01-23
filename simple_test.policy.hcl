policy {
    enforcement_level = advisory
}

resource_policy "aws_instance" "enable_log_file_validation" {
  enforce {
    condition     = core::try(attrs.enable_log_file_validation, false)
    error_message = "attr value of this resource must be true"
  }

  enforce {
    condition     = core::try(attrs.name, 0) == "pass_case"
    error_message = "attr value of this resource must be 'pass_case'"
  }

   enforce {
    condition     = core::try(attrs.snapshot_retention_limit, 0) >= 1
    error_message = "Snapshot retention limit must be greater than or equal to 1 for elasticache cluster"
  }
  
  enforce {
    condition     = core::try(attrs.enable_monitoring, false)
    error_message = "Monitoring must be enabled for this instance"
  }

  enforce {
    condition     = core::try(attrs.tags["Environment"], "") != ""
    error_message = "Instance must have an 'Environment' tag"
  }

  enforce {
    condition     = core::try(attrs.volume_size, 0) >= 20
    error_message = "Root volume size must be at least 20 GB"
  }

  enforce {
    condition     = core::try(attrs.associate_public_ip_address, true) == false
    error_message = "Public IP association must be disabled"
  }

  enforce {
    condition     = core::try(attrs.ami, "") != ""
    error_message = "AMI must be specified for the instance"
  }
}