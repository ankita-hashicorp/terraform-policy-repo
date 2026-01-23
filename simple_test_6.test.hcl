policy {
}

resource_policy "aws_instance" "source_dest_check_availability_check" {
  enforce {
    condition     = core::try(attrs.source_dest_check != true, false)
    info_message = "source_dest_check must be enabled"
  }

  enforce {
    condition     = core::try(attrs.availability_zone != "", false)
    info_message = "availability_zone must be set for instance"
  }
}