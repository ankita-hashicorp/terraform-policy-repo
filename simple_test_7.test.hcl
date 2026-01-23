policy {
}

resource_policy "aws_instance" "ami_owner_check" {
  enforce {
    condition     = core::try(attrs.ami != "", false)
    info_message = "AMI must be set for ${attrs.key_name} instance"
  }

  enforce {
    condition     = core::try(attrs.tags["Owner"] != "", false)
    info_message = "tag Owner must be set for ${attrs.key_name} instance"
  }
}