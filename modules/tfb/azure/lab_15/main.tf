# Add resources for the lab below
# Generate a random suffix for resource uniqueness
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# Create Resource Groups using the resource_group module
module "app_resource_group" {
  source      = "./modules/resource_group"
  environment = var.environment
  location    = var.location
  name_prefix = "app"

  tags = {
    Application = "WebApp"
    Purpose     = "Application Resources"
  }
}

module "monitoring_resource_group" {
  source      = "./modules/resource_group"
  environment = var.environment
  location    = var.location
  name_prefix = "monitoring"

  tags = {
    Application = "Monitoring"
    Purpose     = "Monitoring Resources"
  }
}

# Create custom roles using the role_definition module
module "storage_reader_role" {
  source      = "./modules/role_definition"
  environment = var.environment
  role_name   = "storage-reader"
  scope       = module.app_resource_group.resource_group_id
  description = "Custom role for read-only access to storage accounts"

  permissions = {
    actions = [
      "Microsoft.Storage/storageAccounts/read",
      "Microsoft.Storage/storageAccounts/blobServices/containers/read"
    ]
    data_actions     = []
    not_actions      = []
    not_data_actions = []
  }
}

module "metrics_collector_role" {
  source      = "./modules/role_definition"
  environment = var.environment
  role_name   = "metrics-collector"
  scope       = module.monitoring_resource_group.resource_group_id
  description = "Custom role for collecting metrics from resources"

  permissions = {
    actions = [
      "Microsoft.Insights/metrics/read",
      "Microsoft.Insights/metricDefinitions/read",
      "Microsoft.Insights/diagnosticSettings/read"
    ]
    data_actions     = []
    not_actions      = []
    not_data_actions = []
  }
}