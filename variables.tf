variable "org_id" {
    type = number
    default = "" #Fill it with the Org ID
}
variable "binding_settings" {
  type = map(any)
  default = {
    "gcp_customer_org_admins@<customer_domain>"         = ["roles/billing.user", "roles/resourcemanager.organizationAdmin", "roles/resourcemanager.projectCreator", "roles/serviceusage.serviceUsageConsumer"]
    "gcp_customer_billing_admins@<customer_domain>"     = ["roles/billing.user", "roles/billing.creator", "roles/billing.admin"]
    "gcp_customer_billing_data_users@<customer_domain>" = ["roles/billing.viewer", "roles/bigquery.user", "roles/bigquery.dataViewer"]
    "gcp_customer_audit_data_users@<customer_domain>"   = ["roles/bigquery.user", "roles/bigquery.dataViewer"]
    "gcp_customer_monitoring_admins@<customer_domain>"  = ["roles/monitoring.editor"]
    "gcp_customer_networking_admins@<customer_domain>"  = ["roles/compute.networkAdmin", "roles/compute.securityAdmin"]
    "gcp_customer_iaas_team@<customer_domain>"          = ["roles/bigquery.admin", "roles/billing.admin", "roles/compute.xpnAdmin", "roles/editor", "roles/resourcemanager.folderCreator", "roles/resourcemanager.organizationAdmin", "roles/billing.projectManager", "roles/resourcemanager.projectCreator", "roles/resourcemanager.projectDeleter"]
  }
}