# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "stack_name" {
  description = "Name of newly created Stack."
  value       = tfe_stack.demo.name
}

output "gcp_service_account_email" {
  description = "Email of federated identity service account."
  value = google_service_account.tfc_service_account.email
}

output "gcp_audience" {
  description = "Audience for stack's workload identity tokens."
  value = "//iam.googleapis.com/${google_iam_workload_identity_pool_provider.tfc_provider.name}"
}