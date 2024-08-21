# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      
      # THIS IS IMPORTANT - newer versions contain an issue in the `google_client_config` datasource
      # that prevents issuing auth tokens for GKE
      version = "4.59.0"
    }
  }
}

locals {
  google_zone  = data.google_compute_zones.available.names[0]
  cluster_name = "${var.cluster_name}-${random_string.demo.result}"
}

resource "random_string" "demo" {
  length  = 4
  special = false
  upper   = false
}

# This is used to set local variable google_zone.
# This can be replaced with a statically-configured zone, if preferred.
data "google_compute_zones" "available" {
  region = var.region
}

data "google_client_config" "current" {
}

data "google_container_engine_versions" "supported" {
  location       = local.google_zone
  version_prefix = var.kubernetes_version
}

resource "google_container_cluster" "default" {
  name               = local.cluster_name
  location           = local.google_zone
  initial_node_count = var.workers_count
  min_master_version = data.google_container_engine_versions.supported.latest_master_version
  # node version must match master version
  # https://www.terraform.io/docs/providers/google/r/container_cluster.html#node_version
  node_version = data.google_container_engine_versions.supported.latest_master_version

  release_channel {
    channel = "RAPID"
  }

  node_locations = [
    data.google_compute_zones.available.names[1],
  ]

  node_config {
    machine_type = "n1-standard-4"
  }

  # deletion_protection = false
}
