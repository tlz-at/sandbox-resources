variable "region" {
  description = "AWS Region to deploy to"
}

variable "region_secondary" {
  description = "AWS secondary region to deploy to"
}

variable "role_name" {
  description = "AWS role name to assume"
}

variable "account_id" {
  description = "The AWS ID of the account"
}

variable "account_type" {
  description = "The Account Type of the account"
}

variable "name" {
  description = "The name for the account"
}

variable "okta_provider_domain" {
  description = "The domain name of the IDP.  This is concatenated with the app name and should be in the format 'site.domain.tld' (no protocol or trailing /)."
}

variable "okta_app_id" {
  description = "The Okta app ID for SSO configuration."
}

variable "owner" {
  description = "Friendly name of team or person responsible for the account"
  default     = ""
}

variable "environment" {
  description = "environment named instance type. Examples are: prod, stage, test, etc."
  default     = "NA"
}

# VPC Variables
variable "cidr_primary" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  default     = "0.0.0.0/0"
}

variable "azs_primary" {
  description = "A list of availability zones in the region"
  default     = []
}

variable "cidr_secondary" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  default     = "0.0.0.0/0"
}

variable "azs_secondary" {
  description = "A list of availability zones in the region"
  default     = []
}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  default     = false
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  default     = false
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "assign_generated_ipv6_cidr_block" {
  description = "Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block"
  default     = false
}

variable "enable_s3_endpoint" {
  description = "Configure an S3 Endpoint on the VPC"
  default     = false
}

variable "enable_dynamodb_endpoint" {
  description = "Configure a DynamoDB Endpoint on the VPC"
  default     = false
}

variable "tfe_host_name" {
  description = "host_name for ptfe"
  default     = "prod.ptfe.dht.dev"
}

variable "tfe_org_name" {
  description = "ptfe organization name"
  default     = "example"
}

variable "tfe_avm_workspace_name" {
  description = "avm workspace name"
}

variable "tfe_core_logging_workspace_name" {
  description = "core logging workspace name"
}

variable "users_tlz_it_operations" {
  type        = "list"
  description = "list of user emails to provide access to this role (via okta)"
}

variable "users_tlz_intra_network" {
  type        = "list"
  description = "list of user emails to provide access to this role (via okta)"
}

variable "users_tlz_admin" {
  type        = "list"
  description = "list of user emails to provide access to this role (via okta)"
}

variable "users_tlz_developer" {
  type        = "list"
  description = "list of user emails to provide access to this role (via okta)"
}

variable "users_tlz_developer_ro" {
  type        = "list"
  description = "list of user emails to provide access to this role (via okta)"
}

variable "terraform_service_user" {
  description = "service user"
  default     = "terraform_svc"
}

variable "okta_token" {
  type = "string"
  description = "Okta API token (sensitive)"
}