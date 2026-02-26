policy {
}

resource_policy "random_id" "random_byte_length_check" {
  enforce {
    condition = attrs.byte_length == 4
    info_message = "Resource 'random_id' must have a byte_length of 4"
    error_message = "Resource 'random_id' has a byte_length is ${attrs.byte_length}, expected 4"
  }
}