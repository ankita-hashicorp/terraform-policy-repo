policy {
}

resource_policy "random_id" "keepers_byte_length_check" {
  enforcement_level = "advisory"
  enforce {
    condition     = core::try(attrs.keepers["instance_type"] == "t3.micro", false)
    info_message = "Instance_type: ${attrs.keepers["instance_type"]}"
  }

  enforce {
    condition     = core::try(attrs.byte_length == 16, false)
    info_message = "random_id resource 'byte_length' must be set to 16. Current value: ${attrs.byte_length}"
  }

}
