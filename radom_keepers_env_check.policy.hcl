policy {
}

resource_policy "random_id" "keepers_env_check" {
  enforce {
    condition     = core::try(attrs.keepers["env"], true)
  }
}