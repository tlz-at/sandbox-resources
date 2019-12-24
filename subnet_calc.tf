####
# This calculates the subnet IP space based on the CIDR values passed for the
# primary and secondary VPCs
#
# It will break the main block into four smaller blocks, with the first three
# allocated to private and the fourth broken up again into four with the first
# three allocated to public
#
# The final fourth small block is left as spare
####

locals {
  private_subnets_primary = [
    "${cidrsubnet("${var.cidr_primary}", 2, 0 )}",
    "${cidrsubnet("${var.cidr_primary}", 2, 1 )}",
    "${cidrsubnet("${var.cidr_primary}", 2, 2 )}",
  ]

  private_subnets_secondary = [
    "${cidrsubnet("${var.cidr_secondary}", 2, 0 )}",
    "${cidrsubnet("${var.cidr_secondary}", 2, 1 )}",
    "${cidrsubnet("${var.cidr_secondary}", 2, 2 )}",
  ]

  cidr_primary_public   = "${cidrsubnet("${var.cidr_primary}", 2, 3 )}"
  cidr_secondary_public = "${cidrsubnet("${var.cidr_secondary}", 2, 3 )}"

  public_subnets_primary = [
    "${cidrsubnet("${local.cidr_primary_public}", 2, 0 )}",
    "${cidrsubnet("${local.cidr_primary_public}", 2, 1 )}",
    "${cidrsubnet("${local.cidr_primary_public}", 2, 2 )}",
  ]

  public_subnets_secondary = [
    "${cidrsubnet("${local.cidr_secondary_public}", 2, 0 )}",
    "${cidrsubnet("${local.cidr_secondary_public}", 2, 1 )}",
    "${cidrsubnet("${local.cidr_secondary_public}", 2, 2 )}",
  ]

  spare_primary_cidr   = "${cidrsubnet("${local.cidr_primary_public}", 2, 3 )}"
  spare_secondary_cidr = "${cidrsubnet("${local.cidr_secondary_public}", 2, 3 )}"
}