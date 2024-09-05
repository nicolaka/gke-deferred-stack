identity_token "gcp" {
    audience = ["//iam.googleapis.com/projects/770146596695/locations/global/workloadIdentityPools/stacks-demo-8vm0/providers/stacks-demo-8vm0"]
}

deployment "demo" {
    inputs = {
        cluster_name              = "demo"
        kubernetes_version        = "1.30"
        identity_token_gcp        = identity_token.gcp.jwt_filename
        gcp_project               = "hc-terraform-k8s-testing"
        gcp_region                = "europe-central2"

        gcp_audience              = "//iam.googleapis.com/projects/770146596695/locations/global/workloadIdentityPools/stacks-demo-8vm0/providers/stacks-demo-8vm0"
        gcp_service_account_email = "stacks-demo-8vm0@hc-terraform-k8s-testing.iam.gserviceaccount.com"
    }
}