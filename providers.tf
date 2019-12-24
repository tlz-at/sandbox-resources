# Default provider
provider "aws" {
  region = "${var.region}"

  assume_role {
    role_arn = "${local.assume_role_arn}"
  }
}

data "aws_caller_identity" "current" {}

locals {
  assume_role_arn = "arn:aws:iam::${var.account_id}:role/${var.role_name}"
}

# Provider connections for all regions
provider "aws" {
  region = "${var.region_secondary}"
  alias  = "secondary"

  assume_role {
    role_arn = "${local.assume_role_arn}"
  }
}

provider "aws" {
  region = "ap-northeast-1"
  alias  = "ap-northeast-1"

  assume_role {
    role_arn = "${local.assume_role_arn}"
  }
}

provider "aws" {
  region = "ap-northeast-2"
  alias  = "ap-northeast-2"

  assume_role {
    role_arn = "${local.assume_role_arn}"
  }
}

provider "aws" {
  region = "ap-south-1"
  alias  = "ap-south-1"

  assume_role {
    role_arn = "${local.assume_role_arn}"
  }
}

provider "aws" {
  region = "ap-southeast-1"
  alias  = "ap-southeast-1"

  assume_role {
    role_arn = "${local.assume_role_arn}"
  }
}

provider "aws" {
  region = "ap-southeast-2"
  alias  = "ap-southeast-2"

  assume_role {
    role_arn = "${local.assume_role_arn}"
  }
}

provider "aws" {
  region = "ca-central-1"
  alias  = "ca-central-1"

  assume_role {
    role_arn = "${local.assume_role_arn}"
  }
}

provider "aws" {
  region = "eu-central-1"
  alias  = "eu-central-1"

  assume_role {
    role_arn = "${local.assume_role_arn}"
  }
}

provider "aws" {
  region = "eu-west-1"
  alias  = "eu-west-1"

  assume_role {
    role_arn = "${local.assume_role_arn}"
  }
}

provider "aws" {
  region = "eu-west-2"
  alias  = "eu-west-2"

  assume_role {
    role_arn = "${local.assume_role_arn}"
  }
}

provider "aws" {
  region = "eu-west-3"
  alias  = "eu-west-3"

  assume_role {
    role_arn = "${local.assume_role_arn}"
  }
}

provider "aws" {
  region = "sa-east-1"
  alias  = "sa-east-1"

  assume_role {
    role_arn = "${local.assume_role_arn}"
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "us-east-1"

  assume_role {
    role_arn = "${local.assume_role_arn}"
  }
}

provider "aws" {
  region = "us-east-2"
  alias  = "us-east-2"

  assume_role {
    role_arn = "${local.assume_role_arn}"
  }
}

provider "aws" {
  region = "us-west-1"
  alias  = "us-west-1"

  assume_role {
    role_arn = "${local.assume_role_arn}"
  }
}

provider "aws" {
  region = "us-west-2"
  alias  = "us-west-2"

  assume_role {
    role_arn = "${local.assume_role_arn}"
  }
}