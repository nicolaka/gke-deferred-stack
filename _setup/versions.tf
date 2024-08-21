terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "< 0.58.0" # avoids a bug in v0.58.0
    }
    google = {
      source = "hashicorp/google"
      # THIS IS IMPORTANT - newer versions contain an issue in the `google_client_config` 
      # that prevents issuing auth tokens for GKE
      version = "4.59.0"
    }
    google-beta = {
      source = "hashicorp/google-beta"
      # THIS IS IMPORTANT - newer versions contain an issue in the `google_client_config` 
      # that prevents issuing auth tokens for GKE
      version = "4.59.0"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}
