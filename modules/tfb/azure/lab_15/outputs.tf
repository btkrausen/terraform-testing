# Add outputs below
output "resource_group_ids" {
  description = "IDs of the created resource groups"
  value = {
    app        = module.app_resource_group.resource_group_id,
    monitoring = module.monitoring_resource_group.resource_group_id
  }
}

output "resource_group_names" {
  description = "Names of the created resource groups"
  value = {
    app        = module.app_resource_group.resource_group_name,
    monitoring = module.monitoring_resource_group.resource_group_name
  }
}

output "role_definition_ids" {
  description = "IDs of the created role definitions"
  value = {
    storage_reader    = module.storage_reader_role.role_definition_id,
    metrics_collector = module.metrics_collector_role.role_definition_id
  }
}

output "role_definition_names" {
  description = "Names of the created role definitions"
  value = {
    storage_reader    = module.storage_reader_role.role_definition_name,
    metrics_collector = module.metrics_collector_role.role_definition_name
  }
}