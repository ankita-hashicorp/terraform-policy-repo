policy {
}

resource_policy "random_id" "random_unknown_check" {
  enforce {
    condition = attrs.unknown_attribute
  }
}