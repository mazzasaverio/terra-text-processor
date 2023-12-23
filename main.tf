
/* -------------------------------------------------------------------------- */
/*                                  PROVIDERS                                 */
/* -------------------------------------------------------------------------- */

provider "google" {
  credentials = file(var.google_credentials_file)
  project     = var.gcp_project_id
  region      = var.region
  zone        = var.zone
}

terraform {
  required_providers {
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
    }
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.56.0"
    }
  }
  required_version = ">= 0.13"
}

provider "mongodbatlas" {
  public_key  = var.mongodb_atlas_public_key
  private_key = var.mongodb_atlas_private_key
}

/* -------------------------------------------------------------------------- */
/*                                   MODULES                                  */
/* -------------------------------------------------------------------------- */

module "storage" {
  source          = "./modules/storage"
  region          = var.region
  gcp_project_id  = var.gcp_project_id
  gcp_bucket_name = var.gcp_bucket_name
}



module "mongodb_atlas" {
  source             = "./modules/mongodb_atlas"
  atlas_org_id       = var.atlas_org_id
  atlas_project_name = var.atlas_project_name
}
