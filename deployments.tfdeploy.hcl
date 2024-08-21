identity_token "gcp" {
    audience = ["<fill in value of `gcp_audience` output from `_setup`>"]
}

deployment "demo" {
    inputs = {
        cluster_name              = "demo"
        kubernetes_version        = "1.30"
        identity_token_gcp        = identity_token.gcp.jwt_filename
        gcp_project               = "hc-terraform-k8s-testing"
        gcp_region                = "europe-central2"

        gcp_audience              = "< fill in value of `gcp_audience` output from `_setup` >"
        gcp_service_account_email = "< fill in value of `gcp_service_account_email` output from `_setup` >"
    }
}