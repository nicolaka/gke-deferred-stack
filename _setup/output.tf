# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "stack_name" {
  description = "Name of newly created Stack."
  value       = tfe_stack.demo.name
}
