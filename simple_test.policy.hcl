policy {
}

resource_policy "aws_instance" "instance_type_check" {
  enforce {
    condition     = core::try(attrs.instance_type == "t2.micro", false)
    info_message = "instance_type must be t2.micro"
  }

  enforce {
    condition     = core::try(attrs.instance_type == "t1.micro", false)
    info_message = "instance_type must be t1.micro"
  }

  enforce {
    condition     = core::try(attrs.instance_type == "t4.micro", false)
    info_message = "instance_type must be t4.micro"
  }

  enforce {
    condition     = core::try(attrs.instance_type == "t4.macro", false)
    info_message = "instance_type must be t4.macro"
  }
  
}

resource_policy "aws_instance" "instance_monitoring_env_check" {
  enforce {
    condition     = core::try(attrs.monitoring, false)
    info_message = "instance monitoring must be enabled"
  }

  enforce {
    condition     = core::try(attrs.tags["Environment"] == "production", false)
    info_message = "tag Environment must be set to production"
  }

  enforce {
    condition     = core::try(attrs.tags["Environment"] == "staging", false)
    info_message = "tag Environment must be set to staging"
  }

  enforce {
    condition     = core::try(attrs.tags["Environment"] == "qa", false)
    info_message = "tag Environment must be set to qa"
  }
}