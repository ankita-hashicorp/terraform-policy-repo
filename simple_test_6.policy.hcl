policy {
}

resource_policy "aws_instance" "source_dest_check_availability_check" {
  enforce {
    condition     = core::try(attrs.source_dest_check, false)
    info_message = "source_dest_check must be enabled"
  }
}