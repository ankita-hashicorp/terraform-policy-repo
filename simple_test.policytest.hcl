policytest {
  targets = ["simple_test.policy.hcl"]
}

resource "aws_cloudtrail" "positve_case" {
  attrs = {
    enable_log_file_validation = true
  }
}


resource "aws_cloudtrail" "negative_case" {
  expect_failure = true

  attrs = {
    enable_log_file_validation = false
  }
}

