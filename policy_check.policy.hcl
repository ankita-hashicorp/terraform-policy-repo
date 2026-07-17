policy {}

resource_policy "random_id" "byte_length_check" {
  enforce {
    condition     = attrs.byte_length == 8
    info_message = "byte_length must be 8. Current value: ${attrs.byte_length} with operation ${meta.operation}"
  }
}