policy {
}

resource_policy "aws_instance" "associate_public_ip_address_owner_tag_check" {
  enforce {
    condition     = core::try(attrs.associate_public_ip_address != true, false)
    info_message = "associate_public_ip_address must be disabled for ${attrs.key_name} instance"
  }

  enforce {
    condition     = core::try(attrs.tags["Owner"] != "", false)
    info_message = "tag Owner must be set for ${attrs.key_name} instance"
  }
}