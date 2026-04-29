# Copyright IBM Corp. 2025, 2026

# =============================================================================
# AWS Provider Policies
# =============================================================================
# This file contains all policies for AWS provider configuration.
#
# Policies included:
#   - provider_type_validation: Ensures only allowed providers are used
#   - region_validation: Restricts deployments to approved AWS regions
# =============================================================================

policy {
}

# -----------------------------------------------------------------------------
# Global Locals
# -----------------------------------------------------------------------------
locals {
  allowed_providers = ["aws", "google"]
  allowed_regions   = ["us-east-1", "us-west-2", "eu-west-1"]
}



# -----------------------------------------------------------------------------
# Policy: Provider Type Validation
# Ensures only approved cloud providers are used
# -----------------------------------------------------------------------------
provider_policy "aws" "provider_type_validation" {
  enforce {
    condition    = core::contains(local.allowed_providers, meta.type)
    info_message = "Provider type '${meta.type}' is allowed"
  }
}

# -----------------------------------------------------------------------------
# Policy: Region Validation
# Restricts deployments to approved AWS regions using plugin validation
# Approved regions: us-east-1, us-west-2, eu-west-1
# -----------------------------------------------------------------------------
provider_policy "aws" "region_validation" {
  locals {
    region        = core::try(attrs.region, "")
  }

  enforce {
    condition     = core::contains(local.allowed_regions, local.echoed_region)
    info_message  = "Provider region '${local.echoed_region}' is allowed"
    error_message = "Provider region '${local.echoed_region}' is not in allowed list: ${core::join(", ", local.allowed_regions)}"
  }
}