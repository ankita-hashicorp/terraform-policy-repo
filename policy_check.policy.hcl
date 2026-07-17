policy {}

resource_policy "random_id" "byte_length_check" {
  enforce {
    condition     = attrs.byte_length > 2
    info_message = "byte_length must be 8. Current value: ${attrs.byte_length} with operation ${meta.operation}"
    error=true
  }
}

resource_policy "random_pet" "length_prefix_check" {
  enforcement_level = "advisory"
  enforce {
    condition     = attrs.length == 3 && attrs.prefix != "dev"
    info_message = "length must be 3 and prefix must be 'dev'. Current values: length=${attrs.length}, prefix=${attrs.prefix}"
    error_message = "length must be 3 and prefix must be 'dev'. Current values: length=${attrs.length}, prefix=${attrs.prefix}"
  }
}

resource_policy "random_password" "length_special_check" {
  enforcement_level = "mandatory_overridable"
  enforce {
    condition     = attrs.length != 10 && attrs.special == true
    info_message = "length must be 10 and special must be true. Current values: length=${attrs.length}, special=${attrs.special}"
    error_message = "length must be 10 and special must be true. Current values: length=${attrs.length}, special=${attrs.special}"
  }
}

resource_policy "random_shuffle" "result_count_check" {
  enforcement_level = "mandatory"
  enforce {
    condition     = core::try(attrs.result_count == 1, false) && core::try(core::length(attrs.input) != 0, false)
    info_message = "result_count must be 1 and input must not be empty. Current value: ${attrs.result_count}"
    error_message = "result_count must be 1 and input must not be empty. Current value: ${attrs.result_count}"
  }
}