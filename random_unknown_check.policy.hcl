policy {
}

resource_policy "random_id" "random_unknown_check" {
  enforce {
    condition = local.unknown_attribute == "some_value"
  }
}