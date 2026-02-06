policy {
}

resource_policy "random_id" "random_keepers_check" {
  enforce {
    condition = core::try(attrs.keepers["instance_type"] != "t3.micro", false)
    error_message = "random_id resources with byte_length of 2 are not allowed"
    info_message = "current byte_length is ${core::try(attrs.byte_length, "undefined")}"
  }
}