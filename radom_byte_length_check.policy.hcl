policy {
}

resource_policy "random_id" "keepers_byte_length_check" {
  enforcement_level = "mandatory_overridable"
  enforce {
    condition     = attrs.byte_length == 4
    info_message = "random_id resource 'byte_length' must be set to 4. Current value: ${attrs.byte_length}"
  }
}



input "abcd" {
  type = string
  sensitive = false
  default = "value"
}

resource_policy "random_id" "keepers_value_local_check" {
  enforcement_level="mandatory_overridable"
  enforce {
    condition     = input.abcd == "value"
    error_message = "Expected value: ${input.abcd}"
    info_message = "Info value: ${input.abcd}"
  }
}