policy {
}

resource_policy "aws_instance" "root_encryption_owner_check" {
  enforce {
    condition     = core::try(attrs.source_dest_check != true, false)
    info_message = "source_dest_check must be enabled"
  }

  enforce {
    condition     = core::try(attrs.tags["Owner"] != "", false)
    info_message = "tag Owner must be set for ${attrs.key_name} instance"
  }
}