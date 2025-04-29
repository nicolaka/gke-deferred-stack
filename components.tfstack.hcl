component "cluster" {
  source = "./cluster"

  providers = {
    google = provider.google.main
    local  = provider.local.main
    random = provider.random.main
  }

  inputs = {
    cluster_name       = var.cluster_name
    kubernetes_version = var.kubernetes_version
    region             = var.gcp_region
  }
}

component "kube" {
  source = "./kube"

  providers = {
    kubernetes = provider.kubernetes.main
  }
}

component "app" {
  source = "./app"

  providers = {
    kubernetes = provider.kubernetes.main
  }
}
