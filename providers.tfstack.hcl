required_providers {
  kubernetes = {
    source  = "hashicorp/kubernetes"
    version = "~> 2.32.0"
  }
  google = {
    source  = "hashicorp/google"
    # THIS IS IMPORTANT - newer versions contain an issue in the `google_client_config` 
    # that prevents issuing auth tokens for GKE
    version = "6.32.0"
  }
  random = {
    source = "hashicorp/random"
    version = "~> 3.6.2"
  }
}

provider "google" "main" {
  config {
    project = var.gcp_project
    region  = var.gcp_region
    #credentials = var.gcp_credentials
    external_credentials {
      audience = var.gcp_audience // audience from WIF
      service_account_email = var.gcp_service_account_email // service account created from WIF
      identity_token = var.jwt
    }
}
}

provider "kubernetes" "main" {
  config {
    host                   = component.cluster.cluster_api
    cluster_ca_certificate = component.cluster.cluster_ca
    token                  = component.cluster.token
  }
}

provider "random" "main" {}
