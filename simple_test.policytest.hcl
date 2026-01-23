policytest {
  targets = ["simple_test.policy.hcl"]
}

resource "aws_instance" "pass_case" {
  attrs = {
    snapshot_retention_limit = 1,
    enable_log_file_validation = true
  }
}

resource "aws_instance" "pass_case_1" {
  attrs = {
    snapshot_retention_limit = 1,
    enable_log_file_validation = false
  }
}
resource "aws_instance" "pass_case_2" {
  attrs = {
    snapshot_retention_limit = 1,
    enable_log_file_validation = false
  }
}

resource "aws_instance" "pass_case_3" {
  attrs = {
    snapshot_retention_limit = 1,
    enable_log_file_validation = false
  }
}
