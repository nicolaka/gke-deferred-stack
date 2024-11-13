identity_token "gcp" {
    audience = ["REPLACE_ME"] # String should be the `gcp_audience` output from the Terraform configuration in ./_setup
}

deployment "demo" {
    inputs = {
        cluster_name              = "demo"
        kubernetes_version        = "1.30"
        identity_token_gcp        = identity_token.gcp.jwt_filename
        gcp_project               = "REPLACE_ME"  # The project that the Stack will make resources in. This will need to be a project that the service account in _setup has permissions in. 
        gcp_region                = "europe-central2"

        gcp_audience              = "REPLACE_ME" # Should be the `gcp_audience` output from the Terraform configuration in ./_setup
        gcp_service_account_email = "REPLACE_ME" # Should be the `gcp_service_account_email` output from the Terraform configuration in ./_setup
    }
}