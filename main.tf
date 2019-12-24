data "terraform_remote_state" "logging" {
  backend = "remote"

  config {
    organization = "${var.tfe_org_name}"
    hostname     = "${var.tfe_host_name}"

    workspaces {
      name = "${var.tfe_core_logging_workspace_name}"
    }
  }
}

# Tagging foundation for resources in account
# module "tlz-tagging" {
#   source  = "tfe.tlzdemo.net/TLZ-Demo/tlz-tagging/aws"
#   #version = "~> 0.1.0"
  
#   #TODO: These should all be variables in workspace, or queried from elsewhere
#   project = "${var.name}"
#   stack_env = "${var.environment}"
#   coa_company = "106"
#   coa_cost_center = "HIT"
#   coa_territory = "RAM"
#   security_data_sensitivity = "protected"
#   stack = "${var.name}"
#   stack_version = "0.1.0"
#   stack_region = "US"
#   stack_lifecycle = "perm"
#   stack_owner = "${var.owner}"
#   stack_support_group = "cirrus@example.com"
# }



# module "vpc_label" {
#   source = "cloudposse/label/terraform"
#   version = "0.4.0"
#   #context = "${module.tlz-tagging.context}"
#   namespace  = "tlz"
#   stage      = "dev"
#   attributes = ["public"]
#   delimiter  = "-"

#   tags = {
#     "BusinessUnit" = "TLZ"
#   } 

#   name = "Primary VPC"
# }

# Networking
module "vpc_primary" {
  source  = "tfe.tlzdemo.net/TLZ-Demo/vpc/aws"
  version = "0.0.1"

  name                     = "tlz-vpc"
  cidr                     = "${var.cidr_primary}"
  azs                      = "${var.azs_primary}"
  private_subnets          = "${local.private_subnets_primary}"
  public_subnets           = "${local.public_subnets_primary}"
  enable_nat_gateway       = "${var.enable_nat_gateway}"
  single_nat_gateway       = "${var.single_nat_gateway}"
  enable_s3_endpoint       = "${var.enable_s3_endpoint}"
  enable_dynamodb_endpoint = "${var.enable_dynamodb_endpoint}"
  #tags                     = "${module.vpc_label.tags}"

  assign_generated_ipv6_cidr_block        = "${var.assign_generated_ipv6_cidr_block}"
  vpc_flowlogs_cloudwatch_destination_arn = "${data.terraform_remote_state.logging.vpc_flowlogs_primary_destination_arn}"
}

locals {
  okta_environment = "sbx"
}

# Account baseline
module "account-baseline" {
  source                 = "tfe.tlzdemo.net/TLZ-Demo/baseline-common/aws"
  version                = "~> 0.1.0"
  account_name           = "${var.name}"
  account_type           = "${var.account_type}"
  account_id             = "${var.account_id}"
  okta_provider_domain   = "${var.okta_provider_domain}"
  okta_app_id            = "${var.okta_app_id}"
  region                 = "${var.region}"
  region_secondary       = "${var.region_secondary}"
  role_name              = "${var.role_name}"
  config_logs_bucket     = "${data.terraform_remote_state.logging.s3_config_logs_bucket_name}"
  tfe_host_name          = "${var.tfe_host_name}"
  tfe_org_name           = "${var.tfe_org_name}"
  tfe_avm_workspace_name = "${var.tfe_avm_workspace_name}"
  okta_environment       = "${local.okta_environment}"
  #tags_label_context   = "${module.tlz-tagging.context}"
}

module "tlz_it_operations" {
  source            = "tfe.tlzdemo.net/TLZ-Demo/baseline-common/aws//modules/iam-tlz_it_operations"
  version           = "~> 0.1.0"
  okta_provider_arn = "${module.account-baseline.okta_provider_arn}"
  deny_policy_arns  = "${module.account-baseline.deny_policy_arns}"
  #tags_label_context   = "${module.tlz-tagging.context}"
}

# module "tlz_it_operations_okta" {
#   source           = "tfe.tlzdemo.net/TLZ-Demo/tlz_group_membership_manager/okta"
#   aws_account_id   = "${var.account_id}"
#   okta_hostname    = "${var.okta_provider_domain}"
#   tlz_account_type = "${var.account_type}"
#   user_emails      = ["${var.users_tlz_it_operations}"]
#   api_token        = "${var.okta_token}"
#   role_name        = "tlz_it_operations"
# }

