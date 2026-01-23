policy {
}

resource_policy "aws_instance" "enable_log_file_validation" {
  enforce {
    condition     = core::try(attrs.instance_type == "t2.micro", false)
    info_message = "instance_type must be t2.micro"
  }

  enforce {
    condition     = core::try(attrs.instance_type == "t1.micro", false)
    info_message = "instance_type must be t1.micro"
  }

  enforce {
    condition     = core::try(attrs.monitoring, false)
    info_message = "instance monitoring must be enabled"
  }

  enforce {
    condition     = core::try(attrs.tags["Environment"] == "production", false)
    info_message = "tag Environment must be set to production"
  }
}