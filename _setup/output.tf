# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "stack_name" {
  description = "Name of newly created Stack."
  value       = tfe_stack.demo.name
}

output "identity_pool_provider" {
  description = "Name of GCP workload identity pool."
  value = google_iam_workload_identity_pool_provider.tfc_provider.name
}