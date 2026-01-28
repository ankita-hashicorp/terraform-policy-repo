policy {
}

resource_policy "aws_instance" "instance_type_check" {
  enforce {
    condition     = core::try(attrs.instance_type == "t2.micro", false)
    info_message = "instance_type must be t2.micro"
  }

  enforce {
    condition     = core::try(attrs.instance_type == "t1.micro", false)
    info_message = "instance_type must be t1.micro"
    error="test error message"
  }
}