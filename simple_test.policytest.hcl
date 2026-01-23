policytest {
  targets = ["simple_test.policy.hcl"]
}
resource "aws_elasticache_cluster" "pass_case" {
  attrs = {
    snapshot_retention_limit = 1
    enable_log_file_validation = false
  }
}

