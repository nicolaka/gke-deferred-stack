identity_token "gcp" {
    audience = ["//iam.googleapis.com/projects/770146596695/locations/global/workloadIdentityPools/my-tfc-pool-kukho/providers/my-tfc-provider-id"]
}

identity_token "kube" {
    audience = ["gke-demo"]
}

deployment "demo" {
    inputs = {
        cluster_name        = "demo"
        kubernetes_version  = "1.29"
        identity_token_file = identity_token.gcp.jwt_filename
        gcp_audience        = "//iam.googleapis.com/projects/770146596695/locations/global/workloadIdentityPools/my-tfc-pool-kukho/providers/my-tfc-provider-id"
        gcp_project         = "hc-terraform-k8s-testing"
        gcp_region          = "europe-central2"
        gcp_service_account_email = "tfc-service-account@hc-terraform-k8s-testing.iam.gserviceaccount.com"
    }
}