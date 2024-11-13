# Example Stack for Kubernetes - GKE
This example demonstates an HCP Terraform Stack that creates an GKE cluster together with Kubernetes resources. 
It leverages deferred actions to enable users to create all the resources in the correct order using a single deployment action.

## Prerequisites

* Valid GCloud credentials configured in the local environment (eg. via `gcloud auth`).
* API token for app.terraform.io created in the local environment (via `terraform login`)

## How to use:

1. Fork this repo

2. Apply the `_setup` module from your local environment.

This does two things:
    * Creates the ODIC IDP configuration in GCloud which enables TFC workload identity authentication from Stacks.
    * Creates the Stack itself in TFC. It doesn't configure it for the custom agent pool mentioned above due to limitations in the TFE provider.

When using the Terraform configuration you will need to set several TF variables, and some Google provider environment variables:

```bash
# Replace the values in < > as appropriate
export TF_VAR_tfc_organization_name=<org name>
export TF_VAR_tfc_project_name=<project name>
export TF_VAR_github_token=<token, or use $(gh auth token)>
export TF_VAR_github_repo_identifier=<your github username>/gke-deferred-stack

export GOOGLE_PROJECT=<project_id>
export GOOGLE_CREDENTIALS=<credentials>  # OPTIONAL - instead you can set up Application Default Credentials on your machine using `gcloud auth application-default login`
```

Also, ensure that 

3. Ensure Stacks is enabled for your HCP Terraform organization in [Organization Settings > General](https://app.terraform.io/app/m-org-name-here/settings/profile). Stacks is available in Beta on the Free tier.
4. Create a new Stack in a given Project within that organization. Connect that Stack to your fork of this repo.
4. Fetch configuration in the Stack UI to trigger the plan / apply cycle.
