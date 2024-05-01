terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "0.63.0"
    }
  }

  backend "s3" {
    bucket         = "gatekeeper-hcl"
    key            = "AKIA2NVA2PUDZFC4FU5O"
    region         = "us-east-1"
    # Optional DynamoDB for state locking. See https://developer.hashicorp.com/terraform/language/settings/backends/s3 for details.
    # dynamodb_table = "terraform-state-lock-table"
    encrypt        = true
    role_arn       = "arn:aws:iam::716523076871:role/<terraform-s3-backend-access-role>"
  }
}

provider "snowflake" {
  username    = "sivakumar_palanisamy"
  account     = "https//hcl_partner.snowflakecomputing.com:443/?"
  role        = "DB_ADMIN_US"
  private_key = var.snowflake_private_key
}

module "snowflake_resources" {
  source              = "../modules/snowflake_resources"
  time_travel_in_days = 30
  database            = var.database
  env_name            = var.env_name
}
