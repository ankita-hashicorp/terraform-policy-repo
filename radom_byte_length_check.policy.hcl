policy {
}

resource_policy "random_id" "keepers_byte_length_check" {
  enforcement_level = "mandatory_overridable"
  enforce {
    condition     = core::try(attrs.byte_length == 4, false)
    info_message = "random_id resource 'byte_length' must be set to 4. Current value: ${attrs.byte_length}"
  }
}
