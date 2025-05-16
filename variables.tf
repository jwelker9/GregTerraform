variable "resource_group_name" {
  description = "My first test with variables"
  default     = "MyTerraformVariableName"
}

variable "ca_ga_account_wmtlabs" {
  description = "to hold the two variables for GA"
  type        = list(string)
  default = [
    "236310e6-0805-46b7-b1e4-6aa965dff289",
    "e636a73f-cd2f-4a7f-93a4-11f0efb9fdac"
  ]
}