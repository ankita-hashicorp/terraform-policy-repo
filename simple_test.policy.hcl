policy {
}

resource_policy "aws_instance" "enable_log_file_validation" {
  enforce {
    condition     = core::try(attrs.instance_type == "t2.micro", false)
    info_message = "instance_type must be t2.micro"
  }
}