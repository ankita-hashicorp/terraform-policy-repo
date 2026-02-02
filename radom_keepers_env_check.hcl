policy {
}

resource_policy "random_id" "keepers_env_check" {
  enforce {
    condition     = core::try(attrs.keepers["env"], true)
    policy_err="Resource 'random_id' must have a 'keepers' attribute with an 'env' key."
  }
}