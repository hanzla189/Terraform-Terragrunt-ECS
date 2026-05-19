locals {
  project         = "vouch"
  aws_region      = get_env("AWS_REGION", "eu-west-1")
  tf_state_bucket = get_env("TF_STATE_BUCKET", "vouch-terraform-state")
  tf_lock_table   = get_env("TF_LOCK_TABLE", "vouch-terraform-locks")
}

remote_state {
  backend = "s3"

  config = {
    bucket         = local.tf_state_bucket
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    encrypt        = true
    dynamodb_table = local.tf_lock_table
  }

  generate = {
    path      = "backend.generated.tf"
    if_exists = "overwrite_terragrunt"
  }
}

generate "provider" {
  path      = "providers.generated.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOT
provider "aws" {
  region = "${local.aws_region}"

  default_tags {
    tags = {
      Project   = "${local.project}"
      ManagedBy = "terraform"
      Owner     = "devops"
    }
  }
}
EOT
}
