policy {}

input "param1" {
  type = string
  default = "val1"
}

resource_policy "random_id" "byte_length_check" {
  enforcement_level = "mandatory_overridable"
  enforce {
    condition     = attrs.byte_length > 2 && input.param1 == "val1"
    info_message = "byte_length must be 8. Current value: ${attrs.byte_length} and input ${input.param1}"
  }
}

resource_policy "random_pet" "length_prefix_check" {
  enforcement_level = "advisory"
  enforce {
    condition     = attrs.length == 3 && attrs.prefix == "dev"
    info_message = "length must be 3 and prefix must be 'dev'. Current values: length=${attrs.length}, prefix=${attrs.prefix}"
    error_message = "length must be 3 and prefix must be 'dev'. Current values: length=${attrs.length}, prefix=${attrs.prefix}"
  }
}

//unknown policy
resource_policy "random_id" "random_dec_check" {
  enforcement_level = "advisory"
  enforce {
    condition     = core::try(attrs.dec == "test", false)
    info_message = "length must be 3 and prefix must be 'dev'. Current values: length=${attrs.length}, prefix=${attrs.prefix}"
    error_message = "length must be 3 and prefix must be 'dev'. Current values: length=${attrs.length}, prefix=${attrs.prefix}"
  }
}

# //errored policy
# resource_policy "random_id" "random_dec_check" {
#   enforcement_level = "advisory"
#   enforce {
#     condition     = core::try(attrs.dec === "test", false)
#     info_message = "length must be 3 and prefix must be 'dev'. Current values: length=${attrs.length}, prefix=${attrs.prefix}"
#     error_message = "length must be 3 and prefix must be 'dev'. Current values: length=${attrs.length}, prefix=${attrs.prefix}"
#     test_message = "aaa"
#   }
# }

resource_policy "random_password" "length_special_check" {
  enforcement_level = "mandatory_overridable"
  enforce {
    condition     = attrs.length != 10 && attrs.special == true
    info_message = "length must be 10 and special must be true. Current values: length=${attrs.length}, special=${attrs.special}"
    error_message = "length must be 10 and special must be true. Current values: length=${attrs.length}, special=${attrs.special}"
  }
}

resource_policy "random_shuffle" "result_count_check" {
  enforcement_level = "mandatory_overridable"
  enforce {
    condition     = core::try(attrs.result_count == 2, false) && core::try(core::length(attrs.input) != 0, false)
    info_message = "result_count must be 1 and input must not be empty. Current value: ${attrs.result_count}"
    error_message = "result_count must be 1 and input must not be empty. Current value: ${attrs.result_count}"
  }
}