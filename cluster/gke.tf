# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.42.0"
    }
    local = {
      source = "hashicorp/local"
    }
  }
}

locals {
  google_zone  = data.google_compute_zones.available.names[0]
  cluster_name = "${var.cluster_name}-${random_string.demo.result}"
}

resource "random_string" "demo" {
  length = 4
  special = false
  upper = false
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

    # oauth_scopes = [
    #   "https://www.googleapis.com/auth/compute",
    #   "https://www.googleapis.com/auth/devstorage.read_only",
    #   "https://www.googleapis.com/auth/logging.write",
    #   "https://www.googleapis.com/auth/monitoring",
    # ]
  }

  deletion_protection = false
}

resource "local_file" "google_token" {
  filename = "google_token"
  content =  data.google_client_config.current.access_token != null ? data.google_client_config.current.access_token : "NO-TOKEN"
}