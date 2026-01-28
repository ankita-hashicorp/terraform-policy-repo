policy {
}

resource_policy "random_id" "random_keepers_check" {
  enforce {
    condition = core::try(attrs.byte_length != 2, true)
  }
}