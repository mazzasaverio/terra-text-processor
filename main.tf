
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
  source             = "./modules/mongodb_atlas"
  atlas_org_id       = var.mongo_atlas_org_id
  atlas_project_name = var.mongo_atlas_project_name
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
  # gcp_project_id = var.gcp_project_id
  # gcp_network_name           = var.gcp_network_name
  # atlas_cidr_block           = var.atlas_cidr_block
  # kafka_server_endpoint      = module.kafka.kafka_bootstrap_servers
  # confluent_kafka_topic      = var.confluent_kafka_topic
  # storage_bucket_name        = module.storage.bucket_name
  # confluent_cloud_api_key    = var.confluent_cloud_api_key
  # confluent_cloud_api_secret = var.confluent_cloud_api_secret
  # google_credentials_file    = var.google_credentials_file
}


