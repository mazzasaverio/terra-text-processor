
/* -------------------------------------------------------------------------- */
/*                                  PROVIDERS                                 */
/* -------------------------------------------------------------------------- */

provider "google" {
  credentials = file(var.gcp_credentials_file)
  project     = var.gcp_project_id
  region      = var.gcp_region
  zone        = var.gcp_zone
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

provider "confluent" {
  cloud_api_key    = var.confluent_cloud_api_key
  cloud_api_secret = var.confluent_cloud_api_secret
}


provider "mongodbatlas" {
  public_key  = var.mongo_atlas_public_key
  private_key = var.mongo_atlas_private_key
}

/* -------------------------------------------------------------------------- */
/*                                   MODULES                                  */
/* -------------------------------------------------------------------------- */

module "storage" {
  source          = "./modules/storage"
  region          = var.gcp_region
  gcp_project_id  = var.gcp_project_id
  gcp_bucket_name = var.gcp_bucket_name
}

module "mongodb_atlas" {
  source                           = "./modules/mongodb_atlas"
  mongo_atlas_org_id               = var.mongo_atlas_org_id
  mongo_atlas_project_name         = var.mongo_atlas_project_name
  mongo_atlas_db_username          = var.mongo_atlas_db_username
  mongo_atlas_db_password          = var.mongo_atlas_db_password
  mongo_atlas_cidr_block           = var.mongo_atlas_cidr_block
  gcp_project_id                   = var.gcp_project_id
  mongo_atlas_region               = var.mongo_atlas_region
  mongo_cluster_instance_size_name = var.mongo_cluster_instance_size_name
  # my_ip_cidr_block       = var.my_ip_cidr_block
}



module "kafka" {
  source                     = "./modules/kafka"
  confluent_cloud_api_key    = var.confluent_cloud_api_key
  confluent_cloud_api_secret = var.confluent_cloud_api_secret
  confluent_environment_name = var.confluent_environment_name
  confluent_cluster_name     = var.confluent_cluster_name
  confluent_availability     = var.confluent_availability
  confluent_cloud            = var.confluent_cloud
  gcp_region                 = var.gcp_region
  gcp_project_id             = var.gcp_project_id
  gcp_network_name           = var.gcp_network_name
  confluent_kafka_topic      = var.confluent_kafka_topic


}



# module "cloudrun" {
#   source                    = "./modules/cloudrun"
#   gcp_region                = var.gcp_region
#   gcp_text_extraction_image = "gcr.io/${var.gcp_project_id}/text-extraction:latest"
#   gcp_service_account_email = var.gcp_service_account_email
#   gcp_project_id            = var.gcp_project_id
# }

# output "cloud_run_service_url" {
#   value       = module.cloudrun.service_url
#   description = "The URL of the Cloud Run service"
# }