module "tlz_intra_network" {
  source            = "tfe.tlzdemo.net/TLZ-Demo/baseline-common/aws//modules/iam-tlz_intra_network"
  version           = "~> 0.2.8"
  okta_provider_arn = "${module.account-baseline.okta_provider_arn}"
  deny_policy_arns  = "${module.account-baseline.deny_policy_arns}"
  #tags_label_context   = "${module.tlz-tagging.context}"
}

# module "tlz_intra_network_okta" {
#   source           = "tfe.tlzdemo.net/TLZ-Demo/tlz_group_membership_manager/okta"
#   aws_account_id   = "${var.account_id}"
#   okta_hostname    = "${var.okta_provider_domain}"
#   tlz_account_type = "${var.account_type}"
#   user_emails      = ["${var.users_tlz_intra_network}"]
#   api_token        = "${var.okta_token}"
#   role_name        = "tlz_intra_network"
# }

module "tlz_admin" {
  source            = "tfe.tlzdemo.net/TLZ-Demo/baseline-common/aws//modules/iam-tlz_admin"
  version           = "~> 0.1.0"
  okta_provider_arn = "${module.account-baseline.okta_provider_arn}"
  okta_environment  = "${local.okta_environment}"
  deny_policy_arns  = "${module.account-baseline.deny_policy_arns}"
  #tags_label_context   = "${module.tlz-tagging.context}"
}

# module "tlz_admin_okta" {
#   source           = "tfe.tlzdemo.net/TLZ-Demo/tlz_group_membership_manager/okta"
#   aws_account_id   = "${var.account_id}"
#   okta_hostname    = "${var.okta_provider_domain}"
#   tlz_account_type = "${var.account_type}"
#   user_emails      = ["${var.users_tlz_admin}"]
#   api_token        = "${var.okta_token}"
#   role_name        = "tlz_admin"
# }

module "tlz_developer" {
  source            = "tfe.tlzdemo.net/TLZ-Demo/baseline-common/aws//modules/iam-tlz_developer"
  version           = "~> 0.1.0"
  okta_provider_arn = "${module.account-baseline.okta_provider_arn}"
  okta_environment  = "${local.okta_environment}"
  region            = "${var.region}"
  region_secondary  = "${var.region_secondary}"
  deny_policy_arns  = "${module.account-baseline.deny_policy_arns}"
  #tags_label_context   = "${module.tlz-tagging.context}"
}

# module "tlz_developer_okta" {
#   source           = "tfe.tlzdemo.net/TLZ-Demo/tlz_group_membership_manager/okta"
#   aws_account_id   = "${var.account_id}"
#   okta_hostname    = "${var.okta_provider_domain}"
#   tlz_account_type = "${var.account_type}"
#   user_emails      = ["${var.users_tlz_developer}"]
#   api_token        = "${var.okta_token}"
#   role_name        = "tlz_developer"
# }

module "tlz_developer_ro" {
  source            = "tfe.tlzdemo.net/TLZ-Demo/baseline-common/aws//modules/iam-tlz_developer_ro"
  version           = "~> 0.1.0"
  okta_provider_arn = "${module.account-baseline.okta_provider_arn}"
  #tags_label_context   = "${module.tlz-tagging.context}"
}

# module "tlz_developer_ro_okta" {
#   source           = "tfe.tlzdemo.net/TLZ-Demo/tlz_group_membership_manager/okta"
#   aws_account_id   = "${var.account_id}"
#   okta_hostname    = "${var.okta_provider_domain}"
#   tlz_account_type = "${var.account_type}"
#   user_emails      = ["${var.users_tlz_developer_ro}"]
#   api_token        = "${var.okta_token}"
#   role_name        = "tlz_developer_ro"
# }

module "iam-user-terraform_svc" {
  source                = "tfe.tlzdemo.net/TLZ-Demo/baseline-common/aws//modules/iam-user-tlz_svc_user"
  version               = "~> 0.2.8"
  user_name             = "${var.terraform_service_user}"
  #tags_label_context   = "${module.tlz-tagging.context}"
}

module "tlz_security_ir" {
  source                  = "tfe.tlzdemo.net/TLZ-Demo/baseline-common/aws//modules/iam-policy-securityir"
  version                 = "~> 0.2.8"
  okta_provider_arn       = "${module.account-baseline.okta_provider_arn}"
  #tags_label_context    = "${module.tlz-tagging.context}"
}