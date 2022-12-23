#To get all the available roles in GCP, please visit the following URL: https://cloud.google.com/iam/docs/understanding-roles

module "organization-iam-bindings" {
  source        = "terraform-google-modules/iam/google//modules/organizations_iam"
  organizations = [var.org_id] #Organization ID
  mode          = "authoritative"

  for_each = var.binding_settings

  bindings = { for role in each.value : role => ["group:${each.key}"] }
}