policy {
}

resource_policy "random_id" "random_keepers_check" {
  enforce {
    condition = core::try(attrs.byte_length, false)
    info_message = "The 'name' keeper must be specified in random_id resource"
  }
}