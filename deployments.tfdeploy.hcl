/*
identity_token "gcp" {
  # Must be the fully qualified path to the identity provider: //iam.googleapis.com/projects/<PROJECT NUMBER>/locations/global/workloadIdentityPools/<POOL ID>/providers/<PROVIDER ID>
  #audience = ["//iam.googleapis.com/projects/342971845164/locations/global/workloadIdentityPools/stacks-demo-4y2i/providers/stacks-demo-4y2i"]
  audience = ["hcp.workload.identity"]
}
*/

identity_token "gcp" {
  audience = ["hcp.workload.identity"]
}

deployment "demo" {
    inputs = {
        cluster_name              = "demo"
        kubernetes_version        = "1.30"
        # gcp_credentials           = store.varset.gcp_credentials.credentials
        #identity_token_gcp        = identity_token.gcp.jwt
        jwt                       = identity_token.gcp.jwt
        gcp_project               = "hc-f94b5bbd5bef497882db3d5fbf8"  # The project that the Stack will make resources in. This will need to be a project that the service account in _setup has permissions in. 
        gcp_region                = "us-central1"
        gcp_audience              = "//iam.googleapis.com/projects/342971845164/locations/global/workloadIdentityPools/terraform-stacks-pool/providers/terraform-stacks-provider" # Should be the `gcp_audience` output from the Terraform configuration in ./_setup
        gcp_service_account_email = "terraform-stacks-sa@hc-f94b5bbd5bef497882db3d5fbf8.iam.gserviceaccount.com" # Should be the `gcp_service_account_email` output from the Terraform configuration in ./_setup
    }
}

