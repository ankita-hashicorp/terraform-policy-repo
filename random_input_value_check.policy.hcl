policy {
}

resource_policy "random_id" "random_keepers_check" {
  enforce {
    condition = core::try(attrs.keepers["instance_type"] == "t3.micro", false)
  }
}