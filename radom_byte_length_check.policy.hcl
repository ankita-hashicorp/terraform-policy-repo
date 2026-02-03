policy {
}

resource_policy "random_id" "keepers_env_check" {
  enforce {
    condition     = core::try(attrs.byte_length == 8, false)
    info_message = "random_id resource 'byte_length' must be set to 8. Current value: ${attrs.byte_length}"
  }
}