policy {
}

resource_policy "aws_instance" "source_dest_check_env_check" {
  enforce {
    condition     = core::try(attrs.source_dest_check != true, false)
    info_message = "source_dest_check must be enabled"
  }

  enforce {
    condition     = core::try(attrs.tags["Environment"] == "production", false)
    info_message = "tag Environment must be set to production"
  }
}