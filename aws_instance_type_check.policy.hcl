policy {
}

resource_policy "aws_instance" "instance_type_check" {
  enforce {
    condition     = core::try(attrs.instance_type == "t3.micro", false)
  }
}